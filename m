From: balakrishnan@e-consystems.com (balakrishnan)
Date: Tue, 01 Jun 2010 11:14:18 +0530
Subject: pxa300 - DDRAM base value
Message-ID: <1275371058.7001.35.camel@balakrishnan-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am working on pxa300 based development board and using Linux 2.6.34.
This Linux kernel already has support for following boards
1. zylonite_pxa300
2. cm-x300 
3. colibri-pxa300
4. littleton

My doubt is that pxa300 based boards are using "0xa0000000"  as DDRAM
base and PHYS_OFFSET is also defined in
"arch/arm/mach-pxa/include/mach/memory.h" as 0xa0000000.
But in our board  DDR is mapped in 0x80000000. Does it make any
problem?. Because after mmu is turned ON, my board is hanging. 

"zreladdr-y   := 0x80008000" is defined in
"arch/arm/mach-pxa/Makefile.boot" file .
my machine_desc is as follows 
.phys_io        = 0x40000000, 
.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,  
.boot_params    = 0x80000100,  

With Thanks
J.Balakrishnan 
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100601/dd4a8178/attachment-0001.htm>
