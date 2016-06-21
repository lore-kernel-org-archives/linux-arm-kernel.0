From: zhengxing@rock-chips.com (Xing Zheng)
Date: Tue, 21 Jun 2016 12:53:27 +0800
Subject: [PATCH 1/5] clk: rockchip: rk3228: fix incorrect clock node names
In-Reply-To: <1466484811-26923-1-git-send-email-zhengxing@rock-chips.com>
References: <1466484811-26923-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1466484811-26923-2-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to copy and paste carelessly, RK3288_CLKxxx nodes are incorrect,
we need to fix them.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3228.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3228.c b/drivers/clk/rockchip/clk-rk3228.c
index 016bdb0..2f1442f 100644
--- a/drivers/clk/rockchip/clk-rk3228.c
+++ b/drivers/clk/rockchip/clk-rk3228.c
@@ -335,7 +335,7 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
 			RK2928_CLKGATE_CON(2), 6, GFLAGS),
 
 	GATE(0, "sclk_hsadc", "ext_hsadc", 0,
-			RK3288_CLKGATE_CON(10), 12, GFLAGS),
+			RK2928_CLKGATE_CON(10), 12, GFLAGS),
 
 	COMPOSITE(0, "sclk_wifi", mux_pll_src_cpll_gpll_usb480m_p, 0,
 			RK2928_CLKSEL_CON(23), 5, 2, MFLAGS, 0, 6, DFLAGS,
@@ -380,8 +380,8 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
 			RK2928_CLKSEL_CON(9), 15, 1, MFLAGS, 0, 7, DFLAGS,
 			RK2928_CLKGATE_CON(0), 3, GFLAGS),
 	COMPOSITE_FRAC(0, "i2s0_frac", "i2s0_src", CLK_SET_RATE_PARENT,
-			RK3288_CLKSEL_CON(8), 0,
-			RK3288_CLKGATE_CON(0), 4, GFLAGS),
+			RK2928_CLKSEL_CON(8), 0,
+			RK2928_CLKGATE_CON(0), 4, GFLAGS),
 	COMPOSITE_NODIV(SCLK_I2S0, "sclk_i2s0", mux_i2s0_p, 0,
 			RK2928_CLKSEL_CON(9), 8, 2, MFLAGS,
 			RK2928_CLKGATE_CON(0), 5, GFLAGS),
@@ -390,8 +390,8 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
 			RK2928_CLKSEL_CON(3), 15, 1, MFLAGS, 0, 7, DFLAGS,
 			RK2928_CLKGATE_CON(0), 10, GFLAGS),
 	COMPOSITE_FRAC(0, "i2s1_frac", "i2s1_src", CLK_SET_RATE_PARENT,
-			RK3288_CLKSEL_CON(7), 0,
-			RK3288_CLKGATE_CON(0), 11, GFLAGS),
+			RK2928_CLKSEL_CON(7), 0,
+			RK2928_CLKGATE_CON(0), 11, GFLAGS,
 	MUX(0, "i2s1_pre", mux_i2s1_pre_p, 0,
 			RK2928_CLKSEL_CON(3), 8, 2, MFLAGS),
 	GATE(SCLK_I2S1, "sclk_i2s1", "i2s1_pre", 0,
@@ -404,8 +404,8 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
 			RK2928_CLKSEL_CON(16), 15, 1, MFLAGS, 0, 7, DFLAGS,
 			RK2928_CLKGATE_CON(0), 7, GFLAGS),
 	COMPOSITE_FRAC(0, "i2s2_frac", "i2s2_src", CLK_SET_RATE_PARENT,
-			RK3288_CLKSEL_CON(30), 0,
-			RK3288_CLKGATE_CON(0), 8, GFLAGS),
+			RK2928_CLKSEL_CON(30), 0,
+			RK2928_CLKGATE_CON(0), 8, GFLAGS),
 	COMPOSITE_NODIV(SCLK_I2S2, "sclk_i2s2", mux_i2s2_p, 0,
 			RK2928_CLKSEL_CON(16), 8, 2, MFLAGS,
 			RK2928_CLKGATE_CON(0), 9, GFLAGS),
@@ -414,8 +414,8 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
 			RK2928_CLKSEL_CON(6), 15, 1, MFLAGS, 0, 7, DFLAGS,
 			RK2928_CLKGATE_CON(2), 10, GFLAGS),
 	COMPOSITE_FRAC(0, "spdif_frac", "sclk_spdif_src", CLK_SET_RATE_PARENT,
-			RK3288_CLKSEL_CON(20), 0,
-			RK3288_CLKGATE_CON(2), 12, GFLAGS),
+			RK2928_CLKSEL_CON(20), 0,
+			RK2928_CLKGATE_CON(2), 12, GFLAGS),
 	MUX(SCLK_SPDIF, "sclk_spdif", mux_sclk_spdif_p, 0,
 			RK2928_CLKSEL_CON(6), 8, 2, MFLAGS),
 
-- 
1.7.9.5
