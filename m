From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 08 Apr 2015 15:22:13 +0200
Subject: [PATCH 2/8] clk: exynos: Staticize file-scope declarations
In-Reply-To: <1428499339-29569-1-git-send-email-k.kozlowski@samsung.com>
References: <1428499339-29569-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1428499339-29569-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing static to local (file-scope only) symbols.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos5260.c | 74 ++++++++++++++++++------------------
 drivers/clk/samsung/clk-exynos5420.c | 10 ++---
 2 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5260.c b/drivers/clk/samsung/clk-exynos5260.c
index e2e5193d1049..df1d83c45554 100644
--- a/drivers/clk/samsung/clk-exynos5260.c
+++ b/drivers/clk/samsung/clk-exynos5260.c
@@ -94,7 +94,7 @@ PNAME(mout_aud_pll_user_p) = {"fin_pll", "fout_aud_pll"};
 PNAME(mout_sclk_aud_i2s_p) = {"mout_aud_pll_user", "ioclk_i2s_cdclk"};
 PNAME(mout_sclk_aud_pcm_p) = {"mout_aud_pll_user", "ioclk_pcm_extclk"};
 
-struct samsung_mux_clock aud_mux_clks[] __initdata = {
+static struct samsung_mux_clock aud_mux_clks[] __initdata = {
 	MUX(AUD_MOUT_AUD_PLL_USER, "mout_aud_pll_user", mout_aud_pll_user_p,
 			MUX_SEL_AUD, 0, 1),
 	MUX(AUD_MOUT_SCLK_AUD_I2S, "mout_sclk_aud_i2s", mout_sclk_aud_i2s_p,
@@ -103,7 +103,7 @@ struct samsung_mux_clock aud_mux_clks[] __initdata = {
 			MUX_SEL_AUD, 8, 1),
 };
 
-struct samsung_div_clock aud_div_clks[] __initdata = {
+static struct samsung_div_clock aud_div_clks[] __initdata = {
 	DIV(AUD_DOUT_ACLK_AUD_131, "dout_aclk_aud_131", "mout_aud_pll_user",
 			DIV_AUD0, 0, 4),
 
@@ -115,7 +115,7 @@ struct samsung_div_clock aud_div_clks[] __initdata = {
 			DIV_AUD1, 12, 4),
 };
 
-struct samsung_gate_clock aud_gate_clks[] __initdata = {
+static struct samsung_gate_clock aud_gate_clks[] __initdata = {
 	GATE(AUD_SCLK_I2S, "sclk_aud_i2s", "dout_sclk_aud_i2s",
 			EN_SCLK_AUD, 0, CLK_SET_RATE_PARENT, 0),
 	GATE(AUD_SCLK_PCM, "sclk_aud_pcm", "dout_sclk_aud_pcm",
@@ -203,7 +203,7 @@ PNAME(mout_phyclk_mipi_dphy_4lmrxclk_esc0_user_p) = {"fin_pll",
 PNAME(mout_sclk_hdmi_spdif_p) = {"fin_pll", "ioclk_spdif_extclk",
 			"dout_aclk_peri_aud", "phyclk_hdmi_phy_ref_cko"};
 
-struct samsung_mux_clock disp_mux_clks[] __initdata = {
+static struct samsung_mux_clock disp_mux_clks[] __initdata = {
 	MUX(DISP_MOUT_ACLK_DISP_333_USER, "mout_aclk_disp_333_user",
 			mout_aclk_disp_333_user_p,
 			MUX_SEL_DISP0, 0, 1),
@@ -272,7 +272,7 @@ struct samsung_mux_clock disp_mux_clks[] __initdata = {
 			MUX_SEL_DISP4, 4, 2),
 };
 
-struct samsung_div_clock disp_div_clks[] __initdata = {
+static struct samsung_div_clock disp_div_clks[] __initdata = {
 	DIV(DISP_DOUT_PCLK_DISP_111, "dout_pclk_disp_111",
 			"mout_aclk_disp_222_user",
 			DIV_DISP, 8, 4),
@@ -285,7 +285,7 @@ struct samsung_div_clock disp_div_clks[] __initdata = {
 			DIV_DISP, 16, 4),
 };
 
-struct samsung_gate_clock disp_gate_clks[] __initdata = {
+static struct samsung_gate_clock disp_gate_clks[] __initdata = {
 	GATE(DISP_MOUT_HDMI_PHY_PIXEL_USER, "sclk_hdmi_link_i_pixel",
 			"mout_phyclk_hdmi_phy_pixel_clko_user",
 			EN_SCLK_DISP0, 26, CLK_SET_RATE_PARENT, 0),
@@ -363,13 +363,13 @@ static unsigned long egl_clk_regs[] __initdata = {
 PNAME(mout_egl_b_p) = {"mout_egl_pll", "dout_bus_pll"};
 PNAME(mout_egl_pll_p) = {"fin_pll", "fout_egl_pll"};
 
-struct samsung_mux_clock egl_mux_clks[] __initdata = {
+static struct samsung_mux_clock egl_mux_clks[] __initdata = {
 	MUX(EGL_MOUT_EGL_PLL, "mout_egl_pll", mout_egl_pll_p,
 			MUX_SEL_EGL, 4, 1),
 	MUX(EGL_MOUT_EGL_B, "mout_egl_b", mout_egl_b_p, MUX_SEL_EGL, 16, 1),
 };
 
-struct samsung_div_clock egl_div_clks[] __initdata = {
+static struct samsung_div_clock egl_div_clks[] __initdata = {
 	DIV(EGL_DOUT_EGL1, "dout_egl1", "mout_egl_b", DIV_EGL, 0, 3),
 	DIV(EGL_DOUT_EGL2, "dout_egl2", "dout_egl1", DIV_EGL, 4, 3),
 	DIV(EGL_DOUT_ACLK_EGL, "dout_aclk_egl", "dout_egl2", DIV_EGL, 8, 3),
@@ -433,7 +433,7 @@ PNAME(mout_phyclk_usbdrd30_pipe_pclk_user_p) = {"fin_pll",
 PNAME(mout_phyclk_usbdrd30_phyclock_user_p) = {"fin_pll",
 			"phyclk_usbdrd30_udrd30_phyclock"};
 
-struct samsung_mux_clock fsys_mux_clks[] __initdata = {
+static struct samsung_mux_clock fsys_mux_clks[] __initdata = {
 	MUX(FSYS_MOUT_PHYCLK_USBDRD30_PHYCLOCK_USER,
 			"mout_phyclk_usbdrd30_phyclock_user",
 			mout_phyclk_usbdrd30_phyclock_user_p,
@@ -456,7 +456,7 @@ struct samsung_mux_clock fsys_mux_clks[] __initdata = {
 			MUX_SEL_FSYS1, 16, 1),
 };
 
-struct samsung_gate_clock fsys_gate_clks[] __initdata = {
+static struct samsung_gate_clock fsys_gate_clks[] __initdata = {
 	GATE(FSYS_PHYCLK_USBHOST20, "phyclk_usbhost20_phyclock",
 			"mout_phyclk_usbdrd30_phyclock_user",
 			EN_SCLK_FSYS, 1, 0, 0),
@@ -537,18 +537,18 @@ static unsigned long g2d_clk_regs[] __initdata = {
 
 PNAME(mout_aclk_g2d_333_user_p) = {"fin_pll", "dout_aclk_g2d_333"};
 
-struct samsung_mux_clock g2d_mux_clks[] __initdata = {
+static struct samsung_mux_clock g2d_mux_clks[] __initdata = {
 	MUX(G2D_MOUT_ACLK_G2D_333_USER, "mout_aclk_g2d_333_user",
 			mout_aclk_g2d_333_user_p,
 			MUX_SEL_G2D, 0, 1),
 };
 
-struct samsung_div_clock g2d_div_clks[] __initdata = {
+static struct samsung_div_clock g2d_div_clks[] __initdata = {
 	DIV(G2D_DOUT_PCLK_G2D_83, "dout_pclk_g2d_83", "mout_aclk_g2d_333_user",
 			DIV_G2D, 0, 3),
 };
 
-struct samsung_gate_clock g2d_gate_clks[] __initdata = {
+static struct samsung_gate_clock g2d_gate_clks[] __initdata = {
 	GATE(G2D_CLK_G2D, "clk_g2d", "mout_aclk_g2d_333_user",
 			EN_IP_G2D, 4, 0, 0),
 	GATE(G2D_CLK_JPEG, "clk_jpeg", "mout_aclk_g2d_333_user",
@@ -617,17 +617,17 @@ static unsigned long g3d_clk_regs[] __initdata = {
 
 PNAME(mout_g3d_pll_p) = {"fin_pll", "fout_g3d_pll"};
 
-struct samsung_mux_clock g3d_mux_clks[] __initdata = {
+static struct samsung_mux_clock g3d_mux_clks[] __initdata = {
 	MUX(G3D_MOUT_G3D_PLL, "mout_g3d_pll", mout_g3d_pll_p,
 			MUX_SEL_G3D, 0, 1),
 };
 
-struct samsung_div_clock g3d_div_clks[] __initdata = {
+static struct samsung_div_clock g3d_div_clks[] __initdata = {
 	DIV(G3D_DOUT_PCLK_G3D, "dout_pclk_g3d", "dout_aclk_g3d", DIV_G3D, 0, 3),
 	DIV(G3D_DOUT_ACLK_G3D, "dout_aclk_g3d", "mout_g3d_pll", DIV_G3D, 4, 3),
 };
 
-struct samsung_gate_clock g3d_gate_clks[] __initdata = {
+static struct samsung_gate_clock g3d_gate_clks[] __initdata = {
 	GATE(G3D_CLK_G3D, "clk_g3d", "dout_aclk_g3d", EN_IP_G3D, 2, 0, 0),
 	GATE(G3D_CLK_G3D_HPM, "clk_g3d_hpm", "dout_aclk_g3d",
 			EN_IP_G3D, 3, 0, 0),
@@ -694,7 +694,7 @@ PNAME(mout_aclk_m2m_400_user_p) = {"fin_pll", "dout_aclk_gscl_400"};
 PNAME(mout_aclk_gscl_fimc_user_p) = {"fin_pll", "dout_aclk_gscl_400"};
 PNAME(mout_aclk_csis_p) = {"dout_aclk_csis_200", "mout_aclk_gscl_fimc_user"};
 
-struct samsung_mux_clock gscl_mux_clks[] __initdata = {
+static struct samsung_mux_clock gscl_mux_clks[] __initdata = {
 	MUX(GSCL_MOUT_ACLK_GSCL_333_USER, "mout_aclk_gscl_333_user",
 			mout_aclk_gscl_333_user_p,
 			MUX_SEL_GSCL, 0, 1),
@@ -708,7 +708,7 @@ struct samsung_mux_clock gscl_mux_clks[] __initdata = {
 			MUX_SEL_GSCL, 24, 1),
 };
 
-struct samsung_div_clock gscl_div_clks[] __initdata = {
+static struct samsung_div_clock gscl_div_clks[] __initdata = {
 	DIV(GSCL_DOUT_PCLK_M2M_100, "dout_pclk_m2m_100",
 			"mout_aclk_m2m_400_user",
 			DIV_GSCL, 0, 3),
@@ -717,7 +717,7 @@ struct samsung_div_clock gscl_div_clks[] __initdata = {
 			DIV_GSCL, 4, 3),
 };
 
-struct samsung_gate_clock gscl_gate_clks[] __initdata = {
+static struct samsung_gate_clock gscl_gate_clks[] __initdata = {
 	GATE(GSCL_SCLK_CSIS0_WRAP, "sclk_csis0_wrap", "dout_aclk_csis_200",
 			EN_SCLK_GSCL_FIMC, 0, CLK_SET_RATE_PARENT, 0),
 	GATE(GSCL_SCLK_CSIS1_WRAP, "sclk_csis1_wrap", "dout_aclk_csis_200",
@@ -813,14 +813,14 @@ static unsigned long isp_clk_regs[] __initdata = {
 PNAME(mout_isp_400_user_p) = {"fin_pll", "dout_aclk_isp1_400"};
 PNAME(mout_isp_266_user_p)	 = {"fin_pll", "dout_aclk_isp1_266"};
 
-struct samsung_mux_clock isp_mux_clks[] __initdata = {
+static struct samsung_mux_clock isp_mux_clks[] __initdata = {
 	MUX(ISP_MOUT_ISP_266_USER, "mout_isp_266_user", mout_isp_266_user_p,
 			MUX_SEL_ISP0, 0, 1),
 	MUX(ISP_MOUT_ISP_400_USER, "mout_isp_400_user", mout_isp_400_user_p,
 			MUX_SEL_ISP0, 4, 1),
 };
 
-struct samsung_div_clock isp_div_clks[] __initdata = {
+static struct samsung_div_clock isp_div_clks[] __initdata = {
 	DIV(ISP_DOUT_PCLK_ISP_66, "dout_pclk_isp_66", "mout_kfc",
 			DIV_ISP, 0, 3),
 	DIV(ISP_DOUT_PCLK_ISP_133, "dout_pclk_isp_133", "mout_kfc",
@@ -832,7 +832,7 @@ struct samsung_div_clock isp_div_clks[] __initdata = {
 	DIV(ISP_DOUT_SCLK_MPWM, "dout_sclk_mpwm", "mout_kfc", DIV_ISP, 20, 2),
 };
 
-struct samsung_gate_clock isp_gate_clks[] __initdata = {
+static struct samsung_gate_clock isp_gate_clks[] __initdata = {
 	GATE(ISP_CLK_GIC, "clk_isp_gic", "mout_aclk_isp1_266",
 			EN_IP_ISP0, 15, 0, 0),
 
@@ -934,13 +934,13 @@ static unsigned long kfc_clk_regs[] __initdata = {
 PNAME(mout_kfc_pll_p) = {"fin_pll", "fout_kfc_pll"};
 PNAME(mout_kfc_p)	 = {"mout_kfc_pll", "dout_media_pll"};
 
-struct samsung_mux_clock kfc_mux_clks[] __initdata = {
+static struct samsung_mux_clock kfc_mux_clks[] __initdata = {
 	MUX(KFC_MOUT_KFC_PLL, "mout_kfc_pll", mout_kfc_pll_p,
 			MUX_SEL_KFC0, 0, 1),
 	MUX(KFC_MOUT_KFC, "mout_kfc", mout_kfc_p, MUX_SEL_KFC2, 0, 1),
 };
 
-struct samsung_div_clock kfc_div_clks[] __initdata = {
+static struct samsung_div_clock kfc_div_clks[] __initdata = {
 	DIV(KFC_DOUT_KFC1, "dout_kfc1", "mout_kfc", DIV_KFC, 0, 3),
 	DIV(KFC_DOUT_KFC2, "dout_kfc2", "dout_kfc1", DIV_KFC, 4, 3),
 	DIV(KFC_DOUT_KFC_ATCLK, "dout_kfc_atclk", "dout_kfc2", DIV_KFC, 8, 3),
@@ -993,18 +993,18 @@ static unsigned long mfc_clk_regs[] __initdata = {
 
 PNAME(mout_aclk_mfc_333_user_p) = {"fin_pll", "dout_aclk_mfc_333"};
 
-struct samsung_mux_clock mfc_mux_clks[] __initdata = {
+static struct samsung_mux_clock mfc_mux_clks[] __initdata = {
 	MUX(MFC_MOUT_ACLK_MFC_333_USER, "mout_aclk_mfc_333_user",
 			mout_aclk_mfc_333_user_p,
 			MUX_SEL_MFC, 0, 1),
 };
 
-struct samsung_div_clock mfc_div_clks[] __initdata = {
+static struct samsung_div_clock mfc_div_clks[] __initdata = {
 	DIV(MFC_DOUT_PCLK_MFC_83, "dout_pclk_mfc_83", "mout_aclk_mfc_333_user",
 			DIV_MFC, 0, 3),
 };
 
-struct samsung_gate_clock mfc_gate_clks[] __initdata = {
+static struct samsung_gate_clock mfc_gate_clks[] __initdata = {
 	GATE(MFC_CLK_MFC, "clk_mfc", "mout_aclk_mfc_333_user",
 			EN_IP_MFC, 1, 0, 0),
 	GATE(MFC_CLK_SMMU2_MFCM0, "clk_smmu2_mfcm0", "mout_aclk_mfc_333_user",
@@ -1078,7 +1078,7 @@ PNAME(mout_mif_drex2x_p) = {"dout_mem_pll", "dout_bus_pll"};
 PNAME(mout_clkm_phy_p) = {"mout_mif_drex", "dout_media_pll"};
 PNAME(mout_clk2x_phy_p) = {"mout_mif_drex2x", "dout_media_pll"};
 
-struct samsung_mux_clock mif_mux_clks[] __initdata = {
+static struct samsung_mux_clock mif_mux_clks[] __initdata = {
 	MUX(MIF_MOUT_MEM_PLL, "mout_mem_pll", mout_mem_pll_p,
 			MUX_SEL_MIF, 0, 1),
 	MUX(MIF_MOUT_BUS_PLL, "mout_bus_pll", mout_bus_pll_p,
@@ -1095,7 +1095,7 @@ struct samsung_mux_clock mif_mux_clks[] __initdata = {
 			MUX_SEL_MIF, 24, 1),
 };
 
-struct samsung_div_clock mif_div_clks[] __initdata = {
+static struct samsung_div_clock mif_div_clks[] __initdata = {
 	DIV(MIF_DOUT_MEDIA_PLL, "dout_media_pll", "mout_media_pll",
 			DIV_MIF, 0, 3),
 	DIV(MIF_DOUT_MEM_PLL, "dout_mem_pll", "mout_mem_pll",
@@ -1114,7 +1114,7 @@ struct samsung_div_clock mif_div_clks[] __initdata = {
 			DIV_MIF, 28, 4),
 };
 
-struct samsung_gate_clock mif_gate_clks[] __initdata = {
+static struct samsung_gate_clock mif_gate_clks[] __initdata = {
 	GATE(MIF_CLK_LPDDR3PHY_WRAP0, "clk_lpddr3phy_wrap0", "dout_clk2x_phy",
 			EN_IP_MIF, 12, CLK_IGNORE_UNUSED, 0),
 	GATE(MIF_CLK_LPDDR3PHY_WRAP1, "clk_lpddr3phy_wrap1", "dout_clk2x_phy",
@@ -1221,7 +1221,7 @@ PNAME(mout_sclk_i2scod_p) = {"ioclk_i2s_cdclk", "fin_pll", "dout_aclk_peri_aud",
 PNAME(mout_sclk_spdif_p) = {"ioclk_spdif_extclk", "fin_pll",
 			"dout_aclk_peri_aud", "phyclk_hdmi_phy_ref_cko"};
 
-struct samsung_mux_clock peri_mux_clks[] __initdata = {
+static struct samsung_mux_clock peri_mux_clks[] __initdata = {
 	MUX(PERI_MOUT_SCLK_PCM, "mout_sclk_pcm", mout_sclk_pcm_p,
 			MUX_SEL_PERI1, 4, 2),
 	MUX(PERI_MOUT_SCLK_I2SCOD, "mout_sclk_i2scod", mout_sclk_i2scod_p,
@@ -1230,12 +1230,12 @@ struct samsung_mux_clock peri_mux_clks[] __initdata = {
 			MUX_SEL_PERI1, 20, 2),
 };
 
-struct samsung_div_clock peri_div_clks[] __initdata = {
+static struct samsung_div_clock peri_div_clks[] __initdata = {
 	DIV(PERI_DOUT_PCM, "dout_pcm", "mout_sclk_pcm", DIV_PERI, 0, 8),
 	DIV(PERI_DOUT_I2S, "dout_i2s", "mout_sclk_i2scod", DIV_PERI, 8, 6),
 };
 
-struct samsung_gate_clock peri_gate_clks[] __initdata = {
+static struct samsung_gate_clock peri_gate_clks[] __initdata = {
 	GATE(PERI_SCLK_PCM1, "sclk_pcm1", "dout_pcm", EN_SCLK_PERI, 0,
 			CLK_SET_RATE_PARENT, 0),
 	GATE(PERI_SCLK_I2S, "sclk_i2s", "dout_i2s", EN_SCLK_PERI, 1,
@@ -1432,7 +1432,7 @@ static unsigned long top_clk_regs[] __initdata = {
 };
 
 /* fixed rate clocks generated inside the soc */
-struct samsung_fixed_rate_clock fixed_rate_clks[] __initdata = {
+static struct samsung_fixed_rate_clock fixed_rate_clks[] __initdata = {
 	FRATE(PHYCLK_DPTX_PHY_CH3_TXD_CLK, "phyclk_dptx_phy_ch3_txd_clk", NULL,
 			CLK_IS_ROOT, 270000000),
 	FRATE(PHYCLK_DPTX_PHY_CH2_TXD_CLK, "phyclk_dptx_phy_ch2_txd_clk", NULL,
@@ -1519,7 +1519,7 @@ PNAME(mout_sclk_fsys_mmc1_sdclkin_b_p) = {"mout_sclk_fsys_mmc1_sdclkin_a",
 PNAME(mout_sclk_fsys_mmc2_sdclkin_b_p) = {"mout_sclk_fsys_mmc2_sdclkin_a",
 			"mout_mediatop_pll_user"};
 
-struct samsung_mux_clock top_mux_clks[] __initdata = {
+static struct samsung_mux_clock top_mux_clks[] __initdata = {
 	MUX(TOP_MOUT_MEDIATOP_PLL_USER, "mout_mediatop_pll_user",
 			mout_mediatop_pll_user_p,
 			MUX_SEL_TOP_PLL0, 0, 1),
@@ -1679,7 +1679,7 @@ struct samsung_mux_clock top_mux_clks[] __initdata = {
 			MUX_SEL_TOP_GSCL, 20, 1),
 };
 
-struct samsung_div_clock top_div_clks[] __initdata = {
+static struct samsung_div_clock top_div_clks[] __initdata = {
 	DIV(TOP_DOUT_ACLK_G2D_333, "dout_aclk_g2d_333", "mout_aclk_g2d_333",
 			DIV_TOP_G2D_MFC, 0, 3),
 	DIV(TOP_DOUT_ACLK_MFC_333, "dout_aclk_mfc_333", "mout_aclk_mfc_333",
@@ -1800,7 +1800,7 @@ struct samsung_div_clock top_div_clks[] __initdata = {
 
 };
 
-struct samsung_gate_clock top_gate_clks[] __initdata = {
+static struct samsung_gate_clock top_gate_clks[] __initdata = {
 	GATE(TOP_SCLK_MMC0, "sclk_fsys_mmc0_sdclkin",
 			"dout_sclk_fsys_mmc0_sdclkin_b",
 			EN_SCLK_TOP, 7, CLK_SET_RATE_PARENT, 0),
diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 07d666cc6a29..af9979001b95 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -503,7 +503,7 @@ static struct samsung_fixed_factor_clock
 	FFACTOR(0, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
 };
 
-struct samsung_mux_clock exynos5800_mux_clks[] __initdata = {
+static struct samsung_mux_clock exynos5800_mux_clks[] __initdata = {
 	MUX(0, "mout_aclk400_isp", mout_group3_5800_p, SRC_TOP0, 0, 3),
 	MUX(0, "mout_aclk400_mscl", mout_group3_5800_p, SRC_TOP0, 4, 3),
 	MUX(0, "mout_aclk400_wcore", mout_group2_5800_p, SRC_TOP0, 16, 3),
@@ -552,7 +552,7 @@ struct samsung_mux_clock exynos5800_mux_clks[] __initdata = {
 	MUX(0, "mout_fimd1", mout_group2_p, SRC_DISP10, 4, 3),
 };
 
-struct samsung_div_clock exynos5800_div_clks[] __initdata = {
+static struct samsung_div_clock exynos5800_div_clks[] __initdata = {
 	DIV(0, "dout_aclk400_wcore", "mout_aclk400_wcore", DIV_TOP0, 16, 3),
 
 	DIV(0, "dout_aclk550_cam", "mout_aclk550_cam",
@@ -568,14 +568,14 @@ struct samsung_div_clock exynos5800_div_clks[] __initdata = {
 	DIV(0, "dout_sclk_sw", "sclk_spll", DIV_TOP9, 24, 6),
 };
 
-struct samsung_gate_clock exynos5800_gate_clks[] __initdata = {
+static struct samsung_gate_clock exynos5800_gate_clks[] __initdata = {
 	GATE(CLK_ACLK550_CAM, "aclk550_cam", "mout_user_aclk550_cam",
 				GATE_BUS_TOP, 24, 0, 0),
 	GATE(CLK_ACLK432_SCALER, "aclk432_scaler", "mout_user_aclk432_scaler",
 				GATE_BUS_TOP, 27, 0, 0),
 };
 
-struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
+static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 	MUX(0, "sclk_bpll", mout_bpll_p, TOP_SPARE2, 0, 1),
 	MUX(0, "mout_aclk400_wcore_bpll", mout_aclk400_wcore_bpll_p,
 				TOP_SPARE2, 4, 1),
@@ -605,7 +605,7 @@ struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 	MUX(0, "mout_fimd1", mout_group3_p, SRC_DISP10, 4, 1),
 };
 
-struct samsung_div_clock exynos5420_div_clks[] __initdata = {
+static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
 	DIV(0, "dout_aclk400_wcore", "mout_aclk400_wcore_bpll",
 			DIV_TOP0, 16, 3),
 };
-- 
1.9.1
