#!/bin/bash

# check what distro we are running.

getdistro()
{
_DISTRO=`lsb_release -i -s`
_CODENAME=`lsb_release -c -s`
case "$_DISTRO" in
    "Ubuntu")
        export DISTRO="ubuntu"
        export CODENAME=$_CODENAME
        case "$_CODENAME" in
            "trusty") ;;
            "utopic") ;;
            *) 
            exit 0
               ;;
        esac
        ;;
    "Debian")
        export DISTRO="debian"
        export CODENAME=$_CODENAME
        case "$_CODENAME" in
            "wheezy") ;;
            *) 
            exit 0
               ;;
        esac
        ;;
    "CentOS")
        exit 0
        ;;
    *)
        echo "We do not currently support your distribution."
        echo "Currently Supported: Ubuntu or Debian"
        echo "distro info: "
        lsb_release -a
        exit 0
        ;;
esac
}

install_prereqs() 
{

    case "$DISTRO" in
        "ubuntu")
                if [ $CODENAME = 'precise' ]; then
                   sudo echo "foreign-architecture i386" > /etc/dpkg/dpkg.cfg.d/multiarch 
                 CASE=1 
sudo apt-get -y update 
             sudo apt-get -y install libc6:i386 libncurses5:i386 libstdc++6:i386 zlib1g:i386 libkrb5-dev:i386 libexpat-dev:i386 libqtcore4:i386 libqt4-sql:i386 libpq-dev:i386 libqt4-gui:i386 libqt4-xml:i386

                else
                
                   sudo dpkg --add-architecture i386
sudo apt-get -y update
             sudo apt-get -y install libc6:i386 libncurses5:i386 libstdc++6:i386 zlib1g:i386 libkrb5-dev:i386 libexpat-dev:i386 libqtcore4:i386 libqt4-sql:i386 libpq-dev:i386 libqt4-gui:i386 libqt4-xml:i386


                CASE=2
                fi
                 RET=$?
                
                if [ $RET -eq 1 ]; then
					
					exit 0
                    
                       fi
                ;;
        "debian")
        
	echo "It's debian..."
       
                RET=$?
                if [ $RET -eq 1 ]; then
					
					exit 0
					  
					  fi
                ;;
         "centos")
         
                exit 0
                
                ;;
        *)
        log "Shouldn't reach here! Please report this on GitHub."
        exit 0
        ;;
    esac

}

getdistro
install_prereqs

exit 0
