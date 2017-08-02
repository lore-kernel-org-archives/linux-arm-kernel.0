From: andy.yan@rock-chips.com (Andy Yan)
Date: Wed,  2 Aug 2017 16:35:31 +0800
Subject: [PATCH v2 08/23] clk: rockchip: rename some of clks for rv1108 SoC
In-Reply-To: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
References: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1501662931-12139-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Elaine Zhang <zhangqing@rock-chips.com>

Rename some of clks to keep the consistency with the TRM.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

Changes in v2: None

 drivers/clk/rockchip/clk-rv1108.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rv1108.c b/drivers/clk/rockchip/clk-rv1108.c
index d667c7d..dca9c37 100644
--- a/drivers/clk/rockchip/clk-rv1108.c
+++ b/drivers/clk/rockchip/clk-rv1108.c
@@ -276,24 +276,24 @@ static struct rockchip_clk_branch rv1108_clk_branches[] __initdata = {
 	COMPOSITE_NOMUX(0, "pmu_24m_ena", "gpll", CLK_IGNORE_UNUSED,
 			RV1108_CLKSEL_CON(38), 0, 5, DFLAGS,
 			RV1108_CLKGATE_CON(8), 12, GFLAGS),
-	GATE(0, "pmu", "pmu_24m_ena", CLK_IGNORE_UNUSED,
+	GATE(0, "pclk_pmu", "pmu_24m_ena", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(10), 0, GFLAGS),
-	GATE(0, "intmem1", "pmu_24m_ena", CLK_IGNORE_UNUSED,
+	GATE(0, "pclk_intmem1", "pmu_24m_ena", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(10), 1, GFLAGS),
-	GATE(0, "gpio0_pmu", "pmu_24m_ena", CLK_IGNORE_UNUSED,
+	GATE(PCLK_GPIO0_PMU, "pclk_gpio0_pmu", "pmu_24m_ena", 0,
 			RV1108_CLKGATE_CON(10), 2, GFLAGS),
-	GATE(0, "pmugrf", "pmu_24m_ena", CLK_IGNORE_UNUSED,
+	GATE(0, "pclk_pmugrf", "pmu_24m_ena", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(10), 3, GFLAGS),
-	GATE(0, "pmu_noc", "pmu_24m_ena", CLK_IGNORE_UNUSED,
+	GATE(0, "pclk_pmu_niu", "pmu_24m_ena", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(10), 4, GFLAGS),
-	GATE(0, "i2c0_pmu_pclk", "pmu_24m_ena", CLK_IGNORE_UNUSED,
+	GATE(PCLK_I2C0_PMU, "pclk_i2c0_pmu", "pmu_24m_ena", 0,
 			RV1108_CLKGATE_CON(10), 5, GFLAGS),
-	GATE(0, "pwm0_pmu_pclk", "pmu_24m_ena", CLK_IGNORE_UNUSED,
+	GATE(PCLK_PWM0_PMU, "pclk_pwm0_pmu", "pmu_24m_ena", 0,
 			RV1108_CLKGATE_CON(10), 6, GFLAGS),
-	COMPOSITE(0, "pwm0_pmu_clk", mux_pll_src_2plls_p, CLK_IGNORE_UNUSED,
+	COMPOSITE(SCLK_PWM0_PMU, "sclk_pwm0_pmu", mux_pll_src_2plls_p, 0,
 			RV1108_CLKSEL_CON(12), 7, 1, MFLAGS, 0, 7, DFLAGS,
 			RV1108_CLKGATE_CON(8), 15, GFLAGS),
-	COMPOSITE(0, "i2c0_pmu_clk", mux_pll_src_2plls_p, CLK_IGNORE_UNUSED,
+	COMPOSITE(SCLK_I2C0_PMU, "sclk_i2c0_pmu", mux_pll_src_2plls_p, 0,
 			RV1108_CLKSEL_CON(19), 7, 1, MFLAGS, 0, 7, DFLAGS,
 			RV1108_CLKGATE_CON(8), 14, GFLAGS),
 	GATE(0, "pvtm_pmu", "xin24m", CLK_IGNORE_UNUSED,
@@ -416,10 +416,10 @@ static struct rockchip_clk_branch rv1108_clk_branches[] __initdata = {
 	/*
 	 * Clock-Architecture Diagram 4
 	 */
-	COMPOSITE(0, "aclk_vio0_2wrap_occ", mux_pll_src_4plls_p, CLK_IGNORE_UNUSED,
+	COMPOSITE(0, "aclk_vio0_pre", mux_pll_src_4plls_p, CLK_IGNORE_UNUSED,
 			RV1108_CLKSEL_CON(28), 6, 2, MFLAGS, 0, 5, DFLAGS,
 			RV1108_CLKGATE_CON(6), 0, GFLAGS),
-	GATE(0, "aclk_vio0_pre", "aclk_vio0_2wrap_occ", CLK_IGNORE_UNUSED,
+	GATE(ACLK_VIO0, "aclk_vio0", "aclk_vio0_pre", 0,
 			RV1108_CLKGATE_CON(17), 0, GFLAGS),
 	COMPOSITE_NOMUX(0, "hclk_vio_pre", "aclk_vio0_pre", 0,
 			RV1108_CLKSEL_CON(29), 0, 5, DFLAGS,
@@ -441,8 +441,8 @@ static struct rockchip_clk_branch rv1108_clk_branches[] __initdata = {
 			RV1108_CLKGATE_CON(6), 5, GFLAGS),
 	GATE(0, "dclk_hdmiphy_src_dpll", "dpll", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(6), 4, GFLAGS),
-	COMPOSITE_NOGATE(0, "dclk_hdmiphy", mux_dclk_hdmiphy_pre_p, 0,
-			RV1108_CLKSEL_CON(32), 6, 2, MFLAGS, 8, 6, DFLAGS),
+	COMPOSITE_NOGATE(0, "dclk_hdmiphy_pre", mux_dclk_hdmiphy_pre_p, 0,
+			RV1108_CLKSEL_CON(32), 6, 1, MFLAGS, 8, 6, DFLAGS),
 	COMPOSITE_NOGATE(DCLK_VOP_SRC, "dclk_vop_src", mux_dclk_hdmiphy_pre_p, 0,
 			RV1108_CLKSEL_CON(32), 6, 1, MFLAGS, 0, 6, DFLAGS),
 	MUX(DCLK_HDMIPHY, "dclk_hdmiphy", mux_dclk_hdmiphy_p, CLK_SET_RATE_PARENT,
@@ -630,10 +630,10 @@ static struct rockchip_clk_branch rv1108_clk_branches[] __initdata = {
 			RV1108_CLKGATE_CON(13), 1, GFLAGS),
 	GATE(PCLK_I2C3, "pclk_i2c3", "pclk_bus_pre", 0,
 			RV1108_CLKGATE_CON(13), 2, GFLAGS),
-	COMPOSITE(SCLK_PWM, "clk_pwm1", mux_pll_src_2plls_p, 0,
+	COMPOSITE(SCLK_PWM, "clk_pwm", mux_pll_src_2plls_p, 0,
 			RV1108_CLKSEL_CON(12), 15, 2, MFLAGS, 8, 7, DFLAGS,
 			RV1108_CLKGATE_CON(3), 10, GFLAGS),
-	GATE(PCLK_PWM, "pclk_pwm1", "pclk_bus_pre", 0,
+	GATE(PCLK_PWM, "pclk_pwm", "pclk_bus_pre", 0,
 			RV1108_CLKGATE_CON(13), 6, GFLAGS),
 	GATE(PCLK_WDT, "pclk_wdt", "pclk_bus_pre", 0,
 			RV1108_CLKGATE_CON(13), 3, GFLAGS),
@@ -718,7 +718,7 @@ static struct rockchip_clk_branch rv1108_clk_branches[] __initdata = {
 			RV1108_CLKSEL_CON(23), 15, 1, MFLAGS, 0, 5, DFLAGS,
 			RV1108_CLKGATE_CON(15), 11, GFLAGS),
 
-	COMPOSITE(SCLK_SDMMC, "sclk_sdmmc0", mux_mmc_src_p, 0,
+	COMPOSITE(SCLK_SDMMC, "sclk_sdmmc", mux_mmc_src_p, 0,
 			RV1108_CLKSEL_CON(25), 8, 2, MFLAGS, 0, 8, DFLAGS,
 			RV1108_CLKGATE_CON(5), 0, GFLAGS),
 
-- 
2.7.4
