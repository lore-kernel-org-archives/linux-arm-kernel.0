From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 21 Jan 2015 10:49:24 +0100
Subject: [PATCH] ARM: rockchip: remove cpu-core name from machine name
Message-ID: <1444639.mSKlrDUu2q@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Rockchip support is not limited to Cortex-A9 socs anymore and its
presence may confuse people reading /proc/cpuinfo. So remove the core
specific part.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-rockchip/rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/mach-rockchip/rockchip.c
index 7d3c306..8d92aee 100644
--- a/arch/arm/mach-rockchip/rockchip.c
+++ b/arch/arm/mach-rockchip/rockchip.c
@@ -82,7 +82,7 @@ static const char * const rockchip_board_dt_compat[] = {
 	NULL,
 };
 
-DT_MACHINE_START(ROCKCHIP_DT, "Rockchip Cortex-A9 (Device Tree)")
+DT_MACHINE_START(ROCKCHIP_DT, "Rockchip (Device Tree)")
 	.l2c_aux_val	= 0,
 	.l2c_aux_mask	= ~0,
 	.dt_compat	= rockchip_board_dt_compat,
-- 
2.1.1
