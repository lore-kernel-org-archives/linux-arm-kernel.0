From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 26 Sep 2014 20:53:06 +0200
Subject: [PATCH v4 3/8] clk: rockchip: fix rk3288 pll status register location
In-Reply-To: <1411757591-16142-1-git-send-email-heiko@sntech.de>
References: <1411757591-16142-1-git-send-email-heiko@sntech.de>
Message-ID: <1411757591-16142-4-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jianqun <jay.xu@rock-chips.com>

In RK3288, APLL lock status bit is in GRF_SOC_STATUS1,
but in RK3188, is GRFSOC_STATUS0.

Signed-off-by: Jianqun <jay.xu@rock-chips.com>

Also name the constant accordingly as GRF_SOC_STATUS1
to prevent confusion.
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
---
 drivers/clk/rockchip/clk-rk3288.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 978ab24..ddca0a0 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -20,7 +20,7 @@
 #include "clk.h"
 
 #define RK3288_GRF_SOC_CON(x)	(0x244 + x * 4)
-#define RK3288_GRF_SOC_STATUS	0x280
+#define RK3288_GRF_SOC_STATUS1	0x284
 
 enum rk3288_plls {
 	apll, dpll, cpll, gpll, npll,
@@ -733,7 +733,7 @@ static void __init rk3288_clk_init(struct device_node *np)
 
 	rockchip_clk_register_plls(rk3288_pll_clks,
 				   ARRAY_SIZE(rk3288_pll_clks),
-				   RK3288_GRF_SOC_STATUS);
+				   RK3288_GRF_SOC_STATUS1);
 	rockchip_clk_register_branches(rk3288_clk_branches,
 				  ARRAY_SIZE(rk3288_clk_branches));
 	rockchip_clk_protect_critical(rk3288_critical_clocks,
-- 
2.1.0
