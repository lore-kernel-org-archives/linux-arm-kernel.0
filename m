From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 01 Jul 2013 14:41:15 +0900
Subject: [PATCH 01/07] ARM: shmobile: Remove unused EMEV2 auxdata and callback
In-Reply-To: <20130701054106.19319.46845.sendpatchset@w520>
References: <20130701054106.19319.46845.sendpatchset@w520>
Message-ID: <20130701054115.19319.64158.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Replace the SoC-specific callback init_machine() with 
a NULL to use the default code. This cleans up the code
and reduces the number of lines.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-emev2.c |   10 ----------
 1 file changed, 10 deletions(-)

--- 0001/arch/arm/mach-shmobile/setup-emev2.c
+++ work/arch/arm/mach-shmobile/setup-emev2.c	2013-07-01 13:19:32.000000000 +0900
@@ -435,15 +435,6 @@ void __init emev2_init_irq(void)
 }
 
 #ifdef CONFIG_USE_OF
-static const struct of_dev_auxdata emev2_auxdata_lookup[] __initconst = {
-	{ }
-};
-
-static void __init emev2_add_standard_devices_dt(void)
-{
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     emev2_auxdata_lookup, NULL);
-}
 
 static const char *emev2_boards_compat_dt[] __initdata = {
 	"renesas,emev2",
@@ -455,7 +446,6 @@ DT_MACHINE_START(EMEV2_DT, "Generic Emma
 	.init_early	= emev2_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= irqchip_init,
-	.init_machine	= emev2_add_standard_devices_dt,
 	.dt_compat	= emev2_boards_compat_dt,
 MACHINE_END
 
