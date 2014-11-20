From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 20 Nov 2014 20:38:53 +0100
Subject: [PATCH v2 4/4] clk: rockchip: add ROCKCHIP_PLL_SYNC_RATE flag to some
 plls
In-Reply-To: <1416512333-15438-1-git-send-email-heiko@sntech.de>
References: <1416512333-15438-1-git-send-email-heiko@sntech.de>
Message-ID: <1416512333-15438-5-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the new flag to gpll and cpll on rk3188 and similar and to
gpll, cpll and npll on rk3288.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-rk3188.c | 4 ++--
 drivers/clk/rockchip/clk-rk3288.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index 6af5d7f..37a1988 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -216,9 +216,9 @@ static struct rockchip_pll_clock rk3188_pll_clks[] __initdata = {
 	[dpll] = PLL(pll_rk3066, PLL_DPLL, "dpll", mux_pll_p, 0, RK2928_PLL_CON(4),
 		     RK2928_MODE_CON, 4, 5, 0, NULL),
 	[cpll] = PLL(pll_rk3066, PLL_CPLL, "cpll", mux_pll_p, 0, RK2928_PLL_CON(8),
-		     RK2928_MODE_CON, 8, 7, 0, rk3188_pll_rates),
+		     RK2928_MODE_CON, 8, 7, ROCKCHIP_PLL_SYNC_RATE, rk3188_pll_rates),
 	[gpll] = PLL(pll_rk3066, PLL_GPLL, "gpll", mux_pll_p, 0, RK2928_PLL_CON(12),
-		     RK2928_MODE_CON, 12, 8, 0, rk3188_pll_rates),
+		     RK2928_MODE_CON, 12, 8, ROCKCHIP_PLL_SYNC_RATE, rk3188_pll_rates),
 };
 
 #define MFLAGS CLK_MUX_HIWORD_MASK
diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 2d31a22..ad8a27a 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -206,11 +206,11 @@ static struct rockchip_pll_clock rk3288_pll_clks[] __initdata = {
 	[dpll] = PLL(pll_rk3066, PLL_DPLL, "dpll", mux_pll_p, 0, RK3288_PLL_CON(4),
 		     RK3288_MODE_CON, 4, 5, 0, NULL),
 	[cpll] = PLL(pll_rk3066, PLL_CPLL, "cpll", mux_pll_p, 0, RK3288_PLL_CON(8),
-		     RK3288_MODE_CON, 8, 7, 0, rk3288_pll_rates),
+		     RK3288_MODE_CON, 8, 7, ROCKCHIP_PLL_SYNC_RATE, rk3288_pll_rates),
 	[gpll] = PLL(pll_rk3066, PLL_GPLL, "gpll", mux_pll_p, 0, RK3288_PLL_CON(12),
-		     RK3288_MODE_CON, 12, 8, 0, rk3288_pll_rates),
+		     RK3288_MODE_CON, 12, 8, ROCKCHIP_PLL_SYNC_RATE, rk3288_pll_rates),
 	[npll] = PLL(pll_rk3066, PLL_NPLL, "npll",  mux_pll_p, 0, RK3288_PLL_CON(16),
-		     RK3288_MODE_CON, 14, 9, 0, rk3288_pll_rates),
+		     RK3288_MODE_CON, 14, 9, ROCKCHIP_PLL_SYNC_RATE, rk3288_pll_rates),
 };
 
 static struct clk_div_table div_hclk_cpu_t[] = {
-- 
2.1.1
