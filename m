From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:26:49 +0900
Subject: [PATCH 2/9] ARM: shmobile: Use shmobile_init_delay() on EMEV2
In-Reply-To: <cover.1403487831.git.horms+renesas@verge.net.au>
References: <cover.1403487831.git.horms+renesas@verge.net.au>
Message-ID: <ef9026e6879da358376b58fc63fe7a82f07404ad.1403487831.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Adjust EMEV2 to use shmobile_init_delay() together with
CPU Frequency settings from the DTS.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-emev2.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
index 6e4ffa7..e10d34e 100644
--- a/arch/arm/mach-shmobile/setup-emev2.c
+++ b/arch/arm/mach-shmobile/setup-emev2.c
@@ -42,11 +42,6 @@ static void __init emev2_map_io(void)
 	iotable_init(emev2_io_desc, ARRAY_SIZE(emev2_io_desc));
 }
 
-static void __init emev2_init_delay(void)
-{
-	shmobile_setup_delay(533, 1, 3); /* Cortex-A9 @ 533MHz */
-}
-
 static void __init emev2_add_standard_devices_dt(void)
 {
 	of_clk_init(NULL);
@@ -63,7 +58,7 @@ extern struct smp_operations emev2_smp_ops;
 DT_MACHINE_START(EMEV2_DT, "Generic Emma Mobile EV2 (Flattened Device Tree)")
 	.smp		= smp_ops(emev2_smp_ops),
 	.map_io		= emev2_map_io,
-	.init_early	= emev2_init_delay,
+	.init_early	= shmobile_init_delay,
 	.init_machine	= emev2_add_standard_devices_dt,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= emev2_boards_compat_dt,
-- 
2.0.0.rc2
