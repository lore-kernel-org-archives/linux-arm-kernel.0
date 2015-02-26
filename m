From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:22:31 +0900
Subject: [PATCH 2/4] ARM: shmobile: Remove mach/clkdev.h
In-Reply-To: <cover.1424931049.git.horms+renesas@verge.net.au>
References: <cover.1424931049.git.horms+renesas@verge.net.au>
Message-ID: <814979eb8494c2269f4907ef0494f199d6d06ec2.1424931049.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Move over ARCH_SHMOBILE_LEGACY to use the default legacy ARM
implementations of __clk_get() and __clk_put() in <asm/clkdev.h>
by deselecting HAVE_MACH_CLKDEV. This has the nice side effect
that <mach/clkdev.h> is no longer used and can be removed.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/Kconfig                             |  1 -
 arch/arm/mach-shmobile/clock.c               | 11 -----------
 arch/arm/mach-shmobile/include/mach/clkdev.h |  7 -------
 3 files changed, 19 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/include/mach/clkdev.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9f1f09a..495fb7a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -646,7 +646,6 @@ config ARCH_SHMOBILE_LEGACY
 	select GENERIC_CLOCKEVENTS
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
-	select HAVE_MACH_CLKDEV
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
 	select MULTI_IRQ_HANDLER
diff --git a/arch/arm/mach-shmobile/clock.c b/arch/arm/mach-shmobile/clock.c
index 34f056f..68c2d06 100644
--- a/arch/arm/mach-shmobile/clock.c
+++ b/arch/arm/mach-shmobile/clock.c
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
diff --git a/arch/arm/mach-shmobile/include/mach/clkdev.h b/arch/arm/mach-shmobile/include/mach/clkdev.h
deleted file mode 100644
index 36d0163..0000000
--- a/arch/arm/mach-shmobile/include/mach/clkdev.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __ASM_MACH_CLKDEV_H
-#define __ASM_MACH_CLKDEV_H
-
-int __clk_get(struct clk *clk);
-void __clk_put(struct clk *clk);
-
-#endif /* __ASM_MACH_CLKDEV_H */
-- 
2.1.4
