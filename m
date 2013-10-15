From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 15 Oct 2013 19:41:16 +0200
Subject: [PATCH 2/7] clk: samsung: exynos5250: Make names of mux and div clocks
 consistent
In-Reply-To: <1381858881-25611-1-git-send-email-t.figa@samsung.com>
References: <1381858881-25611-1-git-send-email-t.figa@samsung.com>
Message-ID: <1381858881-25611-3-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch renames all mux clocks to start with mout_ prefix and all div
clocks to start with div_ prefix for consistency with other clocks
already defined this way.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos5250.c | 241 ++++++++++++++++++-----------------
 1 file changed, 121 insertions(+), 120 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 32ee031..ce33a3f 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -181,7 +181,7 @@ static unsigned long exynos5250_clk_regs[] __initdata = {
 
 /* list of all parent clock list */
 PNAME(mout_apll_p)	= { "fin_pll", "fout_apll", };
-PNAME(mout_cpu_p)	= { "mout_apll", "sclk_mpll", };
+PNAME(mout_cpu_p)	= { "mout_apll", "mout_mpll", };
 PNAME(mout_mpll_fout_p)	= { "fout_mplldiv2", "fout_mpll" };
 PNAME(mout_mpll_p)	= { "fin_pll", "mout_mpll_fout" };
 PNAME(mout_bpll_fout_p)	= { "fout_bplldiv2", "fout_bpll" };
@@ -190,28 +190,28 @@ PNAME(mout_vpllsrc_p)	= { "fin_pll", "sclk_hdmi27m" };
 PNAME(mout_vpll_p)	= { "mout_vpllsrc", "fout_vpll" };
 PNAME(mout_cpll_p)	= { "fin_pll", "fout_cpll" };
 PNAME(mout_epll_p)	= { "fin_pll", "fout_epll" };
-PNAME(mout_mpll_user_p)	= { "fin_pll", "sclk_mpll" };
-PNAME(mout_bpll_user_p)	= { "fin_pll", "sclk_bpll" };
-PNAME(mout_aclk166_p)	= { "sclk_cpll", "sclk_mpll_user" };
-PNAME(mout_aclk200_p)	= { "sclk_mpll_user", "sclk_bpll_user" };
+PNAME(mout_mpll_user_p)	= { "fin_pll", "mout_mpll" };
+PNAME(mout_bpll_user_p)	= { "fin_pll", "mout_bpll" };
+PNAME(mout_aclk166_p)	= { "mout_cpll", "mout_mpll_user" };
+PNAME(mout_aclk200_p)	= { "mout_mpll_user", "mout_bpll_user" };
 PNAME(mout_hdmi_p)	= { "div_hdmi_pixel", "sclk_hdmiphy" };
-PNAME(mout_usb3_p)	= { "sclk_mpll_user", "sclk_cpll" };
+PNAME(mout_usb3_p)	= { "mout_mpll_user", "mout_cpll" };
 PNAME(mout_group1_p)	= { "fin_pll", "fin_pll", "sclk_hdmi27m",
 				"sclk_dptxphy", "sclk_uhostphy", "sclk_hdmiphy",
-				"sclk_mpll_user", "sclk_epll", "sclk_vpll",
-				"sclk_cpll" };
+				"mout_mpll_user", "mout_epll", "mout_vpll",
+				"mout_cpll" };
 PNAME(mout_audio0_p)	= { "cdclk0", "fin_pll", "sclk_hdmi27m", "sclk_dptxphy",
 				"sclk_uhostphy", "sclk_hdmiphy",
-				"sclk_mpll_user", "sclk_epll", "sclk_vpll",
-				"sclk_cpll" };
+				"mout_mpll_user", "mout_epll", "mout_vpll",
+				"mout_cpll" };
 PNAME(mout_audio1_p)	= { "cdclk1", "fin_pll", "sclk_hdmi27m", "sclk_dptxphy",
 				"sclk_uhostphy", "sclk_hdmiphy",
-				"sclk_mpll_user", "sclk_epll", "sclk_vpll",
-				"sclk_cpll" };
+				"mout_mpll_user", "mout_epll", "mout_vpll",
+				"mout_cpll" };
 PNAME(mout_audio2_p)	= { "cdclk2", "fin_pll", "sclk_hdmi27m", "sclk_dptxphy",
 				"sclk_uhostphy", "sclk_hdmiphy",
-				"sclk_mpll_user", "sclk_epll", "sclk_vpll",
-				"sclk_cpll" };
+				"mout_mpll_user", "mout_epll", "mout_vpll",
+				"mout_cpll" };
 PNAME(mout_spdif_p)	= { "sclk_audio0", "sclk_audio1", "sclk_audio2",
 				"spdif_extclk" };
 
