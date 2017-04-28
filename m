From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Fri, 28 Apr 2017 15:02:47 +0800
Subject: [PATCH v2 3/3] clk: rockchip: export rk3228 clocks ID
In-Reply-To: <1493362967-4040-1-git-send-email-zhangqing@rock-chips.com>
References: <1493362967-4040-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1493362967-4040-4-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch exports related BUS/VPU/RGA/HDCP/IEP/TSP/WIFI/
VIO/USB/EFUSE/GPU/CRYPTO clocks for dts reference.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-rk3228.c | 92 +++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3228.c b/drivers/clk/rockchip/clk-rk3228.c
index a6cdf8fc1e75..7ded7d63d53e 100644
--- a/drivers/clk/rockchip/clk-rk3228.c
+++ b/drivers/clk/rockchip/clk-rk3228.c
@@ -270,15 +270,15 @@ enum rk3228_plls {
 			RK2928_CLKGATE_CON(0), 1, GFLAGS),
 	COMPOSITE_NOGATE(0, "aclk_cpu_src", mux_aclk_cpu_src_p, 0,
 			RK2928_CLKSEL_CON(0), 13, 2, MFLAGS, 8, 5, DFLAGS),
-	GATE(ARMCLK, "aclk_cpu", "aclk_cpu_src", 0,
+	GATE(ACLK_CPU, "aclk_cpu", "aclk_cpu_src", 0,
 			RK2928_CLKGATE_CON(6), 0, GFLAGS),
-	COMPOSITE_NOMUX(0, "hclk_cpu", "aclk_cpu_src", 0,
+	COMPOSITE_NOMUX(HCLK_CPU, "hclk_cpu", "aclk_cpu_src", 0,
 			RK2928_CLKSEL_CON(1), 8, 2, DFLAGS,
 			RK2928_CLKGATE_CON(6), 1, GFLAGS),
 	COMPOSITE_NOMUX(0, "pclk_bus_src", "aclk_cpu_src", 0,
 			RK2928_CLKSEL_CON(1), 12, 3, DFLAGS,
 			RK2928_CLKGATE_CON(6), 2, GFLAGS),
-	GATE(0, "pclk_cpu", "pclk_bus_src", 0,
+	GATE(PCLK_CPU, "pclk_cpu", "pclk_bus_src", 0,
 			RK2928_CLKGATE_CON(6), 3, GFLAGS),
 	GATE(0, "pclk_phy_pre", "pclk_bus_src", 0,
 			RK2928_CLKGATE_CON(6), 4, GFLAGS),
@@ -286,58 +286,58 @@ enum rk3228_plls {
 			RK2928_CLKGATE_CON(6), 13, GFLAGS),
 
 	/* PD_VIDEO */
-	COMPOSITE(0, "aclk_vpu_pre", mux_pll_src_4plls_p, 0,
+	COMPOSITE(ACLK_VPU_PRE, "aclk_vpu_pre", mux_pll_src_4plls_p, 0,
 			RK2928_CLKSEL_CON(32), 5, 2, MFLAGS, 0, 5, DFLAGS,
 			RK2928_CLKGATE_CON(3), 11, GFLAGS),
-	FACTOR_GATE(0, "hclk_vpu_pre", "aclk_vpu_pre", 0, 1, 4,
+	FACTOR_GATE(HCLK_VPU_PRE, "hclk_vpu_pre", "aclk_vpu_pre", 0, 1, 4,
 			RK2928_CLKGATE_CON(4), 4, GFLAGS),
 
-	COMPOSITE(0, "aclk_rkvdec_pre", mux_pll_src_4plls_p, 0,
+	COMPOSITE(ACLK_RKVDEC_PRE, "aclk_rkvdec_pre", mux_pll_src_4plls_p, 0,
 			RK2928_CLKSEL_CON(28), 6, 2, MFLAGS, 0, 5, DFLAGS,
 			RK2928_CLKGATE_CON(3), 2, GFLAGS),
-	FACTOR_GATE(0, "hclk_rkvdec_pre", "aclk_rkvdec_pre", 0, 1, 4,
+	FACTOR_GATE(HCLK_RKVDEC_PRE, "hclk_rkvdec_pre", "aclk_rkvdec_pre", 0, 1, 4,
 			RK2928_CLKGATE_CON(4), 5, GFLAGS),
 
-	COMPOSITE(0, "sclk_vdec_cabac", mux_pll_src_4plls_p, 0,
+	COMPOSITE(SCLK_VDEC_CABAC, "sclk_vdec_cabac", mux_pll_src_4plls_p, 0,
 			RK2928_CLKSEL_CON(28), 14, 2, MFLAGS, 8, 5, DFLAGS,
 			RK2928_CLKGATE_CON(3), 3, GFLAGS),
 
-	COMPOSITE(0, "sclk_vdec_core", mux_pll_src_4plls_p, 0,
+	COMPOSITE(SCLK_VDEC_CORE, "sclk_vdec_core", mux_pll_src_4plls_p, 0,
 			RK2928_CLKSEL_CON(34), 13, 2, MFLAGS, 8, 5, DFLAGS,
 			RK2928_CLKGATE_CON(3), 4, GFLAGS),
 
 	/* PD_VIO */
-	COMPOSITE(0, "aclk_iep_pre", mux_pll_src_4plls_p, 0,
+	COMPOSITE(ACLK_IEP_PRE, "aclk_iep_pre", mux_pll_src_4plls_p, 0,
 			RK2928_CLKSEL_CON(31), 5, 2, MFLAGS, 0, 5, DFLAGS,
 			RK2928_CLKGATE_CON(3), 0, GFLAGS),
-	DIV(0, "hclk_vio_pre", "aclk_iep_pre", 0,
+	DIV(HCLK_VIO_PRE, "hclk_vio_pre", "aclk_iep_pre", 0,
 			RK2928_CLKSEL_CON(2), 0, 5, DFLAGS),
 
-	COMPOSITE(0, "aclk_hdcp_pre", mux_pll_src_4plls_p, 0,
+	COMPOSITE(ACLK_HDCP_PRE, "aclk_hdcp_pre", mux_pll_src_4plls_p, 0,
 			RK2928_CLKSEL_CON(31), 13, 2, MFLAGS, 8, 5, DFLAGS,
 			RK2928_CLKGATE_CON(1), 4, GFLAGS),
 
 	MUX(0, "sclk_rga_src", mux_pll_src_4plls_p, 0,
 			RK2928_CLKSEL_CON(33), 13, 2, MFLAGS),
-	COMPOSITE_NOMUX(0, "aclk_rga_pre", "sclk_rga_src", 0,
+	COMPOSITE_NOMUX(ACLK_RGA_PRE, "aclk_rga_pre", "sclk_rga_src", 0,
 			RK2928_CLKSEL_CON(33), 8, 5, DFLAGS,
 			RK2928_CLKGATE_CON(1), 2, GFLAGS),
-	COMPOSITE(0, "sclk_rga", mux_sclk_rga_p, 0,
+	COMPOSITE(SCLK_RGA, "sclk_rga", mux_sclk_rga_p, 0,
 			RK2928_CLKSEL_CON(22), 5, 2, MFLAGS, 0, 5, DFLAGS,
 			RK2928_CLKGATE_CON(3), 6, GFLAGS),
 
-	COMPOSITE(0, "aclk_vop_pre", mux_pll_src_4plls_p, 0,
+	COMPOSITE(ACLK_VOP_PRE, "aclk_vop_pre", mux_pll_src_4plls_p, 0,
 			RK2928_CLKSEL_CON(33), 5, 2, MFLAGS, 0, 5, DFLAGS,
 			RK2928_CLKGATE_CON(1), 1, GFLAGS),
 
-	COMPOSITE(0, "sclk_hdcp", mux_pll_src_3plls_p, 0,
+	COMPOSITE(SCLK_HDCP, "sclk_hdcp", mux_pll_src_3plls_p, 0,
 			RK2928_CLKSEL_CON(23), 14, 2, MFLAGS, 8, 6, DFLAGS,
 			RK2928_CLKGATE_CON(3), 5, GFLAGS),
 
 	GATE(SCLK_HDMI_HDCP, "sclk_hdmi_hdcp", "xin24m", 0,
 			RK2928_CLKGATE_CON(3), 7, GFLAGS),
 
-	COMPOSITE(0, "sclk_hdmi_cec", mux_sclk_hdmi_cec_p, 0,
+	COMPOSITE(SCLK_HDMI_CEC, "sclk_hdmi_cec", mux_sclk_hdmi_cec_p, 0,
 			RK2928_CLKSEL_CON(21), 14, 2, MFLAGS, 0, 14, DFLAGS,
 			RK2928_CLKGATE_CON(3), 8, GFLAGS),
 
@@ -372,18 +372,18 @@ enum rk3228_plls {
 	GATE(SCLK_TIMER5, "sclk_timer5", "xin24m", 0,
 			RK2928_CLKGATE_CON(6), 10, GFLAGS),
 
-	COMPOSITE(0, "sclk_crypto", mux_pll_src_2plls_p, 0,
+	COMPOSITE(SCLK_CRYPTO, "sclk_crypto", mux_pll_src_2plls_p, 0,
 			RK2928_CLKSEL_CON(24), 5, 1, MFLAGS, 0, 5, DFLAGS,
 			RK2928_CLKGATE_CON(2), 7, GFLAGS),
 
-	COMPOSITE(0, "sclk_tsp", mux_pll_src_2plls_p, 0,
+	COMPOSITE(SCLK_TSP, "sclk_tsp", mux_pll_src_2plls_p, 0,
 			RK2928_CLKSEL_CON(22), 15, 1, MFLAGS, 8, 5, DFLAGS,
 			RK2928_CLKGATE_CON(2), 6, GFLAGS),
 
-	GATE(0, "sclk_hsadc", "ext_hsadc", 0,
+	GATE(SCLK_HSADC, "sclk_hsadc", "ext_hsadc", 0,
 			RK2928_CLKGATE_CON(10), 12, GFLAGS),
 
-	COMPOSITE(0, "sclk_wifi", mux_pll_src_cpll_gpll_usb480m_p, 0,
+	COMPOSITE(SCLK_WIFI, "sclk_wifi", mux_pll_src_cpll_gpll_usb480m_p, 0,
 			RK2928_CLKSEL_CON(23), 5, 2, MFLAGS, 0, 6, DFLAGS,
 			RK2928_CLKGATE_CON(2), 15, GFLAGS),
 
@@ -466,9 +466,9 @@ enum rk3228_plls {
 	GATE(0, "jtag", "ext_jtag", 0,
 			RK2928_CLKGATE_CON(1), 3, GFLAGS),
 
-	GATE(0, "sclk_otgphy0", "xin24m", 0,
+	GATE(SCLK_OTGPHY0, "sclk_otgphy0", "xin24m", 0,
 			RK2928_CLKGATE_CON(1), 5, GFLAGS),
-	GATE(0, "sclk_otgphy1", "xin24m", 0,
+	GATE(SCLK_OTGPHY1, "sclk_otgphy1", "xin24m", 0,
 			RK2928_CLKGATE_CON(1), 6, GFLAGS),
 
 	COMPOSITE_NOMUX(SCLK_TSADC, "sclk_tsadc", "xin24m", 0,
@@ -544,28 +544,28 @@ enum rk3228_plls {
 	 */
 
 	/* PD_VOP */
-	GATE(0, "aclk_rga", "aclk_rga_pre", 0, RK2928_CLKGATE_CON(13), 0, GFLAGS),
+	GATE(ACLK_RGA, "aclk_rga", "aclk_rga_pre", 0, RK2928_CLKGATE_CON(13), 0, GFLAGS),
 	GATE(0, "aclk_rga_noc", "aclk_rga_pre", 0, RK2928_CLKGATE_CON(13), 11, GFLAGS),
-	GATE(0, "aclk_iep", "aclk_iep_pre", 0, RK2928_CLKGATE_CON(13), 2, GFLAGS),
+	GATE(ACLK_IEP, "aclk_iep", "aclk_iep_pre", 0, RK2928_CLKGATE_CON(13), 2, GFLAGS),
 	GATE(0, "aclk_iep_noc", "aclk_iep_pre", 0, RK2928_CLKGATE_CON(13), 9, GFLAGS),
 
 	GATE(ACLK_VOP, "aclk_vop", "aclk_vop_pre", 0, RK2928_CLKGATE_CON(13), 5, GFLAGS),
 	GATE(0, "aclk_vop_noc", "aclk_vop_pre", 0, RK2928_CLKGATE_CON(13), 12, GFLAGS),
 
-	GATE(0, "aclk_hdcp", "aclk_hdcp_pre", 0, RK2928_CLKGATE_CON(14), 10, GFLAGS),
+	GATE(ACLK_HDCP, "aclk_hdcp", "aclk_hdcp_pre", 0, RK2928_CLKGATE_CON(14), 10, GFLAGS),
 	GATE(0, "aclk_hdcp_noc", "aclk_hdcp_pre", 0, RK2928_CLKGATE_CON(13), 10, GFLAGS),
 
-	GATE(0, "hclk_rga", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(13), 1, GFLAGS),
-	GATE(0, "hclk_iep", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(13), 3, GFLAGS),
+	GATE(HCLK_RGA, "hclk_rga", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(13), 1, GFLAGS),
+	GATE(HCLK_IEP, "hclk_iep", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(13), 3, GFLAGS),
 	GATE(HCLK_VOP, "hclk_vop", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(13), 6, GFLAGS),
 	GATE(0, "hclk_vio_ahb_arbi", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(13), 7, GFLAGS),
 	GATE(0, "hclk_vio_noc", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(13), 8, GFLAGS),
 	GATE(0, "hclk_vop_noc", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(13), 13, GFLAGS),
-	GATE(0, "hclk_vio_h2p", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(14), 7, GFLAGS),
-	GATE(0, "hclk_hdcp_mmu", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(14), 12, GFLAGS),
+	GATE(HCLK_VIO_H2P, "hclk_vio_h2p", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(14), 7, GFLAGS),
+	GATE(HCLK_HDCP_MMU, "hclk_hdcp_mmu", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(14), 12, GFLAGS),
 	GATE(PCLK_HDMI_CTRL, "pclk_hdmi_ctrl", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(14), 6, GFLAGS),
-	GATE(0, "pclk_vio_h2p", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(14), 8, GFLAGS),
-	GATE(0, "pclk_hdcp", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(14), 11, GFLAGS),
+	GATE(PCLK_VIO_H2P, "pclk_vio_h2p", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(14), 8, GFLAGS),
+	GATE(PCLK_HDCP, "pclk_hdcp", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(14), 11, GFLAGS),
 
 	/* PD_PERI */
 	GATE(0, "aclk_peri_noc", "aclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(12), 0, GFLAGS),
@@ -575,12 +575,12 @@ enum rk3228_plls {
 	GATE(HCLK_SDIO, "hclk_sdio", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 1, GFLAGS),
 	GATE(HCLK_EMMC, "hclk_emmc", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 2, GFLAGS),
 	GATE(HCLK_NANDC, "hclk_nandc", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 3, GFLAGS),
-	GATE(0, "hclk_host0", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 6, GFLAGS),
+	GATE(HCLK_HOST0, "hclk_host0", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 6, GFLAGS),
 	GATE(0, "hclk_host0_arb", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 7, GFLAGS),
-	GATE(0, "hclk_host1", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 8, GFLAGS),
+	GATE(HCLK_HOST1, "hclk_host1", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 8, GFLAGS),
 	GATE(0, "hclk_host1_arb", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 9, GFLAGS),
-	GATE(0, "hclk_host2", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 10, GFLAGS),
-	GATE(0, "hclk_otg", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 12, GFLAGS),
+	GATE(HCLK_HOST2, "hclk_host2", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 10, GFLAGS),
+	GATE(HCLK_OTG, "hclk_otg", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 12, GFLAGS),
 	GATE(0, "hclk_otg_pmu", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 13, GFLAGS),
 	GATE(0, "hclk_host2_arb", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 14, GFLAGS),
 	GATE(0, "hclk_peri_noc", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(12), 1, GFLAGS),
@@ -589,7 +589,7 @@ enum rk3228_plls {
 	GATE(0, "pclk_peri_noc", "pclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(12), 2, GFLAGS),
 
 	/* PD_GPU */
-	GATE(0, "aclk_gpu", "aclk_gpu_pre", 0, RK2928_CLKGATE_CON(13), 14, GFLAGS),
+	GATE(ACLK_GPU, "aclk_gpu", "aclk_gpu_pre", 0, RK2928_CLKGATE_CON(13), 14, GFLAGS),
 	GATE(0, "aclk_gpu_noc", "aclk_gpu_pre", 0, RK2928_CLKGATE_CON(13), 15, GFLAGS),
 
 	/* PD_BUS */
@@ -603,16 +603,16 @@ enum rk3228_plls {
 	GATE(HCLK_I2S1_8CH, "hclk_i2s1_8ch", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 8, GFLAGS),
 	GATE(HCLK_I2S2_2CH, "hclk_i2s2_2ch", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 9, GFLAGS),
 	GATE(HCLK_SPDIF_8CH, "hclk_spdif_8ch", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 10, GFLAGS),
-	GATE(0, "hclk_tsp", "hclk_cpu", 0, RK2928_CLKGATE_CON(10), 11, GFLAGS),
-	GATE(0, "hclk_crypto_mst", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 11, GFLAGS),
-	GATE(0, "hclk_crypto_slv", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 12, GFLAGS),
+	GATE(HCLK_TSP, "hclk_tsp", "hclk_cpu", 0, RK2928_CLKGATE_CON(10), 11, GFLAGS),
+	GATE(HCLK_M_CRYPTO, "hclk_crypto_mst", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 11, GFLAGS),
+	GATE(HCLK_S_CRYPTO, "hclk_crypto_slv", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 12, GFLAGS),
 
 	GATE(0, "pclk_ddrupctl", "pclk_ddr_pre", 0, RK2928_CLKGATE_CON(8), 4, GFLAGS),
 	GATE(0, "pclk_ddrmon", "pclk_ddr_pre", 0, RK2928_CLKGATE_CON(8), 6, GFLAGS),
 	GATE(0, "pclk_msch_noc", "pclk_ddr_pre", 0, RK2928_CLKGATE_CON(10), 2, GFLAGS),
 
-	GATE(0, "pclk_efuse_1024", "pclk_cpu", 0, RK2928_CLKGATE_CON(8), 13, GFLAGS),
-	GATE(0, "pclk_efuse_256", "pclk_cpu", 0, RK2928_CLKGATE_CON(8), 14, GFLAGS),
+	GATE(PCLK_EFUSE_1024, "pclk_efuse_1024", "pclk_cpu", 0, RK2928_CLKGATE_CON(8), 13, GFLAGS),
+	GATE(PCLK_EFUSE_256, "pclk_efuse_256", "pclk_cpu", 0, RK2928_CLKGATE_CON(8), 14, GFLAGS),
 	GATE(PCLK_I2C0, "pclk_i2c0", "pclk_cpu", 0, RK2928_CLKGATE_CON(8), 15, GFLAGS),
 	GATE(PCLK_I2C1, "pclk_i2c1", "pclk_cpu", 0, RK2928_CLKGATE_CON(9), 0, GFLAGS),
 	GATE(PCLK_I2C2, "pclk_i2c2", "pclk_cpu", 0, RK2928_CLKGATE_CON(9), 1, GFLAGS),
@@ -640,13 +640,13 @@ enum rk3228_plls {
 	GATE(0, "pclk_vdacphy", "pclk_phy_pre", 0, RK2928_CLKGATE_CON(10), 8, GFLAGS),
 	GATE(0, "pclk_phy_noc", "pclk_phy_pre", 0, RK2928_CLKGATE_CON(10), 9, GFLAGS),
 
-	GATE(0, "aclk_vpu", "aclk_vpu_pre", 0, RK2928_CLKGATE_CON(15), 0, GFLAGS),
+	GATE(ACLK_VPU, "aclk_vpu", "aclk_vpu_pre", 0, RK2928_CLKGATE_CON(15), 0, GFLAGS),
 	GATE(0, "aclk_vpu_noc", "aclk_vpu_pre", 0, RK2928_CLKGATE_CON(15), 4, GFLAGS),
-	GATE(0, "aclk_rkvdec", "aclk_rkvdec_pre", 0, RK2928_CLKGATE_CON(15), 2, GFLAGS),
+	GATE(ACLK_RKVDEC, "aclk_rkvdec", "aclk_rkvdec_pre", 0, RK2928_CLKGATE_CON(15), 2, GFLAGS),
 	GATE(0, "aclk_rkvdec_noc", "aclk_rkvdec_pre", 0, RK2928_CLKGATE_CON(15), 6, GFLAGS),
-	GATE(0, "hclk_vpu", "hclk_vpu_pre", 0, RK2928_CLKGATE_CON(15), 1, GFLAGS),
+	GATE(HCLK_VPU, "hclk_vpu", "hclk_vpu_pre", 0, RK2928_CLKGATE_CON(15), 1, GFLAGS),
 	GATE(0, "hclk_vpu_noc", "hclk_vpu_pre", 0, RK2928_CLKGATE_CON(15), 5, GFLAGS),
-	GATE(0, "hclk_rkvdec", "hclk_rkvdec_pre", 0, RK2928_CLKGATE_CON(15), 3, GFLAGS),
+	GATE(HCLK_RKVDEC, "hclk_rkvdec", "hclk_rkvdec_pre", 0, RK2928_CLKGATE_CON(15), 3, GFLAGS),
 	GATE(0, "hclk_rkvdec_noc", "hclk_rkvdec_pre", 0, RK2928_CLKGATE_CON(15), 7, GFLAGS),
 
 	/* PD_MMC */
-- 
1.9.1
