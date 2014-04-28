From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 28 Apr 2014 20:33:51 +0100
Subject: [PATCH 90/97] ARM: l2c: convert rockchip to generic l2c initialisation
In-Reply-To: <20140428192419.GV26756@n2100.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Message-ID: <E1WerJH-0001Zo-S0@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This also allows us to eliminate the .init_machine function.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-rockchip/rockchip.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/mach-rockchip/rockchip.c
index d252efe3747b..138b9975313a 100644
--- a/arch/arm/mach-rockchip/rockchip.c
+++ b/arch/arm/mach-rockchip/rockchip.c
@@ -24,12 +24,6 @@
 #include <asm/hardware/cache-l2x0.h>
 #include "core.h"
 
-static void __init rockchip_dt_init(void)
-{
-	l2x0_of_init(0, ~0);
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
-
 static const char * const rockchip_board_dt_compat[] = {
 	"rockchip,rk2928",
 	"rockchip,rk3066a",
@@ -39,7 +33,8 @@ static const char * const rockchip_board_dt_compat[] = {
 };
 
 DT_MACHINE_START(ROCKCHIP_DT, "Rockchip Cortex-A9 (Device Tree)")
+	.l2c_aux_val	= 0,
+	.l2c_aux_mask	= ~0,
 	.smp		= smp_ops(rockchip_smp_ops),
-	.init_machine	= rockchip_dt_init,
 	.dt_compat	= rockchip_board_dt_compat,
 MACHINE_END
-- 
1.8.3.1
