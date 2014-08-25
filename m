From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Aug 2014 10:10:22 +0900
Subject: [PATCH 2/3] ARM: shmobile: ape6evm: Remove duplicate CPUFreq bits
In-Reply-To: <cover.1408927858.git.horms+renesas@verge.net.au>
References: <cover.1408927858.git.horms+renesas@verge.net.au>
Message-ID: <664b4c172209f076866419a5a4162e4fc9631807.1408927858.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

The CPUFreq platform device is already registered by
shmobile_init_late(), so get rid of ape6evm specific bits.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ape6evm-reference.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-ape6evm-reference.c b/arch/arm/mach-shmobile/board-ape6evm-reference.c
index 2f7723e..ac371b7 100644
--- a/arch/arm/mach-shmobile/board-ape6evm-reference.c
+++ b/arch/arm/mach-shmobile/board-ape6evm-reference.c
@@ -50,7 +50,6 @@ static void __init ape6evm_add_standard_devices(void)
 
 	r8a73a4_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-	platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);
 }
 
 static const char *ape6evm_boards_compat_dt[] __initdata = {
-- 
2.0.1
