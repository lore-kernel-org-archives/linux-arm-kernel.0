From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Aug 2014 10:10:21 +0900
Subject: [PATCH 1/3] ARM: shmobile: sh73a0: Remove duplicate CPUFreq bits
In-Reply-To: <cover.1408927858.git.horms+renesas@verge.net.au>
References: <cover.1408927858.git.horms+renesas@verge.net.au>
Message-ID: <aa0bdc303b0f8bc59fc0a0645560917810ba041b.1408927858.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

The CPUFreq platform device is already registered by
shmobile_init_late(), so get rid of sh73a0 specific bits.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh73a0.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index e7a0296..8ff9679 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -775,17 +775,12 @@ void __init sh73a0_add_early_devices(void)
 
 void __init sh73a0_add_standard_devices_dt(void)
 {
-	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", .id = -1, };
-
 	/* clocks are setup late during boot in the case of DT */
 	sh73a0_clock_init();
 
 	platform_add_devices(sh73a0_devices_dt,
 			     ARRAY_SIZE(sh73a0_devices_dt));
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-
-	/* Instantiate cpufreq-cpu0 */
-	platform_device_register_full(&devinfo);
 }
 
 static const char *sh73a0_boards_compat_dt[] __initdata = {
-- 
2.0.1
