From: caglarakyuz@gmail.com (Caglar Akyuz)
Date: Mon, 18 Jan 2010 10:10:01 +0200
Subject: Kernel Start-up Time
Message-ID: <201001181010.01975.caglarakyuz@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

While measuring Linux start-up time, I see that printing version string in 
"start_kernel" takes ~1.3 seconds. I guess this is the time between from 
"bootloader jumping to uImage" and "printing version string in generic 
start_kernel code". Relevant part of my boot log is attached.

My question: is it normal this 1.3 sec init time? My system is 297 MHZ 
arm926ej-s with a 162MHZ DDR2 memory.

Sorry for my ignorance but I'm not good at ARM assembly, so I'm unable to 
bench early boot.

Thanks,
Caglar

_____________________________________________________________________ 

[    4.390970] Bytes transferred = 3349376 (331b80 hex)                                                                                                                             
[    4.663038] ## Booting kernel from Legacy Image at 80700000 ...                                                                                                                  
[    4.668940]    Image Name:   Linux-2.6.30-davinci1-06079-g4e7                                                                                                                    
[    4.672999]    Image Type:   ARM Linux Kernel Image (uncompressed)                                                                                                               
[    4.677999]    Data Size:    3349312 Bytes =  3.2 MB                                                                                                                             
[    4.681965]    Load Address: 80008000                                                                                                                                            
[    4.684007]    Entry Point:  80008000                                                                                                                                            
[    4.686043]    Loading Kernel Image ... OK                                                                                                                                       
[    4.696911] OK                                                                                                                                                                   
[    4.700878]                                                                                                                                                                      
[    4.700896] Starting kernel ...                                                                                                                                                  
[    4.702971]                                                                                                                                                                      
[    5.966039] [    0.000000] Linux version 2.6.30-davinci1-06079-g4e73fae-
dirty (caglar at ycaserv) (gcc version 4.3.3 (GCC) ) #393 PREEMPT Mon Jan 18 
10:03:47 EET 2010              
[    5.979054] [    0.000000] CPU: ARM926EJ-S [41069265] revision 5 
(ARMv5TEJ), cr=00053177                                                                                         
[    5.985952] [    0.000000] CPU: VIVT data cache, VIVT instruction cache
