From: Bo.Liu@windriver.com (Tonyliu)
Date: Mon, 18 Jan 2010 16:39:27 +0800
Subject: Kernel Start-up Time
In-Reply-To: <201001181010.01975.caglarakyuz@gmail.com>
References: <201001181010.01975.caglarakyuz@gmail.com>
Message-ID: <4B541E3F.9040205@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Caglar Akyuz wrote:
> Hello,
>
> While measuring Linux start-up time, I see that printing version string in 
> "start_kernel" takes ~1.3 seconds. I guess this is the time between from 
> "bootloader jumping to uImage" and "printing version string in generic 
> start_kernel code". Relevant part of my boot log is attached.
>   
> My question: is it normal this 1.3 sec init time? My system is 297 MHZ 
> arm926ej-s with a 162MHZ DDR2 memory.
>   

It depends on where you start to measure it?
    Starting from when power is turned on.
    Starting from when the first instruction executes.
    Start from the bootloader tries to load the kernel image.
...
I think this type of mearsurement  makes no much sense to you, since 
normally
people want to know
   When the kernel loads userspace or
    When the first app starts to run.

These are more meaningful for specific product.

Tony

> Sorry for my ignorance but I'm not good at ARM assembly, so I'm unable to 
> bench early boot.
>
> Thanks,
> Caglar
>
> _____________________________________________________________________ 
>
> [    4.390970] Bytes transferred = 3349376 (331b80 hex)                                                                                                                             
> [    4.663038] ## Booting kernel from Legacy Image at 80700000 ...                                                                                                                  
> [    4.668940]    Image Name:   Linux-2.6.30-davinci1-06079-g4e7                                                                                                                    
> [    4.672999]    Image Type:   ARM Linux Kernel Image (uncompressed)                                                                                                               
> [    4.677999]    Data Size:    3349312 Bytes =  3.2 MB                                                                                                                             
> [    4.681965]    Load Address: 80008000                                                                                                                                            
> [    4.684007]    Entry Point:  80008000                                                                                                                                            
> [    4.686043]    Loading Kernel Image ... OK                                                                                                                                       
> [    4.696911] OK                                                                                                                                                                   
> [    4.700878]                                                                                                                                                                      
> [    4.700896] Starting kernel ...                                                                                                                                                  
> [    4.702971]                                                                                                                                                                      
> [    5.966039] [    0.000000] Linux version 2.6.30-davinci1-06079-g4e73fae-
> dirty (caglar at ycaserv) (gcc version 4.3.3 (GCC) ) #393 PREEMPT Mon Jan 18 
> 10:03:47 EET 2010              
> [    5.979054] [    0.000000] CPU: ARM926EJ-S [41069265] revision 5 
> (ARMv5TEJ), cr=00053177                                                                                         
> [    5.985952] [    0.000000] CPU: VIVT data cache, VIVT instruction cache
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>   


-- 
Tony Liu | Liu Bo
-------------------------------------------------------------
WIND RIVER | China Development Center
Tel: 86-10-8477-8542 ext: 8542 |  Fax: 86-10-64790367
(M): 86-136-7117-3612
Address: 15/F, Wangjing TowerB, Chaoyang District, Beijing, P.R.China
