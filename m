From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 11 May 2016 14:02:05 +0200
Subject: [PATCH 09/18] clk: samsung: exynos5260: Constify all clock
 initializers
In-Reply-To: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
References: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1462968134-6085-9-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All of initialization data can be made const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos5260.c | 114 +++++++++++++++++------------------
 1 file changed, 57 insertions(+), 57 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5260.c b/drivers/clk/samsung/clk-exynos5260.c
index 7a7ed075a573..a43642c36039 100644
--- a/drivers/clk/samsung/clk-exynos5260.c
+++ b/drivers/clk/samsung/clk-exynos5260.c
@@ -22,7 +22,7 @@
  * Applicable for all 2550 Type PLLS for Exynos5260, listed below
  * DISP_PLL, EGL_PLL, KFC_PLL, MEM_PLL, BUS_PLL, MEDIA_PLL, G3D_PLL.
  */
-static struct samsung_pll_rate_table pll2550_24mhz_tbl[] __initdata = {
+static const struct samsung_pll_rate_table pll2550_24mhz_tbl[] __initconst = {
 	PLL_35XX_RATE(1700000000, 425, 6, 0),
 	PLL_35XX_RATE(1600000000, 200, 3, 0),
 	PLL_35XX_RATE(1500000000, 250, 4, 0),
@@ -55,7 +55,7 @@ static struct samsung_pll_rate_table pll2550_24mhz_tbl[] __initdata = {
 /*
  * Applicable for 2650 Type PLL for AUD_PLL.
  */
-static struct samsung_pll_rate_table pll2650_24mhz_tbl[] __initdata = {
+static const struct samsung_pll_rate_table pll2650_24mhz_tbl[] __initconst = {
 	PLL_36XX_RATE(1600000000, 200, 3, 0, 0),
 	PLL_36XX_RATE(1200000000, 100, 2, 0, 0),
 	PLL_36XX_RATE(1000000000, 250, 3, 1, 0),
@@ -78,7 +78,7 @@ static struct samsung_pll_rate_table pll2650_24mhz_tbl[] __initdata = {
 
 /* CMU_AUD */
 
-static unsigned long aud_clk_regs[] __initdata = {
+static const unsigned long aud_clk_regs[] __initconst = {
 	MUX_SEL_AUD,
 	DIV_AUD0,
 	DIV_AUD1,
@@ -92,7 +92,7 @@ PNAME(mout_aud_pll_user_p) = {"fin_pll", "fout_aud_pll"};
 PNAME(mout_sclk_aud_i2s_p) = {"mout_aud_pll_user", "ioclk_i2s_cdclk"};
 PNAME(mout_sclk_aud_pcm_p) = {"mout_aud_pll_user", "ioclk_pcm_extclk"};
 
-static struct samsung_mux_clock aud_mux_clks[] __initdata = {
+static const struct samsung_mux_clock aud_mux_clks[] __initconst = {
 	MUX(AUD_MOUT_AUD_PLL_USER, "mout_aud_pll_user", mout_aud_pll_user_p,
 			MUX_SEL_AUD, 0, 1),
 	MUX(AUD_MOUT_SCLK_AUD_I2S, "mout_sclk_aud_i2s", mout_sclk_aud_i2s_p,
@@ -101,7 +101,7 @@ static struct samsung_mux_clock aud_mux_clks[] __initdata = {
 			MUX_SEL_AUD, 8, 1),
 };
 
-static struct samsung_div_clock aud_div_clks[] __initdata = {
+static const struct samsung_div_clock aud_div_clks[] __initconst = {
 	DIV(AUD_DOUT_ACLK_AUD_131, "dout_aclk_aud_131", "mout_aud_pll_user",
 			DIV_AUD0, 0, 4),
 
@@ -113,7 +113,7 @@ static struct samsung_div_clock aud_div_clks[] __initdata = {
 			DIV_AUD1, 12, 4),
 };
 
-static struct samsung_gate_clock aud_gate_clks[] __initdata = {
+static const struct samsung_gate_clock aud_gate_clks[] __initconst = {
 	GATE(AUD_SCLK_I2S, "sclk_aud_i2s", "dout_sclk_aud_i2s",
 			EN_SCLK_AUD, 0, CLK_SET_RATE_PARENT, 0),
 	GATE(AUD_SCLK_PCM, "sclk_aud_pcm", "dout_sclk_aud_pcm",
@@ -154,7 +154,7 @@ CLK_OF_DECLARE(exynos5260_clk_aud, "samsung,exynos5260-clock-aud",
 
 /* CMU_DISP */
 
-static unsigned long disp_clk_regs[] __initdata = {
+static const unsigned long disp_clk_regs[] __initconst = {
 	MUX_SEL_DISP0,
 	MUX_SEL_DISP1,
 	MUX_SEL_DISP2,
@@ -201,7 +201,7 @@ PNAME(mout_phyclk_mipi_dphy_4lmrxclk_esc0_user_p) = {"fin_pll",
 PNAME(mout_sclk_hdmi_spdif_p) = {"fin_pll", "ioclk_spdif_extclk",
 			"dout_aclk_peri_aud", "phyclk_hdmi_phy_ref_cko"};
 
-static struct samsung_mux_clock disp_mux_clks[] __initdata = {
+static const struct samsung_mux_clock disp_mux_clks[] __initconst = {
 	MUX(DISP_MOUT_ACLK_DISP_333_USER, "mout_aclk_disp_333_user",
 			mout_aclk_disp_333_user_p,
 			MUX_SEL_DISP0, 0, 1),
@@ -270,7 +270,7 @@ static struct samsung_mux_clock disp_mux_clks[] __initdata = {
 			MUX_SEL_DISP4, 4, 2),
 };
 
-static struct samsung_div_clock disp_div_clks[] __initdata = {
+static const struct samsung_div_clock disp_div_clks[] __initconst = {
 	DIV(DISP_DOUT_PCLK_DISP_111, "dout_pclk_disp_111",
 			"mout_aclk_disp_222_user",
 			DIV_DISP, 8, 4),
@@ -283,7 +283,7 @@ static struct samsung_div_clock disp_div_clks[] __initdata = {
 			DIV_DISP, 16, 4),
 };
 
-static struct samsung_gate_clock disp_gate_clks[] __initdata = {
+static const struct samsung_gate_clock disp_gate_clks[] __initconst = {
 	GATE(DISP_MOUT_HDMI_PHY_PIXEL_USER, "sclk_hdmi_link_i_pixel",
 			"mout_phyclk_hdmi_phy_pixel_clko_user",
 			EN_SCLK_DISP0, 26, CLK_SET_RATE_PARENT, 0),
@@ -344,7 +344,7 @@ CLK_OF_DECLARE(exynos5260_clk_disp, "samsung,exynos5260-clock-disp",
 
 /* CMU_EGL */
 
-static unsigned long egl_clk_regs[] __initdata = {
+static const unsigned long egl_clk_regs[] __initconst = {
 	EGL_PLL_LOCK,
 	EGL_PLL_CON0,
 	EGL_PLL_CON1,
@@ -361,13 +361,13 @@ static unsigned long egl_clk_regs[] __initdata = {
 PNAME(mout_egl_b_p) = {"mout_egl_pll", "dout_bus_pll"};
 PNAME(mout_egl_pll_p) = {"fin_pll", "fout_egl_pll"};
 
-static struct samsung_mux_clock egl_mux_clks[] __initdata = {
+static const struct samsung_mux_clock egl_mux_clks[] __initconst = {
 	MUX(EGL_MOUT_EGL_PLL, "mout_egl_pll", mout_egl_pll_p,
 			MUX_SEL_EGL, 4, 1),
 	MUX(EGL_MOUT_EGL_B, "mout_egl_b", mout_egl_b_p, MUX_SEL_EGL, 16, 1),
 };
 
-static struct samsung_div_clock egl_div_clks[] __initdata = {
+static const struct samsung_div_clock egl_div_clks[] __initconst = {
 	DIV(EGL_DOUT_EGL1, "dout_egl1", "mout_egl_b", DIV_EGL, 0, 3),
 	DIV(EGL_DOUT_EGL2, "dout_egl2", "dout_egl1", DIV_EGL, 4, 3),
 	DIV(EGL_DOUT_ACLK_EGL, "dout_aclk_egl", "dout_egl2", DIV_EGL, 8, 3),
@@ -379,7 +379,7 @@ static struct samsung_div_clock egl_div_clks[] __initdata = {
 	DIV(EGL_DOUT_EGL_PLL, "dout_egl_pll", "mout_egl_b", DIV_EGL, 24, 3),
 };
 
-static struct samsung_pll_clock egl_pll_clks[] __initdata = {
+static const struct samsung_pll_clock egl_pll_clks[] __initconst = {
 	PLL(pll_2550xx, EGL_FOUT_EGL_PLL, "fout_egl_pll", "fin_pll",
 		EGL_PLL_LOCK, EGL_PLL_CON0,
 		pll2550_24mhz_tbl),
@@ -408,7 +408,7 @@ CLK_OF_DECLARE(exynos5260_clk_egl, "samsung,exynos5260-clock-egl",
 
 /* CMU_FSYS */
 
-static unsigned long fsys_clk_regs[] __initdata = {
+static const unsigned long fsys_clk_regs[] __initconst = {
 	MUX_SEL_FSYS0,
 	MUX_SEL_FSYS1,
 	EN_ACLK_FSYS,
@@ -431,7 +431,7 @@ PNAME(mout_phyclk_usbdrd30_pipe_pclk_user_p) = {"fin_pll",
 PNAME(mout_phyclk_usbdrd30_phyclock_user_p) = {"fin_pll",
 			"phyclk_usbdrd30_udrd30_phyclock"};
 
-static struct samsung_mux_clock fsys_mux_clks[] __initdata = {
+static const struct samsung_mux_clock fsys_mux_clks[] __initconst = {
 	MUX(FSYS_MOUT_PHYCLK_USBDRD30_PHYCLOCK_USER,
 			"mout_phyclk_usbdrd30_phyclock_user",
 			mout_phyclk_usbdrd30_phyclock_user_p,
@@ -454,7 +454,7 @@ static struct samsung_mux_clock fsys_mux_clks[] __initdata = {
 			MUX_SEL_FSYS1, 16, 1),
 };
 
-static struct samsung_gate_clock fsys_gate_clks[] __initdata = {
+static const struct samsung_gate_clock fsys_gate_clks[] __initconst = {
 	GATE(FSYS_PHYCLK_USBHOST20, "phyclk_usbhost20_phyclock",
 			"mout_phyclk_usbdrd30_phyclock_user",
 			EN_SCLK_FSYS, 1, 0, 0),
@@ -508,7 +508,7 @@ CLK_OF_DECLARE(exynos5260_clk_fsys, "samsung,exynos5260-clock-fsys",
 
 /* CMU_G2D */
 
-static unsigned long g2d_clk_regs[] __initdata = {
+static const unsigned long g2d_clk_regs[] __initconst = {
 	MUX_SEL_G2D,
 	MUX_STAT_G2D,
 	DIV_G2D,
@@ -535,18 +535,18 @@ static unsigned long g2d_clk_regs[] __initdata = {
 
 PNAME(mout_aclk_g2d_333_user_p) = {"fin_pll", "dout_aclk_g2d_333"};
 
-static struct samsung_mux_clock g2d_mux_clks[] __initdata = {
+static const struct samsung_mux_clock g2d_mux_clks[] __initconst = {
 	MUX(G2D_MOUT_ACLK_G2D_333_USER, "mout_aclk_g2d_333_user",
 			mout_aclk_g2d_333_user_p,
 			MUX_SEL_G2D, 0, 1),
 };
 
-static struct samsung_div_clock g2d_div_clks[] __initdata = {
+static const struct samsung_div_clock g2d_div_clks[] __initconst = {
 	DIV(G2D_DOUT_PCLK_G2D_83, "dout_pclk_g2d_83", "mout_aclk_g2d_333_user",
 			DIV_G2D, 0, 3),
 };
 
-static struct samsung_gate_clock g2d_gate_clks[] __initdata = {
+static const struct samsung_gate_clock g2d_gate_clks[] __initconst = {
 	GATE(G2D_CLK_G2D, "clk_g2d", "mout_aclk_g2d_333_user",
 			EN_IP_G2D, 4, 0, 0),
 	GATE(G2D_CLK_JPEG, "clk_jpeg", "mout_aclk_g2d_333_user",
@@ -599,7 +599,7 @@ CLK_OF_DECLARE(exynos5260_clk_g2d, "samsung,exynos5260-clock-g2d",
 
 /* CMU_G3D */
 
-static unsigned long g3d_clk_regs[] __initdata = {
+static const unsigned long g3d_clk_regs[] __initconst = {
 	G3D_PLL_LOCK,
 	G3D_PLL_CON0,
 	G3D_PLL_CON1,
@@ -615,23 +615,23 @@ static unsigned long g3d_clk_regs[] __initdata = {
 
 PNAME(mout_g3d_pll_p) = {"fin_pll", "fout_g3d_pll"};
 
-static struct samsung_mux_clock g3d_mux_clks[] __initdata = {
+static const struct samsung_mux_clock g3d_mux_clks[] __initconst = {
 	MUX(G3D_MOUT_G3D_PLL, "mout_g3d_pll", mout_g3d_pll_p,
 			MUX_SEL_G3D, 0, 1),
 };
 
-static struct samsung_div_clock g3d_div_clks[] __initdata = {
+static const struct samsung_div_clock g3d_div_clks[] __initconst = {
 	DIV(G3D_DOUT_PCLK_G3D, "dout_pclk_g3d", "dout_aclk_g3d", DIV_G3D, 0, 3),
 	DIV(G3D_DOUT_ACLK_G3D, "dout_aclk_g3d", "mout_g3d_pll", DIV_G3D, 4, 3),
 };
 
-static struct samsung_gate_clock g3d_gate_clks[] __initdata = {
+static const struct samsung_gate_clock g3d_gate_clks[] __initconst = {
 	GATE(G3D_CLK_G3D, "clk_g3d", "dout_aclk_g3d", EN_IP_G3D, 2, 0, 0),
 	GATE(G3D_CLK_G3D_HPM, "clk_g3d_hpm", "dout_aclk_g3d",
 			EN_IP_G3D, 3, 0, 0),
 };
 
-static struct samsung_pll_clock g3d_pll_clks[] __initdata = {
+static const struct samsung_pll_clock g3d_pll_clks[] __initconst = {
 	PLL(pll_2550, G3D_FOUT_G3D_PLL, "fout_g3d_pll", "fin_pll",
 		G3D_PLL_LOCK, G3D_PLL_CON0,
 		pll2550_24mhz_tbl),
@@ -662,7 +662,7 @@ CLK_OF_DECLARE(exynos5260_clk_g3d, "samsung,exynos5260-clock-g3d",
 
 /* CMU_GSCL */
 
-static unsigned long gscl_clk_regs[] __initdata = {
+static const unsigned long gscl_clk_regs[] __initconst = {
 	MUX_SEL_GSCL,
 	DIV_GSCL,
 	EN_ACLK_GSCL,
@@ -692,7 +692,7 @@ PNAME(mout_aclk_m2m_400_user_p) = {"fin_pll", "dout_aclk_gscl_400"};
 PNAME(mout_aclk_gscl_fimc_user_p) = {"fin_pll", "dout_aclk_gscl_400"};
 PNAME(mout_aclk_csis_p) = {"dout_aclk_csis_200", "mout_aclk_gscl_fimc_user"};
 
-static struct samsung_mux_clock gscl_mux_clks[] __initdata = {
+static const struct samsung_mux_clock gscl_mux_clks[] __initconst = {
 	MUX(GSCL_MOUT_ACLK_GSCL_333_USER, "mout_aclk_gscl_333_user",
 			mout_aclk_gscl_333_user_p,
 			MUX_SEL_GSCL, 0, 1),
@@ -706,7 +706,7 @@ static struct samsung_mux_clock gscl_mux_clks[] __initdata = {
 			MUX_SEL_GSCL, 24, 1),
 };
 
-static struct samsung_div_clock gscl_div_clks[] __initdata = {
+static const struct samsung_div_clock gscl_div_clks[] __initconst = {
 	DIV(GSCL_DOUT_PCLK_M2M_100, "dout_pclk_m2m_100",
 			"mout_aclk_m2m_400_user",
 			DIV_GSCL, 0, 3),
@@ -715,7 +715,7 @@ static struct samsung_div_clock gscl_div_clks[] __initdata = {
 			DIV_GSCL, 4, 3),
 };
 
-static struct samsung_gate_clock gscl_gate_clks[] __initdata = {
+static const struct samsung_gate_clock gscl_gate_clks[] __initconst = {
 	GATE(GSCL_SCLK_CSIS0_WRAP, "sclk_csis0_wrap", "dout_aclk_csis_200",
 			EN_SCLK_GSCL_FIMC, 0, CLK_SET_RATE_PARENT, 0),
 	GATE(GSCL_SCLK_CSIS1_WRAP, "sclk_csis1_wrap", "dout_aclk_csis_200",
@@ -795,7 +795,7 @@ CLK_OF_DECLARE(exynos5260_clk_gscl, "samsung,exynos5260-clock-gscl",
 
 /* CMU_ISP */
 
-static unsigned long isp_clk_regs[] __initdata = {
+static const unsigned long isp_clk_regs[] __initconst = {
 	MUX_SEL_ISP0,
 	MUX_SEL_ISP1,
 	DIV_ISP,
@@ -811,14 +811,14 @@ static unsigned long isp_clk_regs[] __initdata = {
 PNAME(mout_isp_400_user_p) = {"fin_pll", "dout_aclk_isp1_400"};
 PNAME(mout_isp_266_user_p)	 = {"fin_pll", "dout_aclk_isp1_266"};
 
-static struct samsung_mux_clock isp_mux_clks[] __initdata = {
+static const struct samsung_mux_clock isp_mux_clks[] __initconst = {
 	MUX(ISP_MOUT_ISP_266_USER, "mout_isp_266_user", mout_isp_266_user_p,
 			MUX_SEL_ISP0, 0, 1),
 	MUX(ISP_MOUT_ISP_400_USER, "mout_isp_400_user", mout_isp_400_user_p,
 			MUX_SEL_ISP0, 4, 1),
 };
 
-static struct samsung_div_clock isp_div_clks[] __initdata = {
+static const struct samsung_div_clock isp_div_clks[] __initconst = {
 	DIV(ISP_DOUT_PCLK_ISP_66, "dout_pclk_isp_66", "mout_kfc",
 			DIV_ISP, 0, 3),
 	DIV(ISP_DOUT_PCLK_ISP_133, "dout_pclk_isp_133", "mout_kfc",
@@ -830,7 +830,7 @@ static struct samsung_div_clock isp_div_clks[] __initdata = {
 	DIV(ISP_DOUT_SCLK_MPWM, "dout_sclk_mpwm", "mout_kfc", DIV_ISP, 20, 2),
 };
 
-static struct samsung_gate_clock isp_gate_clks[] __initdata = {
+static const struct samsung_gate_clock isp_gate_clks[] __initconst = {
 	GATE(ISP_CLK_GIC, "clk_isp_gic", "mout_aclk_isp1_266",
 			EN_IP_ISP0, 15, 0, 0),
 
@@ -914,7 +914,7 @@ CLK_OF_DECLARE(exynos5260_clk_isp, "samsung,exynos5260-clock-isp",
 
 /* CMU_KFC */
 
-static unsigned long kfc_clk_regs[] __initdata = {
+static const unsigned long kfc_clk_regs[] __initconst = {
 	KFC_PLL_LOCK,
 	KFC_PLL_CON0,
 	KFC_PLL_CON1,
@@ -932,13 +932,13 @@ static unsigned long kfc_clk_regs[] __initdata = {
 PNAME(mout_kfc_pll_p) = {"fin_pll", "fout_kfc_pll"};
 PNAME(mout_kfc_p)	 = {"mout_kfc_pll", "dout_media_pll"};
 
-static struct samsung_mux_clock kfc_mux_clks[] __initdata = {
+static const struct samsung_mux_clock kfc_mux_clks[] __initconst = {
 	MUX(KFC_MOUT_KFC_PLL, "mout_kfc_pll", mout_kfc_pll_p,
 			MUX_SEL_KFC0, 0, 1),
 	MUX(KFC_MOUT_KFC, "mout_kfc", mout_kfc_p, MUX_SEL_KFC2, 0, 1),
 };
 
-static struct samsung_div_clock kfc_div_clks[] __initdata = {
+static const struct samsung_div_clock kfc_div_clks[] __initconst = {
 	DIV(KFC_DOUT_KFC1, "dout_kfc1", "mout_kfc", DIV_KFC, 0, 3),
 	DIV(KFC_DOUT_KFC2, "dout_kfc2", "dout_kfc1", DIV_KFC, 4, 3),
 	DIV(KFC_DOUT_KFC_ATCLK, "dout_kfc_atclk", "dout_kfc2", DIV_KFC, 8, 3),
@@ -949,7 +949,7 @@ static struct samsung_div_clock kfc_div_clks[] __initdata = {
 	DIV(KFC_DOUT_KFC_PLL, "dout_kfc_pll", "mout_kfc", DIV_KFC, 24, 3),
 };
 
-static struct samsung_pll_clock kfc_pll_clks[] __initdata = {
+static const struct samsung_pll_clock kfc_pll_clks[] __initconst = {
 	PLL(pll_2550xx, KFC_FOUT_KFC_PLL, "fout_kfc_pll", "fin_pll",
 		KFC_PLL_LOCK, KFC_PLL_CON0,
 		pll2550_24mhz_tbl),
@@ -978,7 +978,7 @@ CLK_OF_DECLARE(exynos5260_clk_kfc, "samsung,exynos5260-clock-kfc",
 
 /* CMU_MFC */
 
-static unsigned long mfc_clk_regs[] __initdata = {
+static const unsigned long mfc_clk_regs[] __initconst = {
 	MUX_SEL_MFC,
 	DIV_MFC,
 	EN_ACLK_MFC,
@@ -991,18 +991,18 @@ static unsigned long mfc_clk_regs[] __initdata = {
 
 PNAME(mout_aclk_mfc_333_user_p) = {"fin_pll", "dout_aclk_mfc_333"};
 
-static struct samsung_mux_clock mfc_mux_clks[] __initdata = {
+static const struct samsung_mux_clock mfc_mux_clks[] __initconst = {
 	MUX(MFC_MOUT_ACLK_MFC_333_USER, "mout_aclk_mfc_333_user",
 			mout_aclk_mfc_333_user_p,
 			MUX_SEL_MFC, 0, 1),
 };
 
-static struct samsung_div_clock mfc_div_clks[] __initdata = {
+static const struct samsung_div_clock mfc_div_clks[] __initconst = {
 	DIV(MFC_DOUT_PCLK_MFC_83, "dout_pclk_mfc_83", "mout_aclk_mfc_333_user",
 			DIV_MFC, 0, 3),
 };
 
-static struct samsung_gate_clock mfc_gate_clks[] __initdata = {
+static const struct samsung_gate_clock mfc_gate_clks[] __initconst = {
 	GATE(MFC_CLK_MFC, "clk_mfc", "mout_aclk_mfc_333_user",
 			EN_IP_MFC, 1, 0, 0),
 	GATE(MFC_CLK_SMMU2_MFCM0, "clk_smmu2_mfcm0", "mout_aclk_mfc_333_user",
@@ -1034,7 +1034,7 @@ CLK_OF_DECLARE(exynos5260_clk_mfc, "samsung,exynos5260-clock-mfc",
 
 /* CMU_MIF */
 
-static unsigned long mif_clk_regs[] __initdata = {
+static const unsigned long mif_clk_regs[] __initconst = {
 	MEM_PLL_LOCK,
 	BUS_PLL_LOCK,
 	MEDIA_PLL_LOCK,
@@ -1076,7 +1076,7 @@ PNAME(mout_mif_drex2x_p) = {"dout_mem_pll", "dout_bus_pll"};
 PNAME(mout_clkm_phy_p) = {"mout_mif_drex", "dout_media_pll"};
 PNAME(mout_clk2x_phy_p) = {"mout_mif_drex2x", "dout_media_pll"};
 
-static struct samsung_mux_clock mif_mux_clks[] __initdata = {
+static const struct samsung_mux_clock mif_mux_clks[] __initconst = {
 	MUX(MIF_MOUT_MEM_PLL, "mout_mem_pll", mout_mem_pll_p,
 			MUX_SEL_MIF, 0, 1),
 	MUX(MIF_MOUT_BUS_PLL, "mout_bus_pll", mout_bus_pll_p,
@@ -1093,7 +1093,7 @@ static struct samsung_mux_clock mif_mux_clks[] __initdata = {
 			MUX_SEL_MIF, 24, 1),
 };
 
-static struct samsung_div_clock mif_div_clks[] __initdata = {
+static const struct samsung_div_clock mif_div_clks[] __initconst = {
 	DIV(MIF_DOUT_MEDIA_PLL, "dout_media_pll", "mout_media_pll",
 			DIV_MIF, 0, 3),
 	DIV(MIF_DOUT_MEM_PLL, "dout_mem_pll", "mout_mem_pll",
@@ -1112,7 +1112,7 @@ static struct samsung_div_clock mif_div_clks[] __initdata = {
 			DIV_MIF, 28, 4),
 };
 
-static struct samsung_gate_clock mif_gate_clks[] __initdata = {
+static const struct samsung_gate_clock mif_gate_clks[] __initconst = {
 	GATE(MIF_CLK_LPDDR3PHY_WRAP0, "clk_lpddr3phy_wrap0", "dout_clk2x_phy",
 			EN_IP_MIF, 12, CLK_IGNORE_UNUSED, 0),
 	GATE(MIF_CLK_LPDDR3PHY_WRAP1, "clk_lpddr3phy_wrap1", "dout_clk2x_phy",
@@ -1146,7 +1146,7 @@ static struct samsung_gate_clock mif_gate_clks[] __initdata = {
 			CLK_IGNORE_UNUSED | CLK_SET_RATE_PARENT, 0),
 };
 
-static struct samsung_pll_clock mif_pll_clks[] __initdata = {
+static const struct samsung_pll_clock mif_pll_clks[] __initconst = {
 	PLL(pll_2550xx, MIF_FOUT_MEM_PLL, "fout_mem_pll", "fin_pll",
 		MEM_PLL_LOCK, MEM_PLL_CON0,
 		pll2550_24mhz_tbl),
@@ -1183,7 +1183,7 @@ CLK_OF_DECLARE(exynos5260_clk_mif, "samsung,exynos5260-clock-mif",
 
 /* CMU_PERI */
 
-static unsigned long peri_clk_regs[] __initdata = {
+static const unsigned long peri_clk_regs[] __initconst = {
 	MUX_SEL_PERI,
 	MUX_SEL_PERI1,
 	DIV_PERI,
@@ -1219,7 +1219,7 @@ PNAME(mout_sclk_i2scod_p) = {"ioclk_i2s_cdclk", "fin_pll", "dout_aclk_peri_aud",
 PNAME(mout_sclk_spdif_p) = {"ioclk_spdif_extclk", "fin_pll",
 			"dout_aclk_peri_aud", "phyclk_hdmi_phy_ref_cko"};
 
-static struct samsung_mux_clock peri_mux_clks[] __initdata = {
+static const struct samsung_mux_clock peri_mux_clks[] __initconst = {
 	MUX(PERI_MOUT_SCLK_PCM, "mout_sclk_pcm", mout_sclk_pcm_p,
 			MUX_SEL_PERI1, 4, 2),
 	MUX(PERI_MOUT_SCLK_I2SCOD, "mout_sclk_i2scod", mout_sclk_i2scod_p,
@@ -1228,12 +1228,12 @@ static struct samsung_mux_clock peri_mux_clks[] __initdata = {
 			MUX_SEL_PERI1, 20, 2),
 };
 
-static struct samsung_div_clock peri_div_clks[] __initdata = {
+static const struct samsung_div_clock peri_div_clks[] __initconst = {
 	DIV(PERI_DOUT_PCM, "dout_pcm", "mout_sclk_pcm", DIV_PERI, 0, 8),
 	DIV(PERI_DOUT_I2S, "dout_i2s", "mout_sclk_i2scod", DIV_PERI, 8, 6),
 };
 
-static struct samsung_gate_clock peri_gate_clks[] __initdata = {
+static const struct samsung_gate_clock peri_gate_clks[] __initconst = {
 	GATE(PERI_SCLK_PCM1, "sclk_pcm1", "dout_pcm", EN_SCLK_PERI, 0,
 			CLK_SET_RATE_PARENT, 0),
 	GATE(PERI_SCLK_I2S, "sclk_i2s", "dout_i2s", EN_SCLK_PERI, 1,
@@ -1389,7 +1389,7 @@ CLK_OF_DECLARE(exynos5260_clk_peri, "samsung,exynos5260-clock-peri",
 
 /* CMU_TOP */
 
-static unsigned long top_clk_regs[] __initdata = {
+static const unsigned long top_clk_regs[] __initconst = {
 	DISP_PLL_LOCK,
 	AUD_PLL_LOCK,
 	DISP_PLL_CON0,
@@ -1430,7 +1430,7 @@ static unsigned long top_clk_regs[] __initdata = {
 };
 
 /* fixed rate clocks generated inside the soc */
-static struct samsung_fixed_rate_clock fixed_rate_clks[] __initdata = {
+static const struct samsung_fixed_rate_clock fixed_rate_clks[] __initconst = {
 	FRATE(PHYCLK_DPTX_PHY_CH3_TXD_CLK, "phyclk_dptx_phy_ch3_txd_clk", NULL,
 			0, 270000000),
 	FRATE(PHYCLK_DPTX_PHY_CH2_TXD_CLK, "phyclk_dptx_phy_ch2_txd_clk", NULL,
@@ -1513,7 +1513,7 @@ PNAME(mout_sclk_fsys_mmc1_sdclkin_b_p) = {"mout_sclk_fsys_mmc1_sdclkin_a",
 PNAME(mout_sclk_fsys_mmc2_sdclkin_b_p) = {"mout_sclk_fsys_mmc2_sdclkin_a",
 			"mout_mediatop_pll_user"};
 
-static struct samsung_mux_clock top_mux_clks[] __initdata = {
+static const struct samsung_mux_clock top_mux_clks[] __initconst = {
 	MUX(TOP_MOUT_MEDIATOP_PLL_USER, "mout_mediatop_pll_user",
 			mout_mediatop_pll_user_p,
 			MUX_SEL_TOP_PLL0, 0, 1),
@@ -1673,7 +1673,7 @@ static struct samsung_mux_clock top_mux_clks[] __initdata = {
 			MUX_SEL_TOP_GSCL, 20, 1),
 };
 
-static struct samsung_div_clock top_div_clks[] __initdata = {
+static const struct samsung_div_clock top_div_clks[] __initconst = {
 	DIV(TOP_DOUT_ACLK_G2D_333, "dout_aclk_g2d_333", "mout_aclk_g2d_333",
 			DIV_TOP_G2D_MFC, 0, 3),
 	DIV(TOP_DOUT_ACLK_MFC_333, "dout_aclk_mfc_333", "mout_aclk_mfc_333",
@@ -1794,7 +1794,7 @@ static struct samsung_div_clock top_div_clks[] __initdata = {
 
 };
 
-static struct samsung_gate_clock top_gate_clks[] __initdata = {
+static const struct samsung_gate_clock top_gate_clks[] __initconst = {
 	GATE(TOP_SCLK_MMC0, "sclk_fsys_mmc0_sdclkin",
 			"dout_sclk_fsys_mmc0_sdclkin_b",
 			EN_SCLK_TOP, 7, CLK_SET_RATE_PARENT, 0),
@@ -1809,7 +1809,7 @@ static struct samsung_gate_clock top_gate_clks[] __initdata = {
 			CLK_SET_RATE_PARENT, 0),
 };
 
-static struct samsung_pll_clock top_pll_clks[] __initdata = {
+static const struct samsung_pll_clock top_pll_clks[] __initconst = {
 	PLL(pll_2550xx, TOP_FOUT_DISP_PLL, "fout_disp_pll", "fin_pll",
 		DISP_PLL_LOCK, DISP_PLL_CON0,
 		pll2550_24mhz_tbl),
-- 
1.9.1
