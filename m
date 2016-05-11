From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 11 May 2016 14:02:10 +0200
Subject: [PATCH 14/18] clk: samsung: exynos5433: Constify all clock
 initializers
In-Reply-To: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
References: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1462968134-6085-14-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All of initialization data can be made const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos5433.c | 240 +++++++++++++++++------------------
 1 file changed, 120 insertions(+), 120 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index 128527b8fbeb..f202a51ff99b 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -108,7 +108,7 @@
 #define ENABLE_CMU_TOP			0x0c00
 #define ENABLE_CMU_TOP_DIV_STAT		0x0c04
 
-static unsigned long top_clk_regs[] __initdata = {
+static const unsigned long top_clk_regs[] __initconst = {
 	ISP_PLL_LOCK,
 	AUD_PLL_LOCK,
 	ISP_PLL_CON0,
@@ -218,11 +218,11 @@ PNAME(mout_sclk_audio0_p)	= { "ioclk_audiocdclk0", "oscclk",
 
 PNAME(mout_sclk_hdmi_spdif_p)	= { "sclk_audio1", "ioclk_spdif_extclk", };
 
-static struct samsung_fixed_factor_clock top_fixed_factor_clks[] __initdata = {
+static const struct samsung_fixed_factor_clock top_fixed_factor_clks[] __initconst = {
 	FFACTOR(0, "oscclk_efuse_common", "oscclk", 1, 1, 0),
 };
 
-static struct samsung_fixed_rate_clock top_fixed_clks[] __initdata = {
+static const struct samsung_fixed_rate_clock top_fixed_clks[] __initconst = {
 	/* Xi2s{0|1}CDCLK input clock for I2S/PCM */
 	FRATE(0, "ioclk_audiocdclk1", NULL, 0, 100000000),
 	FRATE(0, "ioclk_audiocdclk0", NULL, 0, 100000000),
@@ -238,7 +238,7 @@ static struct samsung_fixed_rate_clock top_fixed_clks[] __initdata = {
 	FRATE(0, "ioclk_i2s1_bclk_in", NULL, 0, 12288000),
 };
 
-static struct samsung_mux_clock top_mux_clks[] __initdata = {
+static const struct samsung_mux_clock top_mux_clks[] __initconst = {
 	/* MUX_SEL_TOP0 */
 	MUX(CLK_MOUT_AUD_PLL, "mout_aud_pll", mout_aud_pll_p, MUX_SEL_TOP0,
 			4, 1),
@@ -374,7 +374,7 @@ static struct samsung_mux_clock top_mux_clks[] __initdata = {
 			mout_sclk_hdmi_spdif_p, MUX_SEL_TOP_DISP, 0, 1),
 };
 
-static struct samsung_div_clock top_div_clks[] __initdata = {
+static const struct samsung_div_clock top_div_clks[] __initconst = {
 	/* DIV_TOP0 */
 	DIV(CLK_DIV_ACLK_CAM1_333, "div_aclk_cam1_333", "mout_aclk_cam1_333",
 			DIV_TOP0, 28, 3),
@@ -538,7 +538,7 @@ static struct samsung_div_clock top_div_clks[] __initdata = {
 			DIV_TOP_PERIC4, 0, 4),
 };
 
-static struct samsung_gate_clock top_gate_clks[] __initdata = {
+static const struct samsung_gate_clock top_gate_clks[] __initconst = {
 	/* ENABLE_ACLK_TOP */
 	GATE(CLK_ACLK_G3D_400, "aclk_g3d_400", "div_aclk_g3d_400",
 			ENABLE_ACLK_TOP, 30, 0, 0),
@@ -693,7 +693,7 @@ static struct samsung_gate_clock top_gate_clks[] __initdata = {
  * ATLAS_PLL & APOLLO_PLL & MEM0_PLL & MEM1_PLL & BUS_PLL & MFC_PLL
  * & MPHY_PLL & G3D_PLL & DISP_PLL & ISP_PLL
  */
-static struct samsung_pll_rate_table exynos5443_pll_rates[] = {
+static const struct samsung_pll_rate_table exynos5443_pll_rates[] = {
 	PLL_35XX_RATE(2500000000U, 625, 6,  0),
 	PLL_35XX_RATE(2400000000U, 500, 5,  0),
 	PLL_35XX_RATE(2300000000U, 575, 6,  0),
@@ -744,7 +744,7 @@ static struct samsung_pll_rate_table exynos5443_pll_rates[] = {
 };
 
 /* AUD_PLL */
-static struct samsung_pll_rate_table exynos5443_aud_pll_rates[] = {
+static const struct samsung_pll_rate_table exynos5443_aud_pll_rates[] = {
 	PLL_36XX_RATE(400000000U, 200, 3, 2,      0),
 	PLL_36XX_RATE(393216000U, 197, 3, 2, -25690),
 	PLL_36XX_RATE(384000000U, 128, 2, 2,      0),
@@ -757,14 +757,14 @@ static struct samsung_pll_rate_table exynos5443_aud_pll_rates[] = {
 	{ /* sentinel */ }
 };
 
-static struct samsung_pll_clock top_pll_clks[] __initdata = {
+static const struct samsung_pll_clock top_pll_clks[] __initconst = {
 	PLL(pll_35xx, CLK_FOUT_ISP_PLL, "fout_isp_pll", "oscclk",
 		ISP_PLL_LOCK, ISP_PLL_CON0, exynos5443_pll_rates),
 	PLL(pll_36xx, CLK_FOUT_AUD_PLL, "fout_aud_pll", "oscclk",
 		AUD_PLL_LOCK, AUD_PLL_CON0, exynos5443_aud_pll_rates),
 };
 
-static struct samsung_cmu_info top_cmu_info __initdata = {
+static const struct samsung_cmu_info top_cmu_info __initconst = {
 	.pll_clks		= top_pll_clks,
 	.nr_pll_clks		= ARRAY_SIZE(top_pll_clks),
 	.mux_clks		= top_mux_clks,
@@ -800,7 +800,7 @@ CLK_OF_DECLARE(exynos5433_cmu_top, "samsung,exynos5433-cmu-top",
 #define DIV_CPIF		0x0600
 #define ENABLE_SCLK_CPIF	0x0a00
 
-static unsigned long cpif_clk_regs[] __initdata = {
+static const unsigned long cpif_clk_regs[] __initconst = {
 	MPHY_PLL_LOCK,
 	MPHY_PLL_CON0,
 	MPHY_PLL_CON1,
@@ -813,24 +813,24 @@ static unsigned long cpif_clk_regs[] __initdata = {
 /* list of all parent clock list */
 PNAME(mout_mphy_pll_p)		= { "oscclk", "fout_mphy_pll", };
 
-static struct samsung_pll_clock cpif_pll_clks[] __initdata = {
+static const struct samsung_pll_clock cpif_pll_clks[] __initconst = {
 	PLL(pll_35xx, CLK_FOUT_MPHY_PLL, "fout_mphy_pll", "oscclk",
 		MPHY_PLL_LOCK, MPHY_PLL_CON0, exynos5443_pll_rates),
 };
 
-static struct samsung_mux_clock cpif_mux_clks[] __initdata = {
+static const struct samsung_mux_clock cpif_mux_clks[] __initconst = {
 	/* MUX_SEL_CPIF0 */
 	MUX(CLK_MOUT_MPHY_PLL, "mout_mphy_pll", mout_mphy_pll_p, MUX_SEL_CPIF0,
 			0, 1),
 };
 
-static struct samsung_div_clock cpif_div_clks[] __initdata = {
+static const struct samsung_div_clock cpif_div_clks[] __initconst = {
 	/* DIV_CPIF */
 	DIV(CLK_DIV_SCLK_MPHY, "div_sclk_mphy", "mout_mphy_pll", DIV_CPIF,
 			0, 6),
 };
 
-static struct samsung_gate_clock cpif_gate_clks[] __initdata = {
+static const struct samsung_gate_clock cpif_gate_clks[] __initconst = {
 	/* ENABLE_SCLK_CPIF */
 	GATE(CLK_SCLK_MPHY_PLL, "sclk_mphy_pll", "mout_mphy_pll",
 			ENABLE_SCLK_CPIF, 9, 0, 0),
@@ -838,7 +838,7 @@ static struct samsung_gate_clock cpif_gate_clks[] __initdata = {
 			ENABLE_SCLK_CPIF, 4, 0, 0),
 };
 
-static struct samsung_cmu_info cpif_cmu_info __initdata = {
+static const struct samsung_cmu_info cpif_cmu_info __initconst = {
 	.pll_clks		= cpif_pll_clks,
 	.nr_pll_clks		= ARRAY_SIZE(cpif_pll_clks),
 	.mux_clks		= cpif_mux_clks,
@@ -939,7 +939,7 @@ CLK_OF_DECLARE(exynos5433_cmu_cpif, "samsung,exynos5433-cmu-cpif",
 #define PAUSE				0x1008
 #define DDRPHY_LOCK_CTRL		0x100c
 
-static unsigned long mif_clk_regs[] __initdata = {
+static const unsigned long mif_clk_regs[] __initconst = {
 	MEM0_PLL_LOCK,
 	MEM1_PLL_LOCK,
 	BUS_PLL_LOCK,
@@ -1004,7 +1004,7 @@ static unsigned long mif_clk_regs[] __initdata = {
 	DDRPHY_LOCK_CTRL,
 };
 
-static struct samsung_pll_clock mif_pll_clks[] __initdata = {
+static const struct samsung_pll_clock mif_pll_clks[] __initconst = {
 	PLL(pll_35xx, CLK_FOUT_MEM0_PLL, "fout_mem0_pll", "oscclk",
 		MEM0_PLL_LOCK, MEM0_PLL_CON0, exynos5443_pll_rates),
 	PLL(pll_35xx, CLK_FOUT_MEM1_PLL, "fout_mem1_pll", "oscclk",
@@ -1065,7 +1065,7 @@ PNAME(mout_sclk_decon_tv_vclk_b_p) = { "mout_sclk_decon_tv_vclk_a",
 PNAME(mout_sclk_dsim1_c_p)	= { "mout_sclk_dsim1_b", "sclk_mphy_pll", };
 PNAME(mout_sclk_dsim1_b_p)	= { "mout_sclk_dsim1_a", "mout_mfc_pll_div2",};
 
-static struct samsung_fixed_factor_clock mif_fixed_factor_clks[] __initdata = {
+static const struct samsung_fixed_factor_clock mif_fixed_factor_clks[] __initconst = {
 	/* dout_{mfc|bus|mem1|mem0}_pll is half fixed rate from parent mux */
 	FFACTOR(CLK_DOUT_MFC_PLL, "dout_mfc_pll", "mout_mfc_pll", 1, 1, 0),
 	FFACTOR(CLK_DOUT_BUS_PLL, "dout_bus_pll", "mout_bus_pll", 1, 1, 0),
@@ -1073,7 +1073,7 @@ static struct samsung_fixed_factor_clock mif_fixed_factor_clks[] __initdata = {
 	FFACTOR(CLK_DOUT_MEM0_PLL, "dout_mem0_pll", "mout_mem0_pll", 1, 1, 0),
 };
 
-static struct samsung_mux_clock mif_mux_clks[] __initdata = {
+static const struct samsung_mux_clock mif_mux_clks[] __initconst = {
 	/* MUX_SEL_MIF0 */
 	MUX(CLK_MOUT_MFC_PLL_DIV2, "mout_mfc_pll_div2", mout_mfc_pll_div2_p,
 			MUX_SEL_MIF0, 28, 1),
@@ -1169,7 +1169,7 @@ static struct samsung_mux_clock mif_mux_clks[] __initdata = {
 			MUX_SEL_MIF7, 0, 1),
 };
 
-static struct samsung_div_clock mif_div_clks[] __initdata = {
+static const struct samsung_div_clock mif_div_clks[] __initconst = {
 	/* DIV_MIF1 */
 	DIV(CLK_DIV_SCLK_HPM_MIF, "div_sclk_hpm_mif", "div_clk2x_phy",
 			DIV_MIF1, 16, 2),
@@ -1223,7 +1223,7 @@ static struct samsung_div_clock mif_div_clks[] __initdata = {
 			0, 3),
 };
 
-static struct samsung_gate_clock mif_gate_clks[] __initdata = {
+static const struct samsung_gate_clock mif_gate_clks[] __initconst = {
 	/* ENABLE_ACLK_MIF0 */
 	GATE(CLK_CLK2X_PHY1, "clk2k_phy1", "div_clk2x_phy", ENABLE_ACLK_MIF0,
 			19, CLK_IGNORE_UNUSED, 0),
@@ -1486,7 +1486,7 @@ static struct samsung_gate_clock mif_gate_clks[] __initdata = {
 			ENABLE_SCLK_MIF, 0, CLK_IGNORE_UNUSED, 0),
 };
 
-static struct samsung_cmu_info mif_cmu_info __initdata = {
+static const struct samsung_cmu_info mif_cmu_info __initconst = {
 	.pll_clks		= mif_pll_clks,
 	.nr_pll_clks		= ARRAY_SIZE(mif_pll_clks),
 	.mux_clks		= mif_mux_clks,
@@ -1522,7 +1522,7 @@ CLK_OF_DECLARE(exynos5433_cmu_mif, "samsung,exynos5433-cmu-mif",
 #define ENABLE_IP_PERIC1		0x0B04
 #define ENABLE_IP_PERIC2		0x0B08
 
-static unsigned long peric_clk_regs[] __initdata = {
+static const unsigned long peric_clk_regs[] __initconst = {
 	DIV_PERIC,
 	ENABLE_ACLK_PERIC,
 	ENABLE_PCLK_PERIC0,
@@ -1533,13 +1533,13 @@ static unsigned long peric_clk_regs[] __initdata = {
 	ENABLE_IP_PERIC2,
 };
 
-static struct samsung_div_clock peric_div_clks[] __initdata = {
+static const struct samsung_div_clock peric_div_clks[] __initconst = {
 	/* DIV_PERIC */
 	DIV(CLK_DIV_SCLK_SCI, "div_sclk_sci", "oscclk", DIV_PERIC, 4, 4),
 	DIV(CLK_DIV_SCLK_SC_IN, "div_sclk_sc_in", "oscclk", DIV_PERIC, 0, 4),
 };
 
-static struct samsung_gate_clock peric_gate_clks[] __initdata = {
+static const struct samsung_gate_clock peric_gate_clks[] __initconst = {
 	/* ENABLE_ACLK_PERIC */
 	GATE(CLK_ACLK_AHB2APB_PERIC2P, "aclk_ahb2apb_peric2p", "aclk_peric_66",
 			ENABLE_ACLK_PERIC, 3, CLK_IGNORE_UNUSED, 0),
@@ -1681,7 +1681,7 @@ static struct samsung_gate_clock peric_gate_clks[] __initdata = {
 			ENABLE_SCLK_PERIC, 0, CLK_SET_RATE_PARENT, 0),
 };
 
-static struct samsung_cmu_info peric_cmu_info __initdata = {
+static const struct samsung_cmu_info peric_cmu_info __initconst = {
 	.div_clks		= peric_div_clks,
 	.nr_div_clks		= ARRAY_SIZE(peric_div_clks),
 	.gate_clks		= peric_gate_clks,
@@ -1728,7 +1728,7 @@ CLK_OF_DECLARE(exynos5433_cmu_peric, "samsung,exynos5433-cmu-peric",
 #define ENABLE_IP_PERIS_SECURE_ANTIBRK_CNT		0x0b1c
 #define ENABLE_IP_PERIS_SECURE_OTP_CON			0x0b20
 
-static unsigned long peris_clk_regs[] __initdata = {
+static const unsigned long peris_clk_regs[] __initconst = {
 	ENABLE_ACLK_PERIS,
 	ENABLE_PCLK_PERIS,
 	ENABLE_PCLK_PERIS_SECURE_TZPC,
@@ -1756,7 +1756,7 @@ static unsigned long peris_clk_regs[] __initdata = {
 	ENABLE_IP_PERIS_SECURE_OTP_CON,
 };
 
-static struct samsung_gate_clock peris_gate_clks[] __initdata = {
+static const struct samsung_gate_clock peris_gate_clks[] __initconst = {
 	/* ENABLE_ACLK_PERIS */
 	GATE(CLK_ACLK_AHB2APB_PERIS1P, "aclk_ahb2apb_peris1p", "aclk_peris_66",
 			ENABLE_ACLK_PERIS, 2, CLK_IGNORE_UNUSED, 0),
@@ -1875,7 +1875,7 @@ static struct samsung_gate_clock peris_gate_clks[] __initdata = {
 			ENABLE_SCLK_PERIS_SECURE_OTP_CON, 0, 0, 0),
 };
 
-static struct samsung_cmu_info peris_cmu_info __initdata = {
+static const struct samsung_cmu_info peris_cmu_info __initconst = {
 	.gate_clks		= peris_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(peris_gate_clks),
 	.nr_clk_ids		= PERIS_NR_CLK,
@@ -1959,7 +1959,7 @@ PNAME(mout_sclk_mphy_p)
 		= { "mout_sclk_ufs_mphy_user",
 			    "mout_phyclk_lli_mphy_to_ufs_user", };
 
-static unsigned long fsys_clk_regs[] __initdata = {
+static const unsigned long fsys_clk_regs[] __initconst = {
 	MUX_SEL_FSYS0,
 	MUX_SEL_FSYS1,
 	MUX_SEL_FSYS2,
@@ -1980,7 +1980,7 @@ static unsigned long fsys_clk_regs[] __initdata = {
 	ENABLE_IP_FSYS1,
 };
 
-static struct samsung_fixed_rate_clock fsys_fixed_clks[] __initdata = {
+static const struct samsung_fixed_rate_clock fsys_fixed_clks[] __initconst = {
 	/* PHY clocks from USBDRD30_PHY */
 	FRATE(CLK_PHYCLK_USBDRD30_UDRD30_PHYCLOCK_PHY,
 			"phyclk_usbdrd30_udrd30_phyclock_phy", NULL,
@@ -2020,7 +2020,7 @@ static struct samsung_fixed_rate_clock fsys_fixed_clks[] __initdata = {
 			NULL, 0, 26000000),
 };
 
-static struct samsung_mux_clock fsys_mux_clks[] __initdata = {
+static const struct samsung_mux_clock fsys_mux_clks[] __initconst = {
 	/* MUX_SEL_FSYS0 */
 	MUX(CLK_MOUT_SCLK_UFS_MPHY_USER, "mout_sclk_ufs_mphy_user",
 			mout_sclk_ufs_mphy_user_p, MUX_SEL_FSYS0, 4, 1),
@@ -2104,7 +2104,7 @@ static struct samsung_mux_clock fsys_mux_clks[] __initdata = {
 			MUX_SEL_FSYS4, 0, 1),
 };
 
-static struct samsung_gate_clock fsys_gate_clks[] __initdata = {
+static const struct samsung_gate_clock fsys_gate_clks[] __initconst = {
 	/* ENABLE_ACLK_FSYS0 */
 	GATE(CLK_ACLK_PCIE, "aclk_pcie", "mout_aclk_fsys_200_user",
 			ENABLE_ACLK_FSYS0, 13, CLK_IGNORE_UNUSED, 0),
@@ -2274,7 +2274,7 @@ static struct samsung_gate_clock fsys_gate_clks[] __initdata = {
 	GATE(CLK_PDMA0, "pdma0", "aclk_pdma0", ENABLE_IP_FSYS0, 0, 0, 0),
 };
 
-static struct samsung_cmu_info fsys_cmu_info __initdata = {
+static const struct samsung_cmu_info fsys_cmu_info __initconst = {
 	.mux_clks		= fsys_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(fsys_mux_clks),
 	.gate_clks		= fsys_gate_clks,
@@ -2310,7 +2310,7 @@ CLK_OF_DECLARE(exynos5433_cmu_fsys, "samsung,exynos5433-cmu-fsys",
 #define DIV_ENABLE_IP_G2D1			0x0b04
 #define DIV_ENABLE_IP_G2D_SECURE_SMMU_G2D	0x0b08
 
-static unsigned long g2d_clk_regs[] __initdata = {
+static const unsigned long g2d_clk_regs[] __initconst = {
 	MUX_SEL_G2D0,
 	MUX_SEL_ENABLE_G2D0,
 	DIV_G2D,
@@ -2327,7 +2327,7 @@ static unsigned long g2d_clk_regs[] __initdata = {
 PNAME(mout_aclk_g2d_266_user_p)		= { "oscclk", "aclk_g2d_266", };
 PNAME(mout_aclk_g2d_400_user_p)		= { "oscclk", "aclk_g2d_400", };
 
-static struct samsung_mux_clock g2d_mux_clks[] __initdata = {
+static const struct samsung_mux_clock g2d_mux_clks[] __initconst = {
 	/* MUX_SEL_G2D0 */
 	MUX(CLK_MUX_ACLK_G2D_266_USER, "mout_aclk_g2d_266_user",
 			mout_aclk_g2d_266_user_p, MUX_SEL_G2D0, 4, 1),
@@ -2335,13 +2335,13 @@ static struct samsung_mux_clock g2d_mux_clks[] __initdata = {
 			mout_aclk_g2d_400_user_p, MUX_SEL_G2D0, 0, 1),
 };
 
-static struct samsung_div_clock g2d_div_clks[] __initdata = {
+static const struct samsung_div_clock g2d_div_clks[] __initconst = {
 	/* DIV_G2D */
 	DIV(CLK_DIV_PCLK_G2D, "div_pclk_g2d", "mout_aclk_g2d_266_user",
 			DIV_G2D, 0, 2),
 };
 
-static struct samsung_gate_clock g2d_gate_clks[] __initdata = {
+static const struct samsung_gate_clock g2d_gate_clks[] __initconst = {
 	/* DIV_ENABLE_ACLK_G2D */
 	GATE(CLK_ACLK_SMMU_MDMA1, "aclk_smmu_mdma1", "mout_aclk_g2d_266_user",
 			DIV_ENABLE_ACLK_G2D, 12, 0, 0),
@@ -2398,7 +2398,7 @@ static struct samsung_gate_clock g2d_gate_clks[] __initdata = {
 		DIV_ENABLE_PCLK_G2D_SECURE_SMMU_G2D, 0, 0, 0),
 };
 
-static struct samsung_cmu_info g2d_cmu_info __initdata = {
+static const struct samsung_cmu_info g2d_cmu_info __initconst = {
 	.mux_clks		= g2d_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(g2d_mux_clks),
 	.div_clks		= g2d_div_clks,
@@ -2454,7 +2454,7 @@ CLK_OF_DECLARE(exynos5433_cmu_g2d, "samsung,exynos5433-cmu-g2d",
 #define CLKOUT_CMU_DISP			0x0c00
 #define CLKOUT_CMU_DISP_DIV_STAT	0x0c04
 
-static unsigned long disp_clk_regs[] __initdata = {
+static const unsigned long disp_clk_regs[] __initconst = {
 	DISP_PLL_LOCK,
 	DISP_PLL_CON0,
 	DISP_PLL_CON1,
@@ -2527,12 +2527,12 @@ PNAME(mout_sclk_decon_tv_vclk_c_disp_p)	= {
 PNAME(mout_sclk_decon_tv_vclk_b_disp_p)	= { "mout_sclk_decon_tv_vclk_a_disp",
 					    "mout_sclk_decon_tv_vclk_user", };
 
-static struct samsung_pll_clock disp_pll_clks[] __initdata = {
+static const struct samsung_pll_clock disp_pll_clks[] __initconst = {
 	PLL(pll_35xx, CLK_FOUT_DISP_PLL, "fout_disp_pll", "oscclk",
 		DISP_PLL_LOCK, DISP_PLL_CON0, exynos5443_pll_rates),
 };
 
-static struct samsung_fixed_factor_clock disp_fixed_factor_clks[] __initdata = {
+static const struct samsung_fixed_factor_clock disp_fixed_factor_clks[] __initconst = {
 	/*
 	 * sclk_rgb_{vclk|tv_vclk} is half clock of sclk_decon_{vclk|tv_vclk}.
 	 * The divider has fixed value (2) between sclk_rgb_{vclk|tv_vclk}
@@ -2544,7 +2544,7 @@ static struct samsung_fixed_factor_clock disp_fixed_factor_clks[] __initdata = {
 			1, 2, 0),
 };
 
-static struct samsung_fixed_rate_clock disp_fixed_clks[] __initdata = {
+static const struct samsung_fixed_rate_clock disp_fixed_clks[] __initconst = {
 	/* PHY clocks from MIPI_DPHY1 */
 	FRATE(0, "phyclk_mipidphy1_bitclkdiv8_phy", NULL, 0, 188000000),
 	FRATE(0, "phyclk_mipidphy1_rxclkesc0_phy", NULL, 0, 100000000),
@@ -2558,7 +2558,7 @@ static struct samsung_fixed_rate_clock disp_fixed_clks[] __initdata = {
 			NULL, 0, 166000000),
 };
 
-static struct samsung_mux_clock disp_mux_clks[] __initdata = {
+static const struct samsung_mux_clock disp_mux_clks[] __initconst = {
 	/* MUX_SEL_DISP0 */
 	MUX(CLK_MOUT_DISP_PLL, "mout_disp_pll", mout_disp_pll_p, MUX_SEL_DISP0,
 			0, 1),
@@ -2633,7 +2633,7 @@ static struct samsung_mux_clock disp_mux_clks[] __initdata = {
 			mout_sclk_decon_vclk_p, MUX_SEL_DISP4, 0, 1),
 };
 
-static struct samsung_div_clock disp_div_clks[] __initdata = {
+static const struct samsung_div_clock disp_div_clks[] __initconst = {
 	/* DIV_DISP */
 	DIV(CLK_DIV_SCLK_DSIM1_DISP, "div_sclk_dsim1_disp",
 			"mout_sclk_dsim1_b_disp", DIV_DISP, 24, 3),
@@ -2651,7 +2651,7 @@ static struct samsung_div_clock disp_div_clks[] __initdata = {
 			DIV_DISP, 0, 2),
 };
 
-static struct samsung_gate_clock disp_gate_clks[] __initdata = {
+static const struct samsung_gate_clock disp_gate_clks[] __initconst = {
 	/* ENABLE_ACLK_DISP0 */
 	GATE(CLK_ACLK_DECON_TV, "aclk_decon_tv", "mout_aclk_disp_333_user",
 			ENABLE_ACLK_DISP0, 2, 0, 0),
@@ -2811,7 +2811,7 @@ static struct samsung_gate_clock disp_gate_clks[] __initdata = {
 			"div_sclk_decon_eclk_disp", ENABLE_SCLK_DISP, 2, 0, 0),
 };
 
-static struct samsung_cmu_info disp_cmu_info __initdata = {
+static const struct samsung_cmu_info disp_cmu_info __initconst = {
 	.pll_clks		= disp_pll_clks,
 	.nr_pll_clks		= ARRAY_SIZE(disp_pll_clks),
 	.mux_clks		= disp_mux_clks,
@@ -2856,7 +2856,7 @@ CLK_OF_DECLARE(exynos5433_cmu_disp, "samsung,exynos5433-cmu-disp",
 #define ENABLE_IP_AUD0			0x0b00
 #define ENABLE_IP_AUD1			0x0b04
 
-static unsigned long aud_clk_regs[] __initdata = {
+static const unsigned long aud_clk_regs[] __initconst = {
 	MUX_SEL_AUD0,
 	MUX_SEL_AUD1,
 	MUX_ENABLE_AUD0,
@@ -2875,13 +2875,13 @@ static unsigned long aud_clk_regs[] __initdata = {
 PNAME(mout_aud_pll_user_aud_p)	= { "oscclk", "fout_aud_pll", };
 PNAME(mout_sclk_aud_pcm_p)	= { "mout_aud_pll_user", "ioclk_audiocdclk0",};
 
-static struct samsung_fixed_rate_clock aud_fixed_clks[] __initdata = {
+static const struct samsung_fixed_rate_clock aud_fixed_clks[] __initconst = {
 	FRATE(0, "ioclk_jtag_tclk", NULL, 0, 33000000),
 	FRATE(0, "ioclk_slimbus_clk", NULL, 0, 25000000),
 	FRATE(0, "ioclk_i2s_bclk", NULL, 0, 50000000),
 };
 
-static struct samsung_mux_clock aud_mux_clks[] __initdata = {
+static const struct samsung_mux_clock aud_mux_clks[] __initconst = {
 	/* MUX_SEL_AUD0 */
 	MUX(CLK_MOUT_AUD_PLL_USER, "mout_aud_pll_user",
 			mout_aud_pll_user_aud_p, MUX_SEL_AUD0, 0, 1),
@@ -2893,7 +2893,7 @@ static struct samsung_mux_clock aud_mux_clks[] __initdata = {
 			MUX_SEL_AUD1, 0, 1),
 };
 
-static struct samsung_div_clock aud_div_clks[] __initdata = {
+static const struct samsung_div_clock aud_div_clks[] __initconst = {
 	/* DIV_AUD0 */
 	DIV(CLK_DIV_ATCLK_AUD, "div_atclk_aud", "div_aud_ca5", DIV_AUD0,
 			12, 4),
@@ -2915,7 +2915,7 @@ static struct samsung_div_clock aud_div_clks[] __initdata = {
 			DIV_AUD1, 0, 4),
 };
 
-static struct samsung_gate_clock aud_gate_clks[] __initdata = {
+static const struct samsung_gate_clock aud_gate_clks[] __initconst = {
 	/* ENABLE_ACLK_AUD */
 	GATE(CLK_ACLK_INTR_CTRL, "aclk_intr_ctrl", "div_aclk_aud",
 			ENABLE_ACLK_AUD, 12, 0, 0),
@@ -2985,7 +2985,7 @@ static struct samsung_gate_clock aud_gate_clks[] __initdata = {
 			ENABLE_SCLK_AUD1, 0, CLK_IGNORE_UNUSED, 0),
 };
 
-static struct samsung_cmu_info aud_cmu_info __initdata = {
+static const struct samsung_cmu_info aud_cmu_info __initconst = {
 	.mux_clks		= aud_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(aud_mux_clks),
 	.div_clks		= aud_div_clks,
@@ -3031,24 +3031,24 @@ PNAME(mout_aclk_bus2_400_p)	= { "oscclk", "aclk_bus2_400", };
 	ENABLE_IP_BUS0,		\
 	ENABLE_IP_BUS1
 
-static unsigned long bus01_clk_regs[] __initdata = {
+static const unsigned long bus01_clk_regs[] __initconst = {
 	CMU_BUS_COMMON_CLK_REGS,
 };
 
-static unsigned long bus2_clk_regs[] __initdata = {
+static const unsigned long bus2_clk_regs[] __initconst = {
 	MUX_SEL_BUS2,
 	MUX_ENABLE_BUS2,
 	CMU_BUS_COMMON_CLK_REGS,
 };
 
-static struct samsung_div_clock bus0_div_clks[] __initdata = {
+static const struct samsung_div_clock bus0_div_clks[] __initconst = {
 	/* DIV_BUS0 */
 	DIV(CLK_DIV_PCLK_BUS_133, "div_pclk_bus0_133", "aclk_bus0_400",
 			DIV_BUS, 0, 3),
 };
 
 /* CMU_BUS0 clocks */
-static struct samsung_gate_clock bus0_gate_clks[] __initdata = {
+static const struct samsung_gate_clock bus0_gate_clks[] __initconst = {
 	/* ENABLE_ACLK_BUS0 */
 	GATE(CLK_ACLK_AHB2APB_BUSP, "aclk_ahb2apb_bus0p", "div_pclk_bus0_133",
 			ENABLE_ACLK_BUS, 4, CLK_IGNORE_UNUSED, 0),
@@ -3067,13 +3067,13 @@ static struct samsung_gate_clock bus0_gate_clks[] __initdata = {
 };
 
 /* CMU_BUS1 clocks */
-static struct samsung_div_clock bus1_div_clks[] __initdata = {
+static const struct samsung_div_clock bus1_div_clks[] __initconst = {
 	/* DIV_BUS1 */
 	DIV(CLK_DIV_PCLK_BUS_133, "div_pclk_bus1_133", "aclk_bus1_400",
 			DIV_BUS, 0, 3),
 };
 
-static struct samsung_gate_clock bus1_gate_clks[] __initdata = {
+static const struct samsung_gate_clock bus1_gate_clks[] __initconst = {
 	/* ENABLE_ACLK_BUS1 */
 	GATE(CLK_ACLK_AHB2APB_BUSP, "aclk_ahb2apb_bus1p", "div_pclk_bus1_133",
 			ENABLE_ACLK_BUS, 4, CLK_IGNORE_UNUSED, 0),
@@ -3092,19 +3092,19 @@ static struct samsung_gate_clock bus1_gate_clks[] __initdata = {
 };
 
 /* CMU_BUS2 clocks */
-static struct samsung_mux_clock bus2_mux_clks[] __initdata = {
+static const struct samsung_mux_clock bus2_mux_clks[] __initconst = {
 	/* MUX_SEL_BUS2 */
 	MUX(CLK_MOUT_ACLK_BUS2_400_USER, "mout_aclk_bus2_400_user",
 			mout_aclk_bus2_400_p, MUX_SEL_BUS2, 0, 1),
 };
 
-static struct samsung_div_clock bus2_div_clks[] __initdata = {
+static const struct samsung_div_clock bus2_div_clks[] __initconst = {
 	/* DIV_BUS2 */
 	DIV(CLK_DIV_PCLK_BUS_133, "div_pclk_bus2_133",
 			"mout_aclk_bus2_400_user", DIV_BUS, 0, 3),
 };
 
-static struct samsung_gate_clock bus2_gate_clks[] __initdata = {
+static const struct samsung_gate_clock bus2_gate_clks[] __initconst = {
 	/* ENABLE_ACLK_BUS2 */
 	GATE(CLK_ACLK_AHB2APB_BUSP, "aclk_ahb2apb_bus2p", "div_pclk_bus2_133",
 			ENABLE_ACLK_BUS, 3, CLK_IGNORE_UNUSED, 0),
@@ -3133,19 +3133,19 @@ static struct samsung_gate_clock bus2_gate_clks[] __initdata = {
 	.nr_gate_clks		= ARRAY_SIZE(bus##id##_gate_clks),	\
 	.nr_clk_ids		= BUSx_NR_CLK
 
-static struct samsung_cmu_info bus0_cmu_info __initdata = {
+static const struct samsung_cmu_info bus0_cmu_info __initconst = {
 	CMU_BUS_INFO_CLKS(0),
 	.clk_regs		= bus01_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(bus01_clk_regs),
 };
 
-static struct samsung_cmu_info bus1_cmu_info __initdata = {
+static const struct samsung_cmu_info bus1_cmu_info __initconst = {
 	CMU_BUS_INFO_CLKS(1),
 	.clk_regs		= bus01_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(bus01_clk_regs),
 };
 
-static struct samsung_cmu_info bus2_cmu_info __initdata = {
+static const struct samsung_cmu_info bus2_cmu_info __initconst = {
 	CMU_BUS_INFO_CLKS(2),
 	.mux_clks		= bus2_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(bus2_mux_clks),
@@ -3189,7 +3189,7 @@ exynos5433_cmu_bus_init(2);
 #define CLKOUT_CMU_G3D_DIV_STAT		0x0c04
 #define CLK_STOPCTRL			0x1000
 
-static unsigned long g3d_clk_regs[] __initdata = {
+static const unsigned long g3d_clk_regs[] __initconst = {
 	G3D_PLL_LOCK,
 	G3D_PLL_CON0,
 	G3D_PLL_CON1,
@@ -3212,12 +3212,12 @@ static unsigned long g3d_clk_regs[] __initdata = {
 PNAME(mout_aclk_g3d_400_p)	= { "mout_g3d_pll", "aclk_g3d_400", };
 PNAME(mout_g3d_pll_p)		= { "oscclk", "fout_g3d_pll", };
 
-static struct samsung_pll_clock g3d_pll_clks[] __initdata = {
+static const struct samsung_pll_clock g3d_pll_clks[] __initconst = {
 	PLL(pll_35xx, CLK_FOUT_G3D_PLL, "fout_g3d_pll", "oscclk",
 		G3D_PLL_LOCK, G3D_PLL_CON0, exynos5443_pll_rates),
 };
 
-static struct samsung_mux_clock g3d_mux_clks[] __initdata = {
+static const struct samsung_mux_clock g3d_mux_clks[] __initconst = {
 	/* MUX_SEL_G3D */
 	MUX_F(CLK_MOUT_ACLK_G3D_400, "mout_aclk_g3d_400", mout_aclk_g3d_400_p,
 			MUX_SEL_G3D, 8, 1, CLK_SET_RATE_PARENT, 0),
@@ -3225,7 +3225,7 @@ static struct samsung_mux_clock g3d_mux_clks[] __initdata = {
 			MUX_SEL_G3D, 0, 1, CLK_SET_RATE_PARENT, 0),
 };
 
-static struct samsung_div_clock g3d_div_clks[] __initdata = {
+static const struct samsung_div_clock g3d_div_clks[] __initconst = {
 	/* DIV_G3D */
 	DIV(CLK_DIV_SCLK_HPM_G3D, "div_sclk_hpm_g3d", "mout_g3d_pll", DIV_G3D,
 			8, 2),
@@ -3235,7 +3235,7 @@ static struct samsung_div_clock g3d_div_clks[] __initdata = {
 			0, 3, CLK_SET_RATE_PARENT, 0),
 };
 
-static struct samsung_gate_clock g3d_gate_clks[] __initdata = {
+static const struct samsung_gate_clock g3d_gate_clks[] __initconst = {
 	/* ENABLE_ACLK_G3D */
 	GATE(CLK_ACLK_BTS_G3D1, "aclk_bts_g3d1", "div_aclk_g3d",
 			ENABLE_ACLK_G3D, 7, 0, 0),
@@ -3269,7 +3269,7 @@ static struct samsung_gate_clock g3d_gate_clks[] __initdata = {
 			ENABLE_SCLK_G3D, 0, 0, 0),
 };
 
-static struct samsung_cmu_info g3d_cmu_info __initdata = {
+static const struct samsung_cmu_info g3d_cmu_info __initconst = {
 	.pll_clks		= g3d_pll_clks,
 	.nr_pll_clks		= ARRAY_SIZE(g3d_pll_clks),
 	.mux_clks		= g3d_mux_clks,
@@ -3310,7 +3310,7 @@ CLK_OF_DECLARE(exynos5433_cmu_g3d, "samsung,exynos5433-cmu-g3d",
 #define ENABLE_IP_GSCL_SECURE_SMMU_GSCL1	0x0b0c
 #define ENABLE_IP_GSCL_SECURE_SMMU_GSCL2	0x0b10
 
-static unsigned long gscl_clk_regs[] __initdata = {
+static const unsigned long gscl_clk_regs[] __initconst = {
 	MUX_SEL_GSCL,
 	MUX_ENABLE_GSCL,
 	ENABLE_ACLK_GSCL,
@@ -3332,7 +3332,7 @@ static unsigned long gscl_clk_regs[] __initdata = {
 PNAME(aclk_gscl_111_user_p)	= { "oscclk", "aclk_gscl_111", };
 PNAME(aclk_gscl_333_user_p)	= { "oscclk", "aclk_gscl_333", };
 
-static struct samsung_mux_clock gscl_mux_clks[] __initdata = {
+static const struct samsung_mux_clock gscl_mux_clks[] __initconst = {
 	/* MUX_SEL_GSCL */
 	MUX(CLK_MOUT_ACLK_GSCL_111_USER, "mout_aclk_gscl_111_user",
 			aclk_gscl_111_user_p, MUX_SEL_GSCL, 4, 1),
@@ -3340,7 +3340,7 @@ static struct samsung_mux_clock gscl_mux_clks[] __initdata = {
 			aclk_gscl_333_user_p, MUX_SEL_GSCL, 0, 1),
 };
 
-static struct samsung_gate_clock gscl_gate_clks[] __initdata = {
+static const struct samsung_gate_clock gscl_gate_clks[] __initconst = {
 	/* ENABLE_ACLK_GSCL */
 	GATE(CLK_ACLK_BTS_GSCL2, "aclk_bts_gscl2", "mout_aclk_gscl_333_user",
 			ENABLE_ACLK_GSCL, 11, 0, 0),
@@ -3412,7 +3412,7 @@ static struct samsung_gate_clock gscl_gate_clks[] __initdata = {
 		ENABLE_PCLK_GSCL_SECURE_SMMU_GSCL2, 0, 0, 0),
 };
 
-static struct samsung_cmu_info gscl_cmu_info __initdata = {
+static const struct samsung_cmu_info gscl_cmu_info __initconst = {
 	.mux_clks		= gscl_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(gscl_mux_clks),
 	.gate_clks		= gscl_gate_clks,
@@ -3465,7 +3465,7 @@ CLK_OF_DECLARE(exynos5433_cmu_gscl, "samsung,exynos5433-cmu-gscl",
 #define APOLLO_INTR_SPREAD_USE_STANDBYWFI	0x1084
 #define APOLLO_INTR_SPREAD_BLOCKING_DURATION	0x1088
 
-static unsigned long apollo_clk_regs[] __initdata = {
+static const unsigned long apollo_clk_regs[] __initconst = {
 	APOLLO_PLL_LOCK,
 	APOLLO_PLL_CON0,
 	APOLLO_PLL_CON1,
@@ -3500,12 +3500,12 @@ PNAME(mout_bus_pll_apollo_user_p)	= { "oscclk", "sclk_bus_pll_apollo", };
 PNAME(mout_apollo_p)			= { "mout_apollo_pll",
 					    "mout_bus_pll_apollo_user", };
 
-static struct samsung_pll_clock apollo_pll_clks[] __initdata = {
+static const struct samsung_pll_clock apollo_pll_clks[] __initconst = {
 	PLL(pll_35xx, CLK_FOUT_APOLLO_PLL, "fout_apollo_pll", "oscclk",
 		APOLLO_PLL_LOCK, APOLLO_PLL_CON0, exynos5443_pll_rates),
 };
 
-static struct samsung_mux_clock apollo_mux_clks[] __initdata = {
+static const struct samsung_mux_clock apollo_mux_clks[] __initconst = {
 	/* MUX_SEL_APOLLO0 */
 	MUX_F(CLK_MOUT_APOLLO_PLL, "mout_apollo_pll", mout_apollo_pll_p,
 			MUX_SEL_APOLLO0, 0, 1, CLK_SET_RATE_PARENT, 0),
@@ -3519,7 +3519,7 @@ static struct samsung_mux_clock apollo_mux_clks[] __initdata = {
 			0, 1, CLK_SET_RATE_PARENT, 0),
 };
 
-static struct samsung_div_clock apollo_div_clks[] __initdata = {
+static const struct samsung_div_clock apollo_div_clks[] __initconst = {
 	/* DIV_APOLLO0 */
 	DIV_F(CLK_DIV_CNTCLK_APOLLO, "div_cntclk_apollo", "div_apollo2",
 			DIV_APOLLO0, 24, 3, CLK_GET_RATE_NOCACHE,
@@ -3550,7 +3550,7 @@ static struct samsung_div_clock apollo_div_clks[] __initdata = {
 			CLK_DIVIDER_READ_ONLY),
 };
 
-static struct samsung_gate_clock apollo_gate_clks[] __initdata = {
+static const struct samsung_gate_clock apollo_gate_clks[] __initconst = {
 	/* ENABLE_ACLK_APOLLO */
 	GATE(CLK_ACLK_ASATBSLV_APOLLO_3_CSSYS, "aclk_asatbslv_apollo_3_cssys",
 			"div_atclk_apollo", ENABLE_ACLK_APOLLO,
@@ -3594,7 +3594,7 @@ static struct samsung_gate_clock apollo_gate_clks[] __initdata = {
 			CLK_IGNORE_UNUSED | CLK_SET_RATE_PARENT, 0),
 };
 
-static struct samsung_cmu_info apollo_cmu_info __initdata = {
+static const struct samsung_cmu_info apollo_cmu_info __initconst = {
 	.pll_clks		= apollo_pll_clks,
 	.nr_pll_clks		= ARRAY_SIZE(apollo_pll_clks),
 	.mux_clks		= apollo_mux_clks,
@@ -3651,7 +3651,7 @@ CLK_OF_DECLARE(exynos5433_cmu_apollo, "samsung,exynos5433-cmu-apollo",
 #define ATLAS_INTR_SPREAD_USE_STANDBYWFI	0x1084
 #define ATLAS_INTR_SPREAD_BLOCKING_DURATION	0x1088
 
-static unsigned long atlas_clk_regs[] __initdata = {
+static const unsigned long atlas_clk_regs[] __initconst = {
 	ATLAS_PLL_LOCK,
 	ATLAS_PLL_CON0,
 	ATLAS_PLL_CON1,
@@ -3686,12 +3686,12 @@ PNAME(mout_bus_pll_atlas_user_p)	= { "oscclk", "sclk_bus_pll_atlas", };
 PNAME(mout_atlas_p)			= { "mout_atlas_pll",
 					    "mout_bus_pll_atlas_user", };
 
-static struct samsung_pll_clock atlas_pll_clks[] __initdata = {
+static const struct samsung_pll_clock atlas_pll_clks[] __initconst = {
 	PLL(pll_35xx, CLK_FOUT_ATLAS_PLL, "fout_atlas_pll", "oscclk",
 		ATLAS_PLL_LOCK, ATLAS_PLL_CON0, exynos5443_pll_rates),
 };
 
-static struct samsung_mux_clock atlas_mux_clks[] __initdata = {
+static const struct samsung_mux_clock atlas_mux_clks[] __initconst = {
 	/* MUX_SEL_ATLAS0 */
 	MUX_F(CLK_MOUT_ATLAS_PLL, "mout_atlas_pll", mout_atlas_pll_p,
 			MUX_SEL_ATLAS0, 0, 1, CLK_SET_RATE_PARENT, 0),
@@ -3705,7 +3705,7 @@ static struct samsung_mux_clock atlas_mux_clks[] __initdata = {
 			0, 1, CLK_SET_RATE_PARENT, 0),
 };
 
-static struct samsung_div_clock atlas_div_clks[] __initdata = {
+static const struct samsung_div_clock atlas_div_clks[] __initconst = {
 	/* DIV_ATLAS0 */
 	DIV_F(CLK_DIV_CNTCLK_ATLAS, "div_cntclk_atlas", "div_atlas2",
 			DIV_ATLAS0, 24, 3, CLK_GET_RATE_NOCACHE,
@@ -3736,7 +3736,7 @@ static struct samsung_div_clock atlas_div_clks[] __initdata = {
 			CLK_DIVIDER_READ_ONLY),
 };
 
-static struct samsung_gate_clock atlas_gate_clks[] __initdata = {
+static const struct samsung_gate_clock atlas_gate_clks[] __initconst = {
 	/* ENABLE_ACLK_ATLAS */
 	GATE(CLK_ACLK_ATB_AUD_CSSYS, "aclk_atb_aud_cssys",
 			"div_atclk_atlas", ENABLE_ACLK_ATLAS,
@@ -3806,7 +3806,7 @@ static struct samsung_gate_clock atlas_gate_clks[] __initdata = {
 			CLK_IGNORE_UNUSED | CLK_SET_RATE_PARENT, 0),
 };
 
-static struct samsung_cmu_info atlas_cmu_info __initdata = {
+static const struct samsung_cmu_info atlas_cmu_info __initconst = {
 	.pll_clks		= atlas_pll_clks,
 	.nr_pll_clks		= ARRAY_SIZE(atlas_pll_clks),
 	.mux_clks		= atlas_mux_clks,
@@ -3853,7 +3853,7 @@ CLK_OF_DECLARE(exynos5433_cmu_atlas, "samsung,exynos5433-cmu-atlas",
 #define ENABLE_IP_MSCL_SECURE_SMMU_M2MSCALER1		0x0b0c
 #define ENABLE_IP_MSCL_SECURE_SMMU_JPEG			0x0b10
 
-static unsigned long mscl_clk_regs[] __initdata = {
+static const unsigned long mscl_clk_regs[] __initconst = {
 	MUX_SEL_MSCL0,
 	MUX_SEL_MSCL1,
 	MUX_ENABLE_MSCL0,
@@ -3881,7 +3881,7 @@ PNAME(mout_aclk_mscl_400_user_p)	= { "oscclk", "aclk_mscl_400", };
 PNAME(mout_sclk_jpeg_p)			= { "mout_sclk_jpeg_user",
 					"mout_aclk_mscl_400_user", };
 
-static struct samsung_mux_clock mscl_mux_clks[] __initdata = {
+static const struct samsung_mux_clock mscl_mux_clks[] __initconst = {
 	/* MUX_SEL_MSCL0 */
 	MUX(CLK_MOUT_SCLK_JPEG_USER, "mout_sclk_jpeg_user",
 			mout_sclk_jpeg_user_p, MUX_SEL_MSCL0, 4, 1),
@@ -3893,13 +3893,13 @@ static struct samsung_mux_clock mscl_mux_clks[] __initdata = {
 			MUX_SEL_MSCL1, 0, 1),
 };
 
-static struct samsung_div_clock mscl_div_clks[] __initdata = {
+static const struct samsung_div_clock mscl_div_clks[] __initconst = {
 	/* DIV_MSCL */
 	DIV(CLK_DIV_PCLK_MSCL, "div_pclk_mscl", "mout_aclk_mscl_400_user",
 			DIV_MSCL, 0, 3),
 };
 
-static struct samsung_gate_clock mscl_gate_clks[] __initdata = {
+static const struct samsung_gate_clock mscl_gate_clks[] __initconst = {
 	/* ENABLE_ACLK_MSCL */
 	GATE(CLK_ACLK_BTS_JPEG, "aclk_bts_jpeg", "mout_aclk_mscl_400_user",
 			ENABLE_ACLK_MSCL, 9, 0, 0),
@@ -3977,7 +3977,7 @@ static struct samsung_gate_clock mscl_gate_clks[] __initdata = {
 			CLK_IGNORE_UNUSED | CLK_SET_RATE_PARENT, 0),
 };
 
-static struct samsung_cmu_info mscl_cmu_info __initdata = {
+static const struct samsung_cmu_info mscl_cmu_info __initconst = {
 	.mux_clks		= mscl_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(mscl_mux_clks),
 	.div_clks		= mscl_div_clks,
@@ -4012,7 +4012,7 @@ CLK_OF_DECLARE(exynos5433_cmu_mscl, "samsung,exynos5433-cmu-mscl",
 #define ENABLE_IP_MFC1				0x0b04
 #define ENABLE_IP_MFC_SECURE_SMMU_MFC		0x0b08
 
-static unsigned long mfc_clk_regs[] __initdata = {
+static const unsigned long mfc_clk_regs[] __initconst = {
 	MUX_SEL_MFC,
 	MUX_ENABLE_MFC,
 	DIV_MFC,
@@ -4027,19 +4027,19 @@ static unsigned long mfc_clk_regs[] __initdata = {
 
 PNAME(mout_aclk_mfc_400_user_p)		= { "oscclk", "aclk_mfc_400", };
 
-static struct samsung_mux_clock mfc_mux_clks[] __initdata = {
+static const struct samsung_mux_clock mfc_mux_clks[] __initconst = {
 	/* MUX_SEL_MFC */
 	MUX(CLK_MOUT_ACLK_MFC_400_USER, "mout_aclk_mfc_400_user",
 			mout_aclk_mfc_400_user_p, MUX_SEL_MFC, 0, 0),
 };
 
-static struct samsung_div_clock mfc_div_clks[] __initdata = {
+static const struct samsung_div_clock mfc_div_clks[] __initconst = {
 	/* DIV_MFC */
 	DIV(CLK_DIV_PCLK_MFC, "div_pclk_mfc", "mout_aclk_mfc_400_user",
 			DIV_MFC, 0, 2),
 };
 
-static struct samsung_gate_clock mfc_gate_clks[] __initdata = {
+static const struct samsung_gate_clock mfc_gate_clks[] __initconst = {
 	/* ENABLE_ACLK_MFC */
 	GATE(CLK_ACLK_BTS_MFC_1, "aclk_bts_mfc_1", "mout_aclk_mfc_400_user",
 			ENABLE_ACLK_MFC, 6, 0, 0),
@@ -4085,7 +4085,7 @@ static struct samsung_gate_clock mfc_gate_clks[] __initdata = {
 			0, CLK_IGNORE_UNUSED, 0),
 };
 
-static struct samsung_cmu_info mfc_cmu_info __initdata = {
+static const struct samsung_cmu_info mfc_cmu_info __initconst = {
 	.mux_clks		= mfc_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(mfc_mux_clks),
 	.div_clks		= mfc_div_clks,
@@ -4120,7 +4120,7 @@ CLK_OF_DECLARE(exynos5433_cmu_mfc, "samsung,exynos5433-cmu-mfc",
 #define ENABLE_IP_HEVC1				0x0b04
 #define ENABLE_IP_HEVC_SECURE_SMMU_HEVC		0x0b08
 
-static unsigned long hevc_clk_regs[] __initdata = {
+static const unsigned long hevc_clk_regs[] __initconst = {
 	MUX_SEL_HEVC,
 	MUX_ENABLE_HEVC,
 	DIV_HEVC,
@@ -4135,19 +4135,19 @@ static unsigned long hevc_clk_regs[] __initdata = {
 
 PNAME(mout_aclk_hevc_400_user_p)	= { "oscclk", "aclk_hevc_400", };
 
-static struct samsung_mux_clock hevc_mux_clks[] __initdata = {
+static const struct samsung_mux_clock hevc_mux_clks[] __initconst = {
 	/* MUX_SEL_HEVC */
 	MUX(CLK_MOUT_ACLK_HEVC_400_USER, "mout_aclk_hevc_400_user",
 			mout_aclk_hevc_400_user_p, MUX_SEL_HEVC, 0, 0),
 };
 
-static struct samsung_div_clock hevc_div_clks[] __initdata = {
+static const struct samsung_div_clock hevc_div_clks[] __initconst = {
 	/* DIV_HEVC */
 	DIV(CLK_DIV_PCLK_HEVC, "div_pclk_hevc", "mout_aclk_hevc_400_user",
 			DIV_HEVC, 0, 2),
 };
 
-static struct samsung_gate_clock hevc_gate_clks[] __initdata = {
+static const struct samsung_gate_clock hevc_gate_clks[] __initconst = {
 	/* ENABLE_ACLK_HEVC */
 	GATE(CLK_ACLK_BTS_HEVC_1, "aclk_bts_hevc_1", "mout_aclk_hevc_400_user",
 			ENABLE_ACLK_HEVC, 6, 0, 0),
@@ -4195,7 +4195,7 @@ static struct samsung_gate_clock hevc_gate_clks[] __initdata = {
 			0, CLK_IGNORE_UNUSED, 0),
 };
 
-static struct samsung_cmu_info hevc_cmu_info __initdata = {
+static const struct samsung_cmu_info hevc_cmu_info __initconst = {
 	.mux_clks		= hevc_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(hevc_mux_clks),
 	.div_clks		= hevc_div_clks,
@@ -4232,7 +4232,7 @@ CLK_OF_DECLARE(exynos5433_cmu_hevc, "samsung,exynos5433-cmu-hevc",
 #define ENABLE_IP_ISP2			0x0b08
 #define ENABLE_IP_ISP3			0x0b0c
 
-static unsigned long isp_clk_regs[] __initdata = {
+static const unsigned long isp_clk_regs[] __initconst = {
 	MUX_SEL_ISP,
 	MUX_ENABLE_ISP,
 	DIV_ISP,
@@ -4250,7 +4250,7 @@ static unsigned long isp_clk_regs[] __initdata = {
 PNAME(mout_aclk_isp_dis_400_user_p)	= { "oscclk", "aclk_isp_dis_400", };
 PNAME(mout_aclk_isp_400_user_p)		= { "oscclk", "aclk_isp_400", };
 
-static struct samsung_mux_clock isp_mux_clks[] __initdata = {
+static const struct samsung_mux_clock isp_mux_clks[] __initconst = {
 	/* MUX_SEL_ISP */
 	MUX(CLK_MOUT_ACLK_ISP_DIS_400_USER, "mout_aclk_isp_dis_400_user",
 			mout_aclk_isp_dis_400_user_p, MUX_SEL_ISP, 4, 0),
@@ -4258,7 +4258,7 @@ static struct samsung_mux_clock isp_mux_clks[] __initdata = {
 			mout_aclk_isp_400_user_p, MUX_SEL_ISP, 0, 0),
 };
 
-static struct samsung_div_clock isp_div_clks[] __initdata = {
+static const struct samsung_div_clock isp_div_clks[] __initconst = {
 	/* DIV_ISP */
 	DIV(CLK_DIV_PCLK_ISP_DIS, "div_pclk_isp_dis",
 			"mout_aclk_isp_dis_400_user", DIV_ISP, 12, 3),
@@ -4270,7 +4270,7 @@ static struct samsung_div_clock isp_div_clks[] __initdata = {
 			"mout_aclk_isp_400_user", DIV_ISP, 0, 3),
 };
 
-static struct samsung_gate_clock isp_gate_clks[] __initdata = {
+static const struct samsung_gate_clock isp_gate_clks[] __initconst = {
 	/* ENABLE_ACLK_ISP0 */
 	GATE(CLK_ACLK_ISP_D_GLUE, "aclk_isp_d_glue", "mout_aclk_isp_400_user",
 			ENABLE_ACLK_ISP0, 6, CLK_IGNORE_UNUSED, 0),
@@ -4448,7 +4448,7 @@ static struct samsung_gate_clock isp_gate_clks[] __initdata = {
 			0, CLK_IGNORE_UNUSED, 0),
 };
 
-static struct samsung_cmu_info isp_cmu_info __initdata = {
+static const struct samsung_cmu_info isp_cmu_info __initconst = {
 	.mux_clks		= isp_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(isp_mux_clks),
 	.div_clks		= isp_div_clks,
@@ -4504,7 +4504,7 @@ CLK_OF_DECLARE(exynos5433_cmu_isp, "samsung,exynos5433-cmu-isp",
 #define ENABLE_IP_CAM02			0X0b08
 #define ENABLE_IP_CAM03			0X0b0C
 
-static unsigned long cam0_clk_regs[] __initdata = {
+static const unsigned long cam0_clk_regs[] __initconst = {
 	MUX_SEL_CAM00,
 	MUX_SEL_CAM01,
 	MUX_SEL_CAM02,
@@ -4588,14 +4588,14 @@ PNAME(mout_sclk_pixelasync_lite_c_init_a_p) = {
 					"mout_aclk_cam0_552_user",
 					"mout_aclk_cam0_400_user", };
 
-static struct samsung_fixed_rate_clock cam0_fixed_clks[] __initdata = {
+static const struct samsung_fixed_rate_clock cam0_fixed_clks[] __initconst = {
 	FRATE(CLK_PHYCLK_RXBYTEECLKHS0_S4_PHY, "phyclk_rxbyteclkhs0_s4_phy",
 			NULL, 0, 100000000),
 	FRATE(CLK_PHYCLK_RXBYTEECLKHS0_S2A_PHY, "phyclk_rxbyteclkhs0_s2a_phy",
 			NULL, 0, 100000000),
 };
 
-static struct samsung_mux_clock cam0_mux_clks[] __initdata = {
+static const struct samsung_mux_clock cam0_mux_clks[] __initconst = {
 	/* MUX_SEL_CAM00 */
 	MUX(CLK_MOUT_ACLK_CAM0_333_USER, "mout_aclk_cam0_333_user",
 			mout_aclk_cam0_333_user_p, MUX_SEL_CAM00, 8, 1),
@@ -4669,7 +4669,7 @@ static struct samsung_mux_clock cam0_mux_clks[] __initdata = {
 			MUX_SEL_CAM04, 0, 1),
 };
 
-static struct samsung_div_clock cam0_div_clks[] __initdata = {
+static const struct samsung_div_clock cam0_div_clks[] __initconst = {
 	/* DIV_CAM00 */
 	DIV(CLK_DIV_PCLK_CAM0_50, "div_pclk_cam0_50", "div_aclk_cam0_200",
 			DIV_CAM00, 8, 2),
@@ -4716,7 +4716,7 @@ static struct samsung_div_clock cam0_div_clks[] __initdata = {
 			"mout_sclk_pixelasync_lite_c_init_b", DIV_CAM03, 0, 3),
 };
 
-static struct samsung_gate_clock cam0_gate_clks[] __initdata = {
+static const struct samsung_gate_clock cam0_gate_clks[] __initconst = {
 	/* ENABLE_ACLK_CAM00 */
 	GATE(CLK_ACLK_CSIS1, "aclk_csis1", "div_aclk_csis1", ENABLE_ACLK_CAM00,
 			6, 0, 0),
@@ -4923,7 +4923,7 @@ static struct samsung_gate_clock cam0_gate_clks[] __initdata = {
 			ENABLE_SCLK_CAM0, 0, 0, 0),
 };
 
-static struct samsung_cmu_info cam0_cmu_info __initdata = {
+static const struct samsung_cmu_info cam0_cmu_info __initconst = {
 	.mux_clks		= cam0_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(cam0_mux_clks),
 	.div_clks		= cam0_div_clks,
@@ -4970,7 +4970,7 @@ CLK_OF_DECLARE(exynos5433_cmu_cam0, "samsung,exynos5433-cmu-cam0",
 #define ENABLE_IP_CAM11			0X0b04
 #define ENABLE_IP_CAM12			0X0b08
 
-static unsigned long cam1_clk_regs[] __initdata = {
+static const unsigned long cam1_clk_regs[] __initconst = {
 	MUX_SEL_CAM10,
 	MUX_SEL_CAM11,
 	MUX_SEL_CAM12,
@@ -5016,12 +5016,12 @@ PNAME(mout_aclk_lite_c_b_p)		= { "mout_aclk_lite_c_a",
 PNAME(mout_aclk_lite_c_a_p)		= { "mout_aclk_cam1_552_user",
 					    "mout_aclk_cam1_400_user", };
 
-static struct samsung_fixed_rate_clock cam1_fixed_clks[] __initdata = {
+static const struct samsung_fixed_rate_clock cam1_fixed_clks[] __initconst = {
 	FRATE(CLK_PHYCLK_RXBYTEECLKHS0_S2B, "phyclk_rxbyteclkhs0_s2b_phy", NULL,
 			0, 100000000),
 };
 
-static struct samsung_mux_clock cam1_mux_clks[] __initdata = {
+static const struct samsung_mux_clock cam1_mux_clks[] __initconst = {
 	/* MUX_SEL_CAM10 */
 	MUX(CLK_MOUT_SCLK_ISP_UART_USER, "mout_sclk_isp_uart_user",
 			mout_sclk_isp_uart_user_p, MUX_SEL_CAM10, 20, 1),
@@ -5057,7 +5057,7 @@ static struct samsung_mux_clock cam1_mux_clks[] __initdata = {
 			MUX_SEL_CAM12, 0, 1),
 };
 
-static struct samsung_div_clock cam1_div_clks[] __initdata = {
+static const struct samsung_div_clock cam1_div_clks[] __initconst = {
 	/* DIV_CAM10 */
 	DIV(CLK_DIV_SCLK_ISP_MPWM, "div_sclk_isp_mpwm",
 			"div_pclk_cam1_83", DIV_CAM10, 16, 2),
@@ -5081,7 +5081,7 @@ static struct samsung_div_clock cam1_div_clks[] __initdata = {
 			DIV_CAM11, 0, 3),
 };
 
-static struct samsung_gate_clock cam1_gate_clks[] __initdata = {
+static const struct samsung_gate_clock cam1_gate_clks[] __initconst = {
 	/* ENABLE_ACLK_CAM10 */
 	GATE(CLK_ACLK_ISP_GIC, "aclk_isp_gic", "mout_aclk_cam1_333_user",
 			ENABLE_ACLK_CAM10, 4, 0, 0),
@@ -5296,7 +5296,7 @@ static struct samsung_gate_clock cam1_gate_clks[] __initdata = {
 			ENABLE_SCLK_CAM1, 0, 0, 0),
 };
 
-static struct samsung_cmu_info cam1_cmu_info __initdata = {
+static const struct samsung_cmu_info cam1_cmu_info __initconst = {
 	.mux_clks		= cam1_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(cam1_mux_clks),
 	.div_clks		= cam1_div_clks,
-- 
1.9.1
