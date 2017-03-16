From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Thu, 16 Mar 2017 16:44:52 +0800
Subject: [PATCH v1 2/4] clk: rockchip: rk3228: add CLK_IGNORE_UNUSED flag for
 some clks
In-Reply-To: <1489653894-2440-1-git-send-email-zhangqing@rock-chips.com>
References: <1489653894-2440-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1489653894-2440-3-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

set pclk_cpu and hclk_cpu as critical_clocks

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-rk3228.c | 66 ++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3228.c b/drivers/clk/rockchip/clk-rk3228.c
index db6e5a9e6de6..9f82d089084e 100644
--- a/drivers/clk/rockchip/clk-rk3228.c
+++ b/drivers/clk/rockchip/clk-rk3228.c
@@ -262,9 +262,9 @@ enum rk3228_plls {
 			RK2928_CLKGATE_CON(6), 2, GFLAGS),
 	GATE(0, "pclk_cpu", "pclk_bus_src", 0,
 			RK2928_CLKGATE_CON(6), 3, GFLAGS),
-	GATE(0, "pclk_phy_pre", "pclk_bus_src", 0,
+	GATE(0, "pclk_phy_pre", "pclk_bus_src", CLK_IGNORE_UNUSED,
 			RK2928_CLKGATE_CON(6), 4, GFLAGS),
-	GATE(0, "pclk_ddr_pre", "pclk_bus_src", 0,
+	GATE(0, "pclk_ddr_pre", "pclk_bus_src", CLK_IGNORE_UNUSED,
 			RK2928_CLKGATE_CON(6), 13, GFLAGS),
 
 	/* PD_VIDEO */
@@ -445,7 +445,7 @@ enum rk3228_plls {
 			RK2928_CLKGATE_CON(2), 12, GFLAGS,
 			&rk3228_spdif_fracmux),
 
-	GATE(0, "jtag", "ext_jtag", 0,
+	GATE(0, "jtag", "ext_jtag", CLK_IGNORE_UNUSED,
 			RK2928_CLKGATE_CON(1), 3, GFLAGS),
 
 	GATE(0, "sclk_otgphy0", "xin24m", 0,
@@ -527,24 +527,24 @@ enum rk3228_plls {
 
 	/* PD_VOP */
 	GATE(0, "aclk_rga", "aclk_rga_pre", 0, RK2928_CLKGATE_CON(13), 0, GFLAGS),
-	GATE(0, "aclk_rga_noc", "aclk_rga_pre", 0, RK2928_CLKGATE_CON(13), 11, GFLAGS),
+	GATE(0, "aclk_rga_noc", "aclk_rga_pre", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(13), 11, GFLAGS),
 	GATE(0, "aclk_iep", "aclk_iep_pre", 0, RK2928_CLKGATE_CON(13), 2, GFLAGS),
-	GATE(0, "aclk_iep_noc", "aclk_iep_pre", 0, RK2928_CLKGATE_CON(13), 9, GFLAGS),
+	GATE(0, "aclk_iep_noc", "aclk_iep_pre", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(13), 9, GFLAGS),
 
 	GATE(ACLK_VOP, "aclk_vop", "aclk_vop_pre", 0, RK2928_CLKGATE_CON(13), 5, GFLAGS),
-	GATE(0, "aclk_vop_noc", "aclk_vop_pre", 0, RK2928_CLKGATE_CON(13), 12, GFLAGS),
+	GATE(0, "aclk_vop_noc", "aclk_vop_pre", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(13), 12, GFLAGS),
 
 	GATE(0, "aclk_hdcp", "aclk_hdcp_pre", 0, RK2928_CLKGATE_CON(14), 10, GFLAGS),
-	GATE(0, "aclk_hdcp_noc", "aclk_hdcp_pre", 0, RK2928_CLKGATE_CON(13), 10, GFLAGS),
+	GATE(0, "aclk_hdcp_noc", "aclk_hdcp_pre", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(13), 10, GFLAGS),
 
 	GATE(0, "hclk_rga", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(13), 1, GFLAGS),
 	GATE(0, "hclk_iep", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(13), 3, GFLAGS),
 	GATE(HCLK_VOP, "hclk_vop", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(13), 6, GFLAGS),
-	GATE(0, "hclk_vio_ahb_arbi", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(13), 7, GFLAGS),
-	GATE(0, "hclk_vio_noc", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(13), 8, GFLAGS),
-	GATE(0, "hclk_vop_noc", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(13), 13, GFLAGS),
+	GATE(0, "hclk_vio_ahb_arbi", "hclk_vio_pre", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(13), 7, GFLAGS),
+	GATE(0, "hclk_vio_noc", "hclk_vio_pre", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(13), 8, GFLAGS),
+	GATE(0, "hclk_vop_noc", "hclk_vio_pre", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(13), 13, GFLAGS),
 	GATE(0, "hclk_vio_h2p", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(14), 7, GFLAGS),
-	GATE(0, "hclk_hdcp_mmu", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(14), 12, GFLAGS),
+	GATE(0, "hclk_hdcp_mmu", "hclk_vio_pre", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(14), 12, GFLAGS),
 	GATE(PCLK_HDMI_CTRL, "pclk_hdmi_ctrl", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(14), 6, GFLAGS),
 	GATE(0, "pclk_vio_h2p", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(14), 8, GFLAGS),
 	GATE(0, "pclk_hdcp", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(14), 11, GFLAGS),
@@ -558,13 +558,13 @@ enum rk3228_plls {
 	GATE(HCLK_EMMC, "hclk_emmc", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 2, GFLAGS),
 	GATE(HCLK_NANDC, "hclk_nandc", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 3, GFLAGS),
 	GATE(0, "hclk_host0", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 6, GFLAGS),
-	GATE(0, "hclk_host0_arb", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 7, GFLAGS),
+	GATE(0, "hclk_host0_arb", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(11), 7, GFLAGS),
 	GATE(0, "hclk_host1", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 8, GFLAGS),
-	GATE(0, "hclk_host1_arb", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 9, GFLAGS),
+	GATE(0, "hclk_host1_arb", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(11), 9, GFLAGS),
 	GATE(0, "hclk_host2", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 10, GFLAGS),
 	GATE(0, "hclk_otg", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 12, GFLAGS),
-	GATE(0, "hclk_otg_pmu", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 13, GFLAGS),
-	GATE(0, "hclk_host2_arb", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 14, GFLAGS),
+	GATE(0, "hclk_otg_pmu", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(11), 13, GFLAGS),
+	GATE(0, "hclk_host2_arb", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(11), 14, GFLAGS),
 	GATE(0, "hclk_peri_noc", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(12), 1, GFLAGS),
 
 	GATE(PCLK_GMAC, "pclk_gmac", "pclk_peri", 0, RK2928_CLKGATE_CON(11), 5, GFLAGS),
@@ -572,15 +572,15 @@ enum rk3228_plls {
 
 	/* PD_GPU */
 	GATE(0, "aclk_gpu", "aclk_gpu_pre", 0, RK2928_CLKGATE_CON(13), 14, GFLAGS),
-	GATE(0, "aclk_gpu_noc", "aclk_gpu_pre", 0, RK2928_CLKGATE_CON(13), 15, GFLAGS),
+	GATE(0, "aclk_gpu_noc", "aclk_gpu_pre", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(13), 15, GFLAGS),
 
 	/* PD_BUS */
-	GATE(0, "sclk_initmem_mbist", "aclk_cpu", 0, RK2928_CLKGATE_CON(8), 1, GFLAGS),
-	GATE(0, "aclk_initmem", "aclk_cpu", 0, RK2928_CLKGATE_CON(8), 0, GFLAGS),
+	GATE(0, "sclk_initmem_mbist", "aclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(8), 1, GFLAGS),
+	GATE(0, "aclk_initmem", "aclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(8), 0, GFLAGS),
 	GATE(ACLK_DMAC, "aclk_dmac_bus", "aclk_cpu", 0, RK2928_CLKGATE_CON(8), 2, GFLAGS),
 	GATE(0, "aclk_bus_noc", "aclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(10), 1, GFLAGS),
 
-	GATE(0, "hclk_rom", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 3, GFLAGS),
+	GATE(0, "hclk_rom", "hclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(8), 3, GFLAGS),
 	GATE(HCLK_I2S0_8CH, "hclk_i2s0_8ch", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 7, GFLAGS),
 	GATE(HCLK_I2S1_8CH, "hclk_i2s1_8ch", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 8, GFLAGS),
 	GATE(HCLK_I2S2_2CH, "hclk_i2s2_2ch", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 9, GFLAGS),
@@ -589,18 +589,18 @@ enum rk3228_plls {
 	GATE(0, "hclk_crypto_mst", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 11, GFLAGS),
 	GATE(0, "hclk_crypto_slv", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 12, GFLAGS),
 
-	GATE(0, "pclk_ddrupctl", "pclk_ddr_pre", 0, RK2928_CLKGATE_CON(8), 4, GFLAGS),
-	GATE(0, "pclk_ddrmon", "pclk_ddr_pre", 0, RK2928_CLKGATE_CON(8), 6, GFLAGS),
-	GATE(0, "pclk_msch_noc", "pclk_ddr_pre", 0, RK2928_CLKGATE_CON(10), 2, GFLAGS),
+	GATE(0, "pclk_ddrupctl", "pclk_ddr_pre", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(8), 4, GFLAGS),
+	GATE(0, "pclk_ddrmon", "pclk_ddr_pre", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(8), 6, GFLAGS),
+	GATE(0, "pclk_msch_noc", "pclk_ddr_pre", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(10), 2, GFLAGS),
 
-	GATE(0, "pclk_efuse_1024", "pclk_cpu", 0, RK2928_CLKGATE_CON(8), 13, GFLAGS),
-	GATE(0, "pclk_efuse_256", "pclk_cpu", 0, RK2928_CLKGATE_CON(8), 14, GFLAGS),
+	GATE(0, "pclk_efuse_1024", "pclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(8), 13, GFLAGS),
+	GATE(0, "pclk_efuse_256", "pclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(8), 14, GFLAGS),
 	GATE(PCLK_I2C0, "pclk_i2c0", "pclk_cpu", 0, RK2928_CLKGATE_CON(8), 15, GFLAGS),
 	GATE(PCLK_I2C1, "pclk_i2c1", "pclk_cpu", 0, RK2928_CLKGATE_CON(9), 0, GFLAGS),
 	GATE(PCLK_I2C2, "pclk_i2c2", "pclk_cpu", 0, RK2928_CLKGATE_CON(9), 1, GFLAGS),
 	GATE(PCLK_I2C3, "pclk_i2c3", "pclk_cpu", 0, RK2928_CLKGATE_CON(9), 2, GFLAGS),
 	GATE(PCLK_TIMER, "pclk_timer0", "pclk_cpu", 0, RK2928_CLKGATE_CON(9), 4, GFLAGS),
-	GATE(0, "pclk_stimer", "pclk_cpu", 0, RK2928_CLKGATE_CON(9), 5, GFLAGS),
+	GATE(0, "pclk_stimer", "pclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(9), 5, GFLAGS),
 	GATE(PCLK_SPI0, "pclk_spi0", "pclk_cpu", 0, RK2928_CLKGATE_CON(9), 6, GFLAGS),
 	GATE(PCLK_PWM, "pclk_rk_pwm", "pclk_cpu", 0, RK2928_CLKGATE_CON(9), 7, GFLAGS),
 	GATE(PCLK_GPIO0, "pclk_gpio0", "pclk_cpu", 0, RK2928_CLKGATE_CON(9), 8, GFLAGS),
@@ -616,20 +616,20 @@ enum rk3228_plls {
 	GATE(0, "pclk_sgrf", "pclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(10), 2, GFLAGS),
 	GATE(0, "pclk_sim", "pclk_cpu", 0, RK2928_CLKGATE_CON(10), 3, GFLAGS),
 
-	GATE(0, "pclk_ddrphy", "pclk_phy_pre", 0, RK2928_CLKGATE_CON(10), 3, GFLAGS),
-	GATE(0, "pclk_acodecphy", "pclk_phy_pre", 0, RK2928_CLKGATE_CON(10), 5, GFLAGS),
+	GATE(0, "pclk_ddrphy", "pclk_phy_pre", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(10), 3, GFLAGS),
+	GATE(0, "pclk_acodecphy", "pclk_phy_pre", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(10), 5, GFLAGS),
 	GATE(PCLK_HDMI_PHY, "pclk_hdmiphy", "pclk_phy_pre", 0, RK2928_CLKGATE_CON(10), 7, GFLAGS),
 	GATE(0, "pclk_vdacphy", "pclk_phy_pre", 0, RK2928_CLKGATE_CON(10), 8, GFLAGS),
-	GATE(0, "pclk_phy_noc", "pclk_phy_pre", 0, RK2928_CLKGATE_CON(10), 9, GFLAGS),
+	GATE(0, "pclk_phy_noc", "pclk_phy_pre", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(10), 9, GFLAGS),
 
 	GATE(0, "aclk_vpu", "aclk_vpu_pre", 0, RK2928_CLKGATE_CON(15), 0, GFLAGS),
-	GATE(0, "aclk_vpu_noc", "aclk_vpu_pre", 0, RK2928_CLKGATE_CON(15), 4, GFLAGS),
+	GATE(0, "aclk_vpu_noc", "aclk_vpu_pre", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(15), 4, GFLAGS),
 	GATE(0, "aclk_rkvdec", "aclk_rkvdec_pre", 0, RK2928_CLKGATE_CON(15), 2, GFLAGS),
-	GATE(0, "aclk_rkvdec_noc", "aclk_rkvdec_pre", 0, RK2928_CLKGATE_CON(15), 6, GFLAGS),
+	GATE(0, "aclk_rkvdec_noc", "aclk_rkvdec_pre", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(15), 6, GFLAGS),
 	GATE(0, "hclk_vpu", "hclk_vpu_pre", 0, RK2928_CLKGATE_CON(15), 1, GFLAGS),
-	GATE(0, "hclk_vpu_noc", "hclk_vpu_pre", 0, RK2928_CLKGATE_CON(15), 5, GFLAGS),
+	GATE(0, "hclk_vpu_noc", "hclk_vpu_pre", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(15), 5, GFLAGS),
 	GATE(0, "hclk_rkvdec", "hclk_rkvdec_pre", 0, RK2928_CLKGATE_CON(15), 3, GFLAGS),
-	GATE(0, "hclk_rkvdec_noc", "hclk_rkvdec_pre", 0, RK2928_CLKGATE_CON(15), 7, GFLAGS),
+	GATE(0, "hclk_rkvdec_noc", "hclk_rkvdec_pre", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(15), 7, GFLAGS),
 
 	/* PD_MMC */
 	MMC(SCLK_SDMMC_DRV,    "sdmmc_drv",    "sclk_sdmmc", RK3228_SDMMC_CON0, 1),
@@ -644,6 +644,8 @@ enum rk3228_plls {
 
 static const char *const rk3228_critical_clocks[] __initconst = {
 	"aclk_cpu",
+	"pclk_cpu",
+	"hclk_cpu",
 	"aclk_peri",
 	"hclk_peri",
 	"pclk_peri",
-- 
1.9.1
