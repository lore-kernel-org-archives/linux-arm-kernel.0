From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 5 Jun 2010 19:19:17 +0200
Subject: pxa300 - DDRAM base value
In-Reply-To: <1275371058.7001.35.camel@balakrishnan-desktop>
References: <1275371058.7001.35.camel@balakrishnan-desktop>
Message-ID: <201006051919.17738.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 1. ?ervna 2010 07:44:18 balakrishnan napsal(a):
> I am working on pxa300 based development board and using Linux 2.6.34.
> This Linux kernel already has support for following boards
> 1. zylonite_pxa300
> 2. cm-x300
> 3. colibri-pxa300
> 4. littleton
> 
> My doubt is that pxa300 based boards are using "0xa0000000"  as DDRAM
> base and PHYS_OFFSET is also defined in
> "arch/arm/mach-pxa/include/mach/memory.h" as 0xa0000000.
> But in our board  DDR is mapped in 0x80000000. Does it make any
> problem?. Because after mmu is turned ON, my board is hanging.
> 
> "zreladdr-y   := 0x80008000" is defined in
> "arch/arm/mach-pxa/Makefile.boot" file .
> my machine_desc is as follows
> .phys_io        = 0x40000000,
> .io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
> .boot_params    = 0x80000100,
> 

Try editing both arch/arm/mach-pxa/Makefile.boot and 
arch/arm/mach/pxa/include/mach/memory.h

> With Thanks
> J.Balakrishnan

The 0x80000000 should be aliased to 0xa0000000, but looking into the PXA docs, 
it is only on pxa320. Eric, any ideas on this ?
