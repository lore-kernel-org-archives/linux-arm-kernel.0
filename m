From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 22 Feb 2011 21:01:06 +0100
Subject: [PATCH] ARM: Fix compile after delay page freeing patch
In-Reply-To: <4D6413D9.7080906@ru.mvista.com>
References: <20110222194332.GQ15225@atomide.com>
	<4D6413D9.7080906@ru.mvista.com>
Message-ID: <20110222200105.GD22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 22, 2011 at 10:51:53PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> Tony Lindgren wrote:
> 
> >Commit 06824ba824b3e9f2fedb38bee79af0643198ed7f
> >(ARM: tlb: delay page freeing for SMP and ARMv7 CPUs) causes
> >the following compile error for at least omap1_defconfig:
I't not omap1_defconfig only, see

	http://armlinux.simtec.co.uk/kautobuild/2.6.38-rc5-git6/index.html
 
> >In file included from arch/arm/mm/init.c:27:
> >arch/arm/include/asm/tlb.h: In function 'tlb_flush_mmu':
> >arch/arm/include/asm/tlb.h:101: error: implicit declaration of function 'release_pages'
> >arch/arm/include/asm/tlb.h: In function 'tlb_remove_page':
> >arch/arm/include/asm/tlb.h:165: error: implicit declaration of function 'page_cache_release'
> >
> >Fix this by including pagemap.h.
> >
> >Signed-off-by: Tony Lindgren <tony@atomide.com>
> >
> >--- a/arch/arm/mm/init.c
> >+++ b/arch/arm/mm/init.c
> >@@ -19,6 +19,7 @@
> > #include <linux/gfp.h>
> > #include <linux/memblock.h>
> > #include <linux/sort.h>
> >+#include <linux/pagemap.h>
> > #include <asm/mach-types.h>
> > #include <asm/sections.h>
> 
>    Shouldn't you be #including it into tlb.h instead?
For me building arch/arm/mm/mmu.o fails, too.  So Tony's patch doesn't
help.

Adding the #include to arch/arm/include/asm/tlb.h works fine though.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
