From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 15 Sep 2017 10:33:50 +0200
Subject: [PATCH 2/9] clk: rockchip: use new cif/vdpu clock ids on rk3188
In-Reply-To: <20170915083357.11296-1-heiko@sntech.de>
References: <20170915083357.11296-1-heiko@sntech.de>
Message-ID: <20170915083357.11296-3-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new clock-ids for cif, vdpu, vepu on rk3188

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-rk3188.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index 00ad0e5f8d66..67e73fd71f09 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -290,15 +290,15 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 			RK2928_CLKSEL_CON(0), 6, 2, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			div_core_peri_t, RK2928_CLKGATE_CON(0), 0, GFLAGS),
 
-	COMPOSITE(0, "aclk_vepu", mux_pll_src_cpll_gpll_p, 0,
+	COMPOSITE(ACLK_VEPU, "aclk_vepu", mux_pll_src_cpll_gpll_p, 0,
 			RK2928_CLKSEL_CON(32), 7, 1, MFLAGS, 0, 5, DFLAGS,
 			RK2928_CLKGATE_CON(3), 9, GFLAGS),
-	GATE(0, "hclk_vepu", "aclk_vepu", 0,
+	GATE(HCLK_VEPU, "hclk_vepu", "aclk_vepu", 0,
 			RK2928_CLKGATE_CON(3), 10, GFLAGS),
-	COMPOSITE(0, "aclk_vdpu", mux_pll_src_cpll_gpll_p, 0,
+	COMPOSITE(ACLK_VDPU, "aclk_vdpu", mux_pll_src_cpll_gpll_p, 0,
 			RK2928_CLKSEL_CON(32), 15, 1, MFLAGS, 8, 5, DFLAGS,
 			RK2928_CLKGATE_CON(3), 11, GFLAGS),
-	GATE(0, "hclk_vdpu", "aclk_vdpu", 0,
+	GATE(HCLK_VDPU, "hclk_vdpu", "aclk_vdpu", 0,
 			RK2928_CLKGATE_CON(3), 12, GFLAGS),
 
 	GATE(0, "gpll_ddr", "gpll", CLK_IGNORE_UNUSED,
@@ -644,13 +644,13 @@ static struct rockchip_clk_branch rk3066a_clk_branches[] __initdata = {
 
 	GATE(HCLK_I2S1, "hclk_i2s1", "hclk_cpu", 0, RK2928_CLKGATE_CON(7), 3, GFLAGS),
 	GATE(HCLK_I2S2, "hclk_i2s2", "hclk_cpu", 0, RK2928_CLKGATE_CON(7), 4, GFLAGS),
-	GATE(0, "hclk_cif1", "hclk_cpu", 0, RK2928_CLKGATE_CON(6), 6, GFLAGS),
+	GATE(HCLK_CIF1, "hclk_cif1", "hclk_cpu", 0, RK2928_CLKGATE_CON(6), 6, GFLAGS),
 	GATE(0, "hclk_hdmi", "hclk_cpu", 0, RK2928_CLKGATE_CON(4), 14, GFLAGS),
 
 	GATE(HCLK_OTG1, "hclk_usbotg1", "hclk_peri", CLK_IGNORE_UNUSED,
 			RK2928_CLKGATE_CON(5), 14, GFLAGS),
 
-	GATE(0, "aclk_cif1", "aclk_vio1", 0, RK2928_CLKGATE_CON(6), 7, GFLAGS),
+	GATE(ACLK_CIF1, "aclk_cif1", "aclk_vio1", 0, RK2928_CLKGATE_CON(6), 7, GFLAGS),
 
 	GATE(PCLK_TIMER1, "pclk_timer1", "pclk_cpu", 0, RK2928_CLKGATE_CON(7), 8, GFLAGS),
 	GATE(PCLK_TIMER2, "pclk_timer2", "pclk_cpu", 0, RK2928_CLKGATE_CON(7), 9, GFLAGS),
-- 
2.14.1