@@ -254,7 +254,7 @@ static struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
 	/*
 	 * CMU_CORE
 	 */
-	MUX_A(none, "sclk_mpll", mout_mpll_p, SRC_CORE1, 8, 1, "mout_mpll"),
+	MUX_A(none, "mout_mpll", mout_mpll_p, SRC_CORE1, 8, 1, "mout_mpll"),
 
 	/*
 	 * CMU_TOP
@@ -263,11 +263,11 @@ static struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
 	MUX(none, "mout_aclk200", mout_aclk200_p, SRC_TOP0, 12, 1),
 	MUX(none, "mout_aclk333", mout_aclk166_p, SRC_TOP0, 16, 1),
 
-	MUX(none, "sclk_cpll", mout_cpll_p, SRC_TOP2, 8, 1),
-	MUX(none, "sclk_epll", mout_epll_p, SRC_TOP2, 12, 1),
-	MUX(none, "sclk_vpll", mout_vpll_p, SRC_TOP2, 16, 1),
-	MUX(none, "sclk_mpll_user", mout_mpll_user_p, SRC_TOP2, 20, 1),
-	MUX(none, "sclk_bpll_user", mout_bpll_user_p, SRC_TOP2, 24, 1),
+	MUX(none, "mout_cpll", mout_cpll_p, SRC_TOP2, 8, 1),
+	MUX(none, "mout_epll", mout_epll_p, SRC_TOP2, 12, 1),
+	MUX(none, "mout_vpll", mout_vpll_p, SRC_TOP2, 16, 1),
+	MUX(none, "mout_mpll_user", mout_mpll_user_p, SRC_TOP2, 20, 1),
+	MUX(none, "mout_bpll_user", mout_bpll_user_p, SRC_TOP2, 24, 1),
 
 	MUX(none, "mout_cam_bayer", mout_group1_p, SRC_GSCL, 12, 4),
 	MUX(none, "mout_cam0", mout_group1_p, SRC_GSCL, 16, 4),
@@ -307,7 +307,7 @@ static struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
 	/*
 	 * CMU_CDREX
 	 */
-	MUX(none, "sclk_bpll", mout_bpll_p, SRC_CDREX, 0, 1),
+	MUX(none, "mout_bpll", mout_bpll_p, SRC_CDREX, 0, 1),
 
 	MUX(none, "mout_mpll_fout", mout_mpll_fout_p, PLL_DIV2_SEL, 4, 1),
 	MUX(none, "mout_bpll_fout", mout_bpll_fout_p, PLL_DIV2_SEL, 0, 1),
