#!/bin/bash

#Thanks for choosing spiderport.
#This script created by yellowspider🕷️.
#This script performs a TCP port scan on a target IP address over a specified port range.

#Features:
#		-Uses `nc` (netcat) for scanning and saves the results in a file named scan_<IP>.txt.
#		- Displays the total number of open ports found.

# Usage:
#   	- Run the script and enter the target IP and port range .
# 		- View the scan results in the generated `scan_<IP>.txt` file.



#banner
banner(){
echo -e "\e[32m	
														
  ██████  ██▓███   ██▓▓█████▄ ▓█████  ██▀███   ██▓███   ▒█████   ██▀███  ▄▄▄█████▓
▒██    ▒ ▓██░  ██▒▓██▒▒██▀ ██▌▓█   ▀ ▓██ ▒ ██▒▓██░  ██▒▒██▒  ██▒▓██ ▒ ██▒▓  ██▒ ▓▒
░ ▓██▄   ▓██░ ██▓▒▒██▒░██   █▌▒███   ▓██ ░▄█ ▒▓██░ ██▓▒▒██░  ██▒▓██ ░▄█ ▒▒ ▓██░ ▒░
  ▒   ██▒▒██▄█▓▒ ▒░██░░▓█▄   ▌▒▓█  ▄ ▒██▀▀█▄  ▒██▄█▓▒ ▒▒██   ██░▒██▀▀█▄  ░ ▓██▓ ░ 
▒██████▒▒▒██▒ ░  ░░██░░▒████▓ ░▒████▒░██▓ ▒██▒▒██▒ ░  ░░ ████▓▒░░██▓ ▒██▒  ▒██▒ ░ 
▒ ▒▓▒ ▒ ░▒▓▒░ ░  ░░▓   ▒▒▓  ▒ ░░ ▒░ ░░ ▒▓ ░▒▓░▒▓▒░ ░  ░░ ▒░▒░▒░ ░ ▒▓ ░▒▓░  ▒ ░░   
░ ░▒  ░ ░░▒ ░      ▒ ░ ░ ▒  ▒  ░ ░  ░  ░▒ ░ ▒░░▒ ░       ░ ▒ ▒░   ░▒ ░ ▒░    ░    
░  ░  ░  ░░        ▒ ░ ░ ░  ░    ░     ░░   ░ ░░       ░ ░ ░ ▒    ░░   ░   ░      
      ░            ░     ░       ░  ░   ░                  ░ ░     ░              
                       ░                                                          
	*******************************************************
		 🕷️ Welcome To 𝖘𝖕𝖎𝖉𝖊𝖗𝖕𝖔𝖗𝖙 $ver🕷️
		   🕷️ Built by yellowspider🕷️
	********************************************************	\e[0m"      
echo                                     
}

#input valideations through switches


if [[ "$2" == "-p" && "$4" == "-e"  ]]; then
	targip=$1
	sport=$3
	eport=$5
elif [[ "$2" == "-p"  ]]; then
	targip=$1
	sport=$3
	eport=$3
elif [[ "$1" == "-h" ]];then
	banner
	echo -e "	Welcome to help menu for spider port
	\e[32m***************************************\e[0m"
	echo
	echo -e "\e[32m-h\e[0m	: help menu"
	echo -e "\e[32m-p	\e[0m: starting /single port number"
	echo -e "\e[32m-e	\e[0m: ending port number"
	echo -e "\e[32musage\e[0m"	
	echo "	 $0 [target_ip] -p [starting_port] -e [ending_port] "
	echo "	 $0 [target_ip] -p [single_port]"
	echo "	 $0 -h "
	exit 1

else
	banner
	echo -e "\e[32musage\e[0m"
	echo "	 $0 [target_ip] -p [starting_port] -e [ending_port] "
	echo "	 $0 [target_ip] -p [single_port]"
	echo "	 $0 -h "
	exit 1
	
fi


#version
ver=v2.25.3



banner		



#input details
input(){ echo "$1" 
read -p "Enter target ip:" targip
read -p "Starting prot number:" sport 
read -p "Ending port number:" eport
}

#scanning
port_scanning(){
output="scan_${targip}.txt"
echo
echo
echo "starting port scan for $targip "
echo
nc -zv $targip $sport-$eport > $output 2>&1
}

port_scanning

error(){
#filteringout error
sed -e 's/(UNKNOWN)//g' -e 's/\[//g' -e 's/\]//g' $output > temp.txt && mv temp.txt $output
}
error



#output
out(){
cat $output | sed 's/open/\x1b[32mopen\x1b[0m/g'
echo
grep "open" -i $output | wc -l > open.txt
echo
echo -e "found \e[32m$(cat open.txt)\e[0m open ports on $targip....." 
rm open.txt
echo
echo "result saved into $output"
echo 
echo -e "scanning complete......................."
echo
echo -e	"\e[32m***********************************\e[0m"
echo
}
out


#close script

close(){
echo -e " 		🕷️\e[32m Thanks for using spiderport $ver\e[0m"🕷️
echo -e "	\e[32m********************************************************\e[0m"
}


#continue wtih scan for another target
another(){
read -p $'\e[32m do you want to scan another target?(y/n): \e[0m' yn
	echo
yn=$(echo "$yn" | tr '[:upper:]' '[:lower:]') #to fix case error
if [[ "$yn" == "y" ]];then
	echo	
	echo -e "\e[32mstarting new scan_________\e[0m"
	echo
	
	banner #restarting the script for new scan
	input 
	port_scanning
	error
	out
	another
	
else
	close
fi
}
another




