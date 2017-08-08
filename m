From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Tue,  8 Aug 2017 15:17:55 +0800
Subject: [PATCH v3 5/9] clk: rockchip: fix up the pll clks error for rv1108 SoC
In-Reply-To: <1502176547-30817-1-git-send-email-zhangqing@rock-chips.com>
References: <1502176547-30817-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1502176675-32228-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fix up the lock_shift describe error.
remove the ROCKCHIP_PLL_SYNC_RATE flag for gpll.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-rv1108.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rv1108.c b/drivers/clk/rockchip/clk-rv1108.c
index 3c670db16e18..9c6bad0da140 100644
--- a/drivers/clk/rockchip/clk-rv1108.c
+++ b/drivers/clk/rockchip/clk-rv1108.c
@@ -148,11 +148,11 @@ enum rv1108_plls {
 
 static struct rockchip_pll_clock rv1108_pll_clks[] __initdata = {
 	[apll] = PLL(pll_rk3399, PLL_APLL, "apll", mux_pll_p, 0, RV1108_PLL_CON(0),
-		     RV1108_PLL_CON(3), 8, 31, 0, rv1108_pll_rates),
+		     RV1108_PLL_CON(3), 8, 0, 0, rv1108_pll_rates),
 	[dpll] = PLL(pll_rk3399, PLL_DPLL, "dpll", mux_pll_p, 0, RV1108_PLL_CON(8),
-		     RV1108_PLL_CON(11), 8, 31, 0, NULL),
+		     RV1108_PLL_CON(11), 8, 1, 0, NULL),
 	[gpll] = PLL(pll_rk3399, PLL_GPLL, "gpll", mux_pll_p, 0, RV1108_PLL_CON(16),
-		     RV1108_PLL_CON(19), 8, 31, ROCKCHIP_PLL_SYNC_RATE, rv1108_pll_rates),
+		     RV1108_PLL_CON(19), 8, 2, 0, rv1108_pll_rates),
 };
 
 #define MFLAGS CLK_MUX_HIWORD_MASK
-- 
1.9.1