@@ -325,19 +325,19 @@ static struct samsung_div_clock exynos5250_div_clks[] __initdata = {
 	 * CMU_CPU
 	 */
 	DIV(none, "div_arm", "mout_cpu", DIV_CPU0, 0, 3),
-	DIV(none, "sclk_apll", "mout_apll", DIV_CPU0, 24, 3),
-	DIV_A(none, "armclk", "div_arm", DIV_CPU0, 28, 3, "armclk"),
+	DIV(none, "div_apll", "mout_apll", DIV_CPU0, 24, 3),
+	DIV_A(none, "div_arm2", "div_arm", DIV_CPU0, 28, 3, "armclk"),
 
 	/*
 	 * CMU_TOP
 	 */
-	DIV(none, "aclk66", "aclk66_pre", DIV_TOP0, 0, 3),
-	DIV(none, "aclk166", "mout_aclk166", DIV_TOP0, 8, 3),
-	DIV(none, "aclk200", "mout_aclk200", DIV_TOP0, 12, 3),
-	DIV(none, "aclk266", "sclk_mpll_user", DIV_TOP0, 16, 3),
-	DIV(none, "aclk333", "mout_aclk333", DIV_TOP0, 20, 3),
+	DIV(none, "div_aclk66", "div_aclk66_pre", DIV_TOP0, 0, 3),
+	DIV(none, "div_aclk166", "mout_aclk166", DIV_TOP0, 8, 3),
+	DIV(none, "div_aclk200", "mout_aclk200", DIV_TOP0, 12, 3),
+	DIV(none, "div_aclk266", "mout_mpll_user", DIV_TOP0, 16, 3),
+	DIV(none, "div_aclk333", "mout_aclk333", DIV_TOP0, 20, 3),
 
-	DIV(none, "aclk66_pre", "sclk_mpll_user", DIV_TOP1, 24, 3),
+	DIV(none, "div_aclk66_pre", "mout_mpll_user", DIV_TOP1, 24, 3),
 
 	DIV(none, "div_cam_bayer", "mout_cam_bayer", DIV_GSCL, 12, 4),
 	DIV(none, "div_cam0", "mout_cam0", DIV_GSCL, 16, 4),
@@ -350,7 +350,7 @@ static struct samsung_div_clock exynos5250_div_clks[] __initdata = {
 	DIV_F(none, "div_mipi1_pre", "div_mipi1",
 			DIV_DISP1_0, 20, 4, CLK_SET_RATE_PARENT, 0),
 	DIV(none, "div_dp", "mout_dp", DIV_DISP1_0, 24, 4),
-	DIV(sclk_pixel, "div_hdmi_pixel", "sclk_vpll", DIV_DISP1_0, 28, 4),
+	DIV(sclk_pixel, "div_hdmi_pixel", "mout_vpll", DIV_DISP1_0, 28, 4),
 
 	DIV(none, "div_jpeg", "mout_jpeg", DIV_GEN, 4, 4),
 
@@ -412,7 +412,7 @@ static struct samsung_gate_clock exynos5250_gate_clks[] __initdata = {
 	/*
 	 * CMU_ACP
 	 */
-	GATE(g2d, "g2d", "aclk200", GATE_IP_ACP, 3, 0, 0),
+	GATE(g2d, "g2d", "div_aclk200", GATE_IP_ACP, 3, 0, 0),
 
 	/*
 	 * CMU_TOP
@@ -482,102 +482,103 @@ static struct samsung_gate_clock exynos5250_gate_clks[] __initdata = {
 
 	GATE(gscl0, "gscl0", "none", GATE_IP_GSCL, 0, 0, 0),
 	GATE(gscl1, "gscl1", "none", GATE_IP_GSCL, 1, 0, 0),
-	GATE(gscl2, "gscl2", "aclk266", GATE_IP_GSCL, 2, 0, 0),
-	GATE(gscl3, "gscl3", "aclk266", GATE_IP_GSCL, 3, 0, 0),
+	GATE(gscl2, "gscl2", "div_aclk266", GATE_IP_GSCL, 2, 0, 0),
+	GATE(gscl3, "gscl3", "div_aclk266", GATE_IP_GSCL, 3, 0, 0),
 	GATE(gscl_wa, "gscl_wa", "div_gscl_wa", GATE_IP_GSCL, 5, 0, 0),
 	GATE(gscl_wb, "gscl_wb", "div_gscl_wb", GATE_IP_GSCL, 6, 0, 0),
-	GATE(smmu_gscl0, "smmu_gscl0", "aclk266", GATE_IP_GSCL, 7, 0, 0),
-	GATE(smmu_gscl1, "smmu_gscl1", "aclk266", GATE_IP_GSCL, 8, 0, 0),
-	GATE(smmu_gscl2, "smmu_gscl2", "aclk266", GATE_IP_GSCL, 9, 0, 0),
-	GATE(smmu_gscl3, "smmu_gscl3", "aclk266", GATE_IP_GSCL, 10, 0, 0),
-
-	GATE(fimd1, "fimd1", "aclk200", GATE_IP_DISP1, 0, 0, 0),
-	GATE(mie1, "mie1", "aclk200", GATE_IP_DISP1, 1, 0, 0),
-	GATE(dsim0, "dsim0", "aclk200", GATE_IP_DISP1, 3, 0, 0),
-	GATE(dp, "dp", "aclk200", GATE_IP_DISP1, 4, 0, 0),
+	GATE(smmu_gscl0, "smmu_gscl0", "div_aclk266", GATE_IP_GSCL, 7, 0, 0),
+	GATE(smmu_gscl1, "smmu_gscl1", "div_aclk266", GATE_IP_GSCL, 8, 0, 0),
+	GATE(smmu_gscl2, "smmu_gscl2", "div_aclk266", GATE_IP_GSCL, 9, 0, 0),
+	GATE(smmu_gscl3, "smmu_gscl3", "div_aclk266", GATE_IP_GSCL, 10, 0, 0),
+
+	GATE(fimd1, "fimd1", "div_aclk200", GATE_IP_DISP1, 0, 0, 0),
+	GATE(mie1, "mie1", "div_aclk200", GATE_IP_DISP1, 1, 0, 0),
+	GATE(dsim0, "dsim0", "div_aclk200", GATE_IP_DISP1, 3, 0, 0),
+	GATE(dp, "dp", "div_aclk200", GATE_IP_DISP1, 4, 0, 0),
 	GATE(mixer, "mixer", "mout_aclk200_disp1", GATE_IP_DISP1, 5, 0, 0),
 	GATE(hdmi, "hdmi", "mout_aclk200_disp1", GATE_IP_DISP1, 6, 0, 0),
 
-	GATE(mfc, "mfc", "aclk333", GATE_IP_MFC, 0, 0, 0),
-	GATE(smmu_mfcl, "smmu_mfcl", "aclk333", GATE_IP_MFC, 1, 0, 0),
-	GATE(smmu_mfcr, "smmu_mfcr", "aclk333", GATE_IP_MFC, 2, 0, 0),
-
-	GATE(rotator, "rotator", "aclk266", GATE_IP_GEN, 1, 0, 0),
-	GATE(jpeg, "jpeg", "aclk166", GATE_IP_GEN, 2, 0, 0),
-	GATE(mdma1, "mdma1", "aclk266", GATE_IP_GEN, 4, 0, 0),
-	GATE(smmu_rotator, "smmu_rotator", "aclk266", GATE_IP_GEN, 6, 0, 0),
-	GATE(smmu_jpeg, "smmu_jpeg", "aclk166", GATE_IP_GEN, 7, 0, 0),
-	GATE(smmu_mdma1, "smmu_mdma1", "aclk266", GATE_IP_GEN, 9, 0, 0),
-
-	GATE(pdma0, "pdma0", "aclk200", GATE_IP_FSYS, 1, 0, 0),
-	GATE(pdma1, "pdma1", "aclk200", GATE_IP_FSYS, 2, 0, 0),
-	GATE(sata, "sata", "aclk200", GATE_IP_FSYS, 6, 0, 0),
-	GATE(usbotg, "usbotg", "aclk200", GATE_IP_FSYS, 7, 0, 0),
-	GATE(mipi_hsi, "mipi_hsi", "aclk200", GATE_IP_FSYS, 8, 0, 0),
-	GATE(sdmmc0, "sdmmc0", "aclk200", GATE_IP_FSYS, 12, 0, 0),
-	GATE(sdmmc1, "sdmmc1", "aclk200", GATE_IP_FSYS, 13, 0, 0),
-	GATE(sdmmc2, "sdmmc2", "aclk200", GATE_IP_FSYS, 14, 0, 0),
-	GATE(sdmmc3, "sdmmc3", "aclk200", GATE_IP_FSYS, 15, 0, 0),
-	GATE(sromc, "sromc", "aclk200", GATE_IP_FSYS, 17, 0, 0),
-	GATE(usb2, "usb2", "aclk200", GATE_IP_FSYS, 18, 0, 0),
-	GATE(usb3, "usb3", "aclk200", GATE_IP_FSYS, 19, 0, 0),
-	GATE(sata_phyctrl, "sata_phyctrl", "aclk200", GATE_IP_FSYS, 24, 0, 0),
-	GATE(sata_phyi2c, "sata_phyi2c", "aclk200", GATE_IP_FSYS, 25, 0, 0),
-
-	GATE(uart0, "uart0", "aclk66", GATE_IP_PERIC, 0, 0, 0),
-	GATE(uart1, "uart1", "aclk66", GATE_IP_PERIC, 1, 0, 0),
-	GATE(uart2, "uart2", "aclk66", GATE_IP_PERIC, 2, 0, 0),
-	GATE(uart3, "uart3", "aclk66", GATE_IP_PERIC, 3, 0, 0),
-	GATE(uart4, "uart4", "aclk66", GATE_IP_PERIC, 4, 0, 0),
-	GATE(i2c0, "i2c0", "aclk66", GATE_IP_PERIC, 6, 0, 0),
-	GATE(i2c1, "i2c1", "aclk66", GATE_IP_PERIC, 7, 0, 0),
-	GATE(i2c2, "i2c2", "aclk66", GATE_IP_PERIC, 8, 0, 0),
-	GATE(i2c3, "i2c3", "aclk66", GATE_IP_PERIC, 9, 0, 0),
-	GATE(i2c4, "i2c4", "aclk66", GATE_IP_PERIC, 10, 0, 0),
-	GATE(i2c5, "i2c5", "aclk66", GATE_IP_PERIC, 11, 0, 0),
-	GATE(i2c6, "i2c6", "aclk66", GATE_IP_PERIC, 12, 0, 0),
-	GATE(i2c7, "i2c7", "aclk66", GATE_IP_PERIC, 13, 0, 0),
-	GATE(i2c_hdmi, "i2c_hdmi", "aclk66", GATE_IP_PERIC, 14, 0, 0),
-	GATE(adc, "adc", "aclk66", GATE_IP_PERIC, 15, 0, 0),
-	GATE(spi0, "spi0", "aclk66", GATE_IP_PERIC, 16, 0, 0),
-	GATE(spi1, "spi1", "aclk66", GATE_IP_PERIC, 17, 0, 0),
-	GATE(spi2, "spi2", "aclk66", GATE_IP_PERIC, 18, 0, 0),
-	GATE(i2s1, "i2s1", "aclk66", GATE_IP_PERIC, 20, 0, 0),
-	GATE(i2s2, "i2s2", "aclk66", GATE_IP_PERIC, 21, 0, 0),
-	GATE(pcm1, "pcm1", "aclk66", GATE_IP_PERIC, 22, 0, 0),
-	GATE(pcm2, "pcm2", "aclk66", GATE_IP_PERIC, 23, 0, 0),
-	GATE(pwm, "pwm", "aclk66", GATE_IP_PERIC, 24, 0, 0),
-	GATE(spdif, "spdif", "aclk66", GATE_IP_PERIC, 26, 0, 0),
-	GATE(ac97, "ac97", "aclk66", GATE_IP_PERIC, 27, 0, 0),
-	GATE(hsi2c0, "hsi2c0", "aclk66", GATE_IP_PERIC, 28, 0, 0),
-	GATE(hsi2c1, "hsi2c1", "aclk66", GATE_IP_PERIC, 29, 0, 0),
-	GATE(hsi2c2, "hsi2c2", "aclk66", GATE_IP_PERIC, 30, 0, 0),
-	GATE(hsi2c3, "hsi2c3", "aclk66", GATE_IP_PERIC, 31, 0, 0),
-
-	GATE(chipid, "chipid", "aclk66", GATE_IP_PERIS, 0, 0, 0),
-	GATE(sysreg, "sysreg", "aclk66", GATE_IP_PERIS, 1, 0, 0),
-	GATE(pmu, "pmu", "aclk66", GATE_IP_PERIS, 2, CLK_IGNORE_UNUSED, 0),
-	GATE(cmu_top, "cmu_top", "aclk66",
+	GATE(mfc, "mfc", "div_aclk333", GATE_IP_MFC, 0, 0, 0),
+	GATE(smmu_mfcl, "smmu_mfcl", "div_aclk333", GATE_IP_MFC, 1, 0, 0),
+	GATE(smmu_mfcr, "smmu_mfcr", "div_aclk333", GATE_IP_MFC, 2, 0, 0),
+
+	GATE(rotator, "rotator", "div_aclk266", GATE_IP_GEN, 1, 0, 0),
+	GATE(jpeg, "jpeg", "div_aclk166", GATE_IP_GEN, 2, 0, 0),
+	GATE(mdma1, "mdma1", "div_aclk266", GATE_IP_GEN, 4, 0, 0),
+	GATE(smmu_rotator, "smmu_rotator", "div_aclk266", GATE_IP_GEN, 6, 0, 0),
+	GATE(smmu_jpeg, "smmu_jpeg", "div_aclk166", GATE_IP_GEN, 7, 0, 0),
+	GATE(smmu_mdma1, "smmu_mdma1", "div_aclk266", GATE_IP_GEN, 9, 0, 0),
+
+	GATE(pdma0, "pdma0", "div_aclk200", GATE_IP_FSYS, 1, 0, 0),
+	GATE(pdma1, "pdma1", "div_aclk200", GATE_IP_FSYS, 2, 0, 0),
+	GATE(sata, "sata", "div_aclk200", GATE_IP_FSYS, 6, 0, 0),
+	GATE(usbotg, "usbotg", "div_aclk200", GATE_IP_FSYS, 7, 0, 0),
+	GATE(mipi_hsi, "mipi_hsi", "div_aclk200", GATE_IP_FSYS, 8, 0, 0),
+	GATE(sdmmc0, "sdmmc0", "div_aclk200", GATE_IP_FSYS, 12, 0, 0),
+	GATE(sdmmc1, "sdmmc1", "div_aclk200", GATE_IP_FSYS, 13, 0, 0),
+	GATE(sdmmc2, "sdmmc2", "div_aclk200", GATE_IP_FSYS, 14, 0, 0),
+	GATE(sdmmc3, "sdmmc3", "div_aclk200", GATE_IP_FSYS, 15, 0, 0),
+	GATE(sromc, "sromc", "div_aclk200", GATE_IP_FSYS, 17, 0, 0),
+	GATE(usb2, "usb2", "div_aclk200", GATE_IP_FSYS, 18, 0, 0),
+	GATE(usb3, "usb3", "div_aclk200", GATE_IP_FSYS, 19, 0, 0),
+	GATE(sata_phyctrl, "sata_phyctrl", "div_aclk200",
+			GATE_IP_FSYS, 24, 0, 0),
+	GATE(sata_phyi2c, "sata_phyi2c", "div_aclk200", GATE_IP_FSYS, 25, 0, 0),
+
+	GATE(uart0, "uart0", "div_aclk66", GATE_IP_PERIC, 0, 0, 0),
+	GATE(uart1, "uart1", "div_aclk66", GATE_IP_PERIC, 1, 0, 0),
+	GATE(uart2, "uart2", "div_aclk66", GATE_IP_PERIC, 2, 0, 0),
+	GATE(uart3, "uart3", "div_aclk66", GATE_IP_PERIC, 3, 0, 0),
+	GATE(uart4, "uart4", "div_aclk66", GATE_IP_PERIC, 4, 0, 0),
+	GATE(i2c0, "i2c0", "div_aclk66", GATE_IP_PERIC, 6, 0, 0),
+	GATE(i2c1, "i2c1", "div_aclk66", GATE_IP_PERIC, 7, 0, 0),
+	GATE(i2c2, "i2c2", "div_aclk66", GATE_IP_PERIC, 8, 0, 0),
+	GATE(i2c3, "i2c3", "div_aclk66", GATE_IP_PERIC, 9, 0, 0),
+	GATE(i2c4, "i2c4", "div_aclk66", GATE_IP_PERIC, 10, 0, 0),
+	GATE(i2c5, "i2c5", "div_aclk66", GATE_IP_PERIC, 11, 0, 0),
+	GATE(i2c6, "i2c6", "div_aclk66", GATE_IP_PERIC, 12, 0, 0),
+	GATE(i2c7, "i2c7", "div_aclk66", GATE_IP_PERIC, 13, 0, 0),
+	GATE(i2c_hdmi, "i2c_hdmi", "div_aclk66", GATE_IP_PERIC, 14, 0, 0),
+	GATE(adc, "adc", "div_aclk66", GATE_IP_PERIC, 15, 0, 0),
+	GATE(spi0, "spi0", "div_aclk66", GATE_IP_PERIC, 16, 0, 0),
+	GATE(spi1, "spi1", "div_aclk66", GATE_IP_PERIC, 17, 0, 0),
+	GATE(spi2, "spi2", "div_aclk66", GATE_IP_PERIC, 18, 0, 0),
+	GATE(i2s1, "i2s1", "div_aclk66", GATE_IP_PERIC, 20, 0, 0),
+	GATE(i2s2, "i2s2", "div_aclk66", GATE_IP_PERIC, 21, 0, 0),
+	GATE(pcm1, "pcm1", "div_aclk66", GATE_IP_PERIC, 22, 0, 0),
+	GATE(pcm2, "pcm2", "div_aclk66", GATE_IP_PERIC, 23, 0, 0),
+	GATE(pwm, "pwm", "div_aclk66", GATE_IP_PERIC, 24, 0, 0),
+	GATE(spdif, "spdif", "div_aclk66", GATE_IP_PERIC, 26, 0, 0),
+	GATE(ac97, "ac97", "div_aclk66", GATE_IP_PERIC, 27, 0, 0),
+	GATE(hsi2c0, "hsi2c0", "div_aclk66", GATE_IP_PERIC, 28, 0, 0),
+	GATE(hsi2c1, "hsi2c1", "div_aclk66", GATE_IP_PERIC, 29, 0, 0),
+	GATE(hsi2c2, "hsi2c2", "div_aclk66", GATE_IP_PERIC, 30, 0, 0),
+	GATE(hsi2c3, "hsi2c3", "div_aclk66", GATE_IP_PERIC, 31, 0, 0),
+
+	GATE(chipid, "chipid", "div_aclk66", GATE_IP_PERIS, 0, 0, 0),
+	GATE(sysreg, "sysreg", "div_aclk66", GATE_IP_PERIS, 1, 0, 0),
+	GATE(pmu, "pmu", "div_aclk66", GATE_IP_PERIS, 2, CLK_IGNORE_UNUSED, 0),
+	GATE(cmu_top, "cmu_top", "div_aclk66",
 			GATE_IP_PERIS, 3, CLK_IGNORE_UNUSED, 0),
-	GATE(cmu_core, "cmu_core", "aclk66",
+	GATE(cmu_core, "cmu_core", "div_aclk66",
 			GATE_IP_PERIS, 4, CLK_IGNORE_UNUSED, 0),
-	GATE(cmu_mem, "cmu_mem", "aclk66",
+	GATE(cmu_mem, "cmu_mem", "div_aclk66",
 			GATE_IP_PERIS, 5, CLK_IGNORE_UNUSED, 0),
-	GATE(tzpc0, "tzpc0", "aclk66", GATE_IP_PERIS, 6, 0, 0),
-	GATE(tzpc1, "tzpc1", "aclk66", GATE_IP_PERIS, 7, 0, 0),
-	GATE(tzpc2, "tzpc2", "aclk66", GATE_IP_PERIS, 8, 0, 0),
-	GATE(tzpc3, "tzpc3", "aclk66", GATE_IP_PERIS, 9, 0, 0),
-	GATE(tzpc4, "tzpc4", "aclk66", GATE_IP_PERIS, 10, 0, 0),
-	GATE(tzpc5, "tzpc5", "aclk66", GATE_IP_PERIS, 11, 0, 0),
-	GATE(tzpc6, "tzpc6", "aclk66", GATE_IP_PERIS, 12, 0, 0),
-	GATE(tzpc7, "tzpc7", "aclk66", GATE_IP_PERIS, 13, 0, 0),
-	GATE(tzpc8, "tzpc8", "aclk66", GATE_IP_PERIS, 14, 0, 0),
-	GATE(tzpc9, "tzpc9", "aclk66", GATE_IP_PERIS, 15, 0, 0),
-	GATE(hdmi_cec, "hdmi_cec", "aclk66", GATE_IP_PERIS, 16, 0, 0),
-	GATE(mct, "mct", "aclk66", GATE_IP_PERIS, 18, 0, 0),
-	GATE(wdt, "wdt", "aclk66", GATE_IP_PERIS, 19, 0, 0),
-	GATE(rtc, "rtc", "aclk66", GATE_IP_PERIS, 20, 0, 0),
-	GATE(tmu, "tmu", "aclk66", GATE_IP_PERIS, 21, 0, 0),
+	GATE(tzpc0, "tzpc0", "div_aclk66", GATE_IP_PERIS, 6, 0, 0),
+	GATE(tzpc1, "tzpc1", "div_aclk66", GATE_IP_PERIS, 7, 0, 0),
+	GATE(tzpc2, "tzpc2", "div_aclk66", GATE_IP_PERIS, 8, 0, 0),
+	GATE(tzpc3, "tzpc3", "div_aclk66", GATE_IP_PERIS, 9, 0, 0),
+	GATE(tzpc4, "tzpc4", "div_aclk66", GATE_IP_PERIS, 10, 0, 0),
+	GATE(tzpc5, "tzpc5", "div_aclk66", GATE_IP_PERIS, 11, 0, 0),
+	GATE(tzpc6, "tzpc6", "div_aclk66", GATE_IP_PERIS, 12, 0, 0),
+	GATE(tzpc7, "tzpc7", "div_aclk66", GATE_IP_PERIS, 13, 0, 0),
+	GATE(tzpc8, "tzpc8", "div_aclk66", GATE_IP_PERIS, 14, 0, 0),
+	GATE(tzpc9, "tzpc9", "div_aclk66", GATE_IP_PERIS, 15, 0, 0),
+	GATE(hdmi_cec, "hdmi_cec", "div_aclk66", GATE_IP_PERIS, 16, 0, 0),
+	GATE(mct, "mct", "div_aclk66", GATE_IP_PERIS, 18, 0, 0),
+	GATE(wdt, "wdt", "div_aclk66", GATE_IP_PERIS, 19, 0, 0),
+	GATE(rtc, "rtc", "div_aclk66", GATE_IP_PERIS, 20, 0, 0),
+	GATE(tmu, "tmu", "div_aclk66", GATE_IP_PERIS, 21, 0, 0),
 };
 
 static struct samsung_pll_rate_table vpll_24mhz_tbl[] __initdata = {
@@ -667,6 +668,6 @@ static void __init exynos5250_clk_init(struct device_node *np)
 			ARRAY_SIZE(exynos5250_gate_clks));
 
 	pr_info("Exynos5250: clock setup completed, armclk=%ld\n",
-			_get_rate("armclk"));
+			_get_rate("div_arm2"));
 }
 CLK_OF_DECLARE(exynos5250_clk, "samsung,exynos5250-clock", exynos5250_clk_init);
-- 
1.8.3.2
