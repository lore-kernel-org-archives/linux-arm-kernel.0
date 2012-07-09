From: pavel@denx.de (Pavel Machek)
Date: Mon, 9 Jul 2012 13:52:04 +0200
Subject: [RFC PATCHv1 1/2] ARM: socfpga: initial support for Altera's
 SOCFPGA platform.
In-Reply-To: <4FF483D2.70000@gmail.com>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <1340805007-3313-2-git-send-email-dinguyen@altera.com>
 <4FF483D2.70000@gmail.com>
Message-ID: <20120709115204.GC12130@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!


> > diff --git a/arch/arm/mach-socfpga/include/mach/memory.h b/arch/arm/mach-socfpga/include/mach/memory.h
> > new file mode 100644
> > index 0000000..88e0ae9
> > +#ifndef __ASM_ARCH_MEMORY_H
> > +#define __ASM_ARCH_MEMORY_H
> > +
> > +/*
> > + * Physical DRAM offset.
> > + */
> > +#define PLAT_PHYS_OFFSET	UL(0x00000000)
> > +
> > +#if !defined(__ASSEMBLY__) && defined(CONFIG_ZONE_DMA)
> > +
> > +#define ISA_DMA_THRESHOLD	(PHYS_OFFSET + SZ_256M - 1)
> > +#define MAX_DMA_ADDRESS		(PAGE_OFFSET + SZ_256M)
> > +#endif
> 
> You shouldn't need memory.h.

Yep. Deleting it was easier than expected. Thanks.
									Pavel
									
commit 39edfa179a37d38352b21894fbd9b559e52dcf31
Author: Pavel <pavel@ucw.cz>
Date:   Mon Jul 9 13:48:27 2012 +0200

    Remove memory.h/system.h.
    
    Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ab3b389..8e69b05 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -261,7 +261,6 @@ config ARCH_SOCFPGA
 	select GENERIC_CLOCKEVENTS
 	select HAVE_MACH_CLKDEV
 	select MIGHT_HAVE_CACHE_L2X0
-	select NEED_MACH_MEMORY_H
 	select SPARSE_IRQ
 	select USE_OF
 	help
diff --git a/arch/arm/mach-socfpga/include/mach/memory.h b/arch/arm/mach-socfpga/include/mach/memory.h
deleted file mode 100644
index e69de29..0000000
diff --git a/arch/arm/mach-socfpga/include/mach/system.h b/arch/arm/mach-socfpga/include/mach/system.h
deleted file mode 100644
index e69de29..0000000

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
