From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 26 Aug 2014 14:24:02 +0900
Subject: [PATCH 8/8] ARM: shmobile: r8a7740: Remove
 r8a7740_add_standard_devices_dt
In-Reply-To: <cover.1409030383.git.horms+renesas@verge.net.au>
References: <cover.1409030383.git.horms+renesas@verge.net.au>
Message-ID: <433306747791845677ba662435a9bbbafaa21df3.1409030383.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that r8a7740_add_standard_devices_dt() is simply a wrapper
for a call to of_platform_populate() remove it and call
of_platform_populate() directly.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/r8a7740.h       | 1 -
 arch/arm/mach-shmobile/setup-r8a7740.c | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/r8a7740.h b/arch/arm/mach-shmobile/r8a7740.h
index 1d1a5fd..3352fb8 100644
--- a/arch/arm/mach-shmobile/r8a7740.h
+++ b/arch/arm/mach-shmobile/r8a7740.h
@@ -49,7 +49,6 @@ extern void r8a7740_init_irq_of(void);
 extern void r8a7740_map_io(void);
 extern void r8a7740_add_early_devices(void);
 extern void r8a7740_add_standard_devices(void);
-extern void r8a7740_add_standard_devices_dt(void);
 extern void r8a7740_clock_init(u8 md_ck);
 extern void r8a7740_pinmux_init(void);
 extern void r8a7740_pm_init(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index dc44a44..8fe270d 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -781,11 +781,6 @@ void __init r8a7740_add_early_devices(void)
 
 #ifdef CONFIG_USE_OF
 
-void __init r8a7740_add_standard_devices_dt(void)
-{
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
-
 void __init r8a7740_init_irq_of(void)
 {
 	void __iomem *intc_prio_base = ioremap_nocache(0xe6900010, 0x10);
@@ -819,7 +814,7 @@ void __init r8a7740_init_irq_of(void)
 static void __init r8a7740_generic_init(void)
 {
 	r8a7740_clock_init(0);
-	r8a7740_add_standard_devices_dt();
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static const char *r8a7740_boards_compat_dt[] __initdata = {
-- 
2.0.1
