From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 18 Jul 2013 08:31:50 +0900
Subject: [PATCH 11/22] ARM: shmobile: Remove unused EMEV2 auxdata and callback
In-Reply-To: <cover.1374103272.git.horms+renesas@verge.net.au>
References: <cover.1374103272.git.horms+renesas@verge.net.au>
Message-ID: <a597d8df88143f7a409b260b1e89735eb0bdca05.1374103272.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Replace the SoC-specific callback init_machine() with
a NULL to use the default code. This cleans up the code
and reduces the number of lines.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-emev2.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
index 6e8b6ac..b0564ce 100644
--- a/arch/arm/mach-shmobile/setup-emev2.c
+++ b/arch/arm/mach-shmobile/setup-emev2.c
@@ -434,15 +434,6 @@ void __init emev2_init_irq(void)
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
@@ -453,7 +444,6 @@ DT_MACHINE_START(EMEV2_DT, "Generic Emma Mobile EV2 (Flattened Device Tree)")
 	.smp		= smp_ops(emev2_smp_ops),
 	.init_early	= emev2_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
-	.init_machine	= emev2_add_standard_devices_dt,
 	.dt_compat	= emev2_boards_compat_dt,
 MACHINE_END
 
-- 
1.7.10.4
