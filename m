From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 08 May 2014 08:32:56 +0900
Subject: [PATCH 04/04] ARM: shmobile: Remove unused r8a7740_init_delay()
In-Reply-To: <20140507233219.29712.9253.sendpatchset@w520>
References: <20140507233219.29712.9253.sendpatchset@w520>
Message-ID: <20140507233256.29712.54976.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Remove the now unused r8a7740_init_delay() function.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/r8a7740.h |    1 -
 arch/arm/mach-shmobile/setup-r8a7740.c        |    5 -----
 2 files changed, 6 deletions(-)

--- 0001/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a7740.h	2014-04-24 18:02:10.000000000 +0900
@@ -47,7 +47,6 @@ enum {
 };
 
 extern void r8a7740_meram_workaround(void);
-extern void r8a7740_init_delay(void);
 extern void r8a7740_init_irq_of(void);
 extern void r8a7740_map_io(void);
 extern void r8a7740_add_early_devices(void);
--- 0004/arch/arm/mach-shmobile/setup-r8a7740.c
+++ work/arch/arm/mach-shmobile/setup-r8a7740.c	2014-04-24 18:01:54.000000000 +0900
@@ -876,11 +876,6 @@ void __init r8a7740_add_standard_devices
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
