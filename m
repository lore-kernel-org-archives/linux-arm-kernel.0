From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 09:58:45 +0900
Subject: [PATCH 4/9] ARM: shmobile: Remove unused r8a7740_init_delay()
In-Reply-To: <cover.1400200838.git.horms+renesas@verge.net.au>
References: <cover.1400200838.git.horms+renesas@verge.net.au>
Message-ID: <bf901fbd9040effe4aa1389f78efcc1c2736a44b.1400200838.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Remove the now unused r8a7740_init_delay() function.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Tested-by: Geert Uytterhoeven <geert@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a7740.h | 1 -
 arch/arm/mach-shmobile/setup-r8a7740.c        | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index d07932f..5e3c9ec 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
@@ -47,7 +47,6 @@ enum {
 };
 
 extern void r8a7740_meram_workaround(void);
-extern void r8a7740_init_delay(void);
 extern void r8a7740_init_irq_of(void);
 extern void r8a7740_map_io(void);
 extern void r8a7740_add_early_devices(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index d1ce3ca..eaec043 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -887,11 +887,6 @@ void __init r8a7740_add_standard_devices_dt(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-void __init r8a7740_init_delay(void)
-{
-	shmobile_setup_delay(800, 1, 3); /* Cortex-A9 @ 800MHz */
-};
-
 void __init r8a7740_init_irq_of(void)
 {
 	void __iomem *intc_prio_base = ioremap_nocache(0xe6900010, 0x10);
-- 
1.8.5.2
