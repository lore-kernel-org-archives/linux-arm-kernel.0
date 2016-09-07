From: john@metanate.com (John Keeping)
Date: Wed,  7 Sep 2016 17:53:30 +0100
Subject: [PATCH 2/2] clk: rockchip: use identifiers for rk3288 I2S clocks
In-Reply-To: <20160907165330.14607-1-john@metanate.com>
References: <20160907165330.14607-1-john@metanate.com>
Message-ID: <20160907165330.14607-2-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Export these so that the rates can be set via the device tree.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/clk/rockchip/clk-rk3288.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 39af05a589b3..8817a5b3bd0f 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -229,7 +229,7 @@ static struct clk_div_table div_hclk_cpu_t[] = {
 #define IFLAGS ROCKCHIP_INVERTER_HIWORD_MASK
 
 static struct rockchip_clk_branch rk3288_i2s_fracmux __initdata =
-	MUX(0, "i2s_pre", mux_i2s_pre_p, CLK_SET_RATE_PARENT,
+	MUX(SCLK_I2S_PRE, "i2s_pre", mux_i2s_pre_p, CLK_SET_RATE_PARENT,
 			RK3288_CLKSEL_CON(4), 8, 2, MFLAGS);
 
 static struct rockchip_clk_branch rk3288_spdif_fracmux __initdata =
@@ -338,10 +338,10 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 
 	FACTOR(0, "xin12m", "xin24m", 0, 1, 2),
 
-	COMPOSITE(0, "i2s_src", mux_pll_src_cpll_gpll_p, 0,
+	COMPOSITE(SCLK_I2S_SRC, "i2s_src", mux_pll_src_cpll_gpll_p, 0,
 			RK3288_CLKSEL_CON(4), 15, 1, MFLAGS, 0, 7, DFLAGS,
 			RK3288_CLKGATE_CON(4), 1, GFLAGS),
-	COMPOSITE_FRACMUX(0, "i2s_frac", "i2s_src", CLK_SET_RATE_PARENT,
+	COMPOSITE_FRACMUX(SCLK_I2S_FRAC, "i2s_frac", "i2s_src", CLK_SET_RATE_PARENT,
 			RK3288_CLKSEL_CON(8), 0,
 			RK3288_CLKGATE_CON(4), 2, GFLAGS,
 			&rk3288_i2s_fracmux),
-- 
2.9.3.728.g30b24b4.dirty
