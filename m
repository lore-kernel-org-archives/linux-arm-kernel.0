From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 20 Jan 2015 20:58:10 +0900
Subject: [PATCH 02/03] ARM: shmobile: Remove mach/clkdev.h
In-Reply-To: <20150120115750.11479.95109.sendpatchset@little-apple>
References: <20150120115750.11479.95109.sendpatchset@little-apple>
Message-ID: <20150120115810.11479.53290.sendpatchset@little-apple>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Move over ARCH_SHMOBILE_LEGACY to use the default legacy ARM
implementations of __clk_get() and __clk_put() in <asm/clkdev.h>
by deselecting HAVE_MACH_CLKDEV. This has the nice side effect
that <mach/clkdev.h> is no longer used and can be removed.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/Kconfig                             |    1 -
 arch/arm/mach-shmobile/clock.c               |   11 -----------
 arch/arm/mach-shmobile/include/mach/clkdev.h |    7 -------
 3 files changed, 19 deletions(-)

--- 0001/arch/arm/Kconfig
+++ work/arch/arm/Kconfig	2015-01-20 20:27:11.307765682 +0900
@@ -644,7 +644,6 @@ config ARCH_SHMOBILE_LEGACY
 	select GENERIC_CLOCKEVENTS
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
-	select HAVE_MACH_CLKDEV
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
 	select MULTI_IRQ_HANDLER
--- 0001/arch/arm/mach-shmobile/clock.c
+++ work/arch/arm/mach-shmobile/clock.c	2015-01-20 20:27:11.307765682 +0900
@@ -45,14 +45,3 @@ int __init shmobile_clk_init(void)
 
 	return 0;
 }
-
-int __clk_get(struct clk *clk)
-{
-	return 1;
-}
-EXPORT_SYMBOL(__clk_get);
-
-void __clk_put(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(__clk_put);
--- 0001/arch/arm/mach-shmobile/include/mach/clkdev.h
+++ /dev/null	2015-01-13 15:44:39.280208949 +0900
@@ -1,7 +0,0 @@
-#ifndef __ASM_MACH_CLKDEV_H
-#define __ASM_MACH_CLKDEV_H
-
-int __clk_get(struct clk *clk);
-void __clk_put(struct clk *clk);
-
-#endif /* __ASM_MACH_CLKDEV_H */
