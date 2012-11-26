From: bevenson@melinkcorp.com (Bryan Evenson)
Date: Mon, 26 Nov 2012 17:09:46 -0500
Subject: Help building 3.x kernel for AT91SAM9x5
In-Reply-To: <91586D499ADFD74FBCFB8425266A5DE40137631A48C0@pluto.melinkcorp.local>
References: <91586D499ADFD74FBCFB8425266A5DE40137631A48C0@pluto.melinkcorp.local>
Message-ID: <91586D499ADFD74FBCFB8425266A5DE40137659736F1@pluto.melinkcorp.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Offline I was directed to this set of instructions: http://www.eewiki.net/display/linuxonarm/AT91SAM9x5.  With this I'm able to build a set of files that boots on the SAM9G25-EK from the SD card.  I'm now trying to modify the steps to boot from NAND flash and I'm having problems.

I have the kernel setup so that it outputs a uImage file suitable for booting from NAND flash and burned it to flash just like I have in the past.  During boot, I get the following output:

    NAND read: device 0 offset 0x200000, size 0x250000                              
     2424832 bytes read: OK                                                         
    ## Booting kernel from Legacy Image at 22000000 ...                             
       Image Name:   Linux-3.7.0-rc5-armv5-x0.10                                    
       Image Type:   ARM Linux Kernel Image (uncompressed)                          
       Data Size:    1770360 Bytes = 1.7 MiB                                        
       Load Address: 20008000                                                       
       Entry Point:  20008000                                                       
       Verifying Checksum ... OK                                                    
       Loading Kernel Image ... OK                                                  
    OK                                                                              
                                                                                
    Starting kernel ...                                                             
                                                                                
    Uncompressing Linux... done, booting the kernel.

... and then the system hangs.  At this point I'm at a loss as to what is failing.  My assumption is there is something device tree related that is not properly loaded onto flash, but since I have not worked with the device tree setup before I don't know what to check.  Any help (even redirection to a more appropriate list) would be greatly appreciated.

Thanks,
Bryan

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Bryan Evenson
> Sent: Tuesday, November 20, 2012 8:37 AM
> To: linux-arm-kernel at lists.infradead.org
> Subject: Help building 3.x kernel for AT91SAM9x5
> 
> All,
> 
> I have a AT91SAM9G25 board that I have been using with the 2.6.39
> kernel and the Atmel supported patches for this kernel using the
> classic Open Embedded development tree.  I need to move to a 3.x kernel
> to incorporate the AT91 ADC driver and the bug fixes for the RS-485
> interface (so I would probably need 3.5 or later).  However, all
> attempts I have made at building a 3.x kernel for the AT91SAM9G25 have
> failed to produce a bootable kernel image.  I have tried modifying the
> OE kernel recipe to utilize a 3.x kernel and I have tried using the
> Yocto Project tools to build a custom BSP, both of which have failed no
> matter how I tweak the setup.  Each attempt ends in the same results;
> U-Boot unpacks the kernel, jumps to the start of the kernel and then
> the system hangs.  I am looking for assistance in getting a 3.x kernel
> booting on this device.  I have tried getting help from the Atmel Linux
> forums and the Yocto Project forums and have not yet had success, so I
> decided to move closer to the source.
> 
> If anyone can offer assistance in getting a bootable 3.x kernel for the
> AT91SAM9G25 I would greatly appreciate it.  I would prefer pointers in
> how to modify a Bitbake kernel recipe for use with OE or the Yocto
> Project, but instructions on how to build this kernel with CodeSourcery
> would also be helpful.
> 
> Once I get my system up and running, if there SAM9x5 kernel features
> that need to be tested I would gladly help with testing.
> 
> Thanks,
> Bryan Evenson
> 
> 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
