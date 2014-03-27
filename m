From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Thu, 27 Mar 2014 16:37:47 +0530
Subject: [PATCH v2 4/7] clk: exynos5420: Rename clock names
In-Reply-To: <1395918470-16374-1-git-send-email-shaik.ameer@samsung.com>
References: <1395918470-16374-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1395918470-16374-5-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <rahul.sharma@samsung.com>

Maintain the mout_, dout_, sclk_ prefix to the clock names
wherever applicable.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c   |  750 ++++++++++++++++++--------------
 include/dt-bindings/clock/exynos5420.h |   14 +-
 2 files changed, 419 insertions(+), 345 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 1402554..793fb3d 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -244,85 +244,92 @@ static void exynos5420_clk_sleep_init(void) {}
 #endif
 
 /* list of all parent clocks */
-PNAME(mspll_cpu_p)	= { "sclk_cpll", "sclk_dpll",
-				"sclk_mpll", "sclk_spll" };
-PNAME(cpu_p)		= { "mout_apll" , "mout_mspll_cpu" };
-PNAME(kfc_p)		= { "mout_kpll" , "mout_mspll_kfc" };
-PNAME(apll_p)		= { "fin_pll", "fout_apll", };
-PNAME(bpll_p)		= { "fin_pll", "fout_bpll", };
-PNAME(cpll_p)		= { "fin_pll", "fout_cpll", };
-PNAME(dpll_p)		= { "fin_pll", "fout_dpll", };
-PNAME(epll_p)		= { "fin_pll", "fout_epll", };
-PNAME(ipll_p)		= { "fin_pll", "fout_ipll", };
-PNAME(kpll_p)		= { "fin_pll", "fout_kpll", };
-PNAME(mpll_p)		= { "fin_pll", "fout_mpll", };
-PNAME(rpll_p)		= { "fin_pll", "fout_rpll", };
-PNAME(spll_p)		= { "fin_pll", "fout_spll", };
-PNAME(vpll_p)		= { "fin_pll", "fout_vpll", };
-
-PNAME(group1_p)		= { "sclk_cpll", "sclk_dpll", "sclk_mpll" };
-PNAME(group2_p)		= { "fin_pll", "sclk_cpll", "sclk_dpll", "sclk_mpll",
-			  "sclk_spll", "sclk_ipll", "sclk_epll", "sclk_rpll" };
-PNAME(group3_p)		= { "sclk_rpll", "sclk_spll" };
-PNAME(group4_p)		= { "sclk_ipll", "sclk_dpll", "sclk_mpll" };
-PNAME(group5_p)		= { "sclk_vpll", "sclk_dpll" };
-
-PNAME(sw_aclk66_p)	= { "dout_aclk66", "sclk_spll" };
-PNAME(aclk66_peric_p)	= { "fin_pll", "mout_sw_aclk66" };
-
-PNAME(sw_aclk200_fsys_p) = { "dout_aclk200_fsys", "sclk_spll"};
-PNAME(user_aclk200_fsys_p)	= { "fin_pll", "mout_sw_aclk200_fsys" };
-
-PNAME(sw_aclk200_fsys2_p) = { "dout_aclk200_fsys2", "sclk_spll"};
-PNAME(user_aclk200_fsys2_p)	= { "fin_pll", "mout_sw_aclk200_fsys2" };
-
-PNAME(sw_aclk200_p) = { "dout_aclk200", "sclk_spll"};
-PNAME(aclk200_disp1_p)	= { "fin_pll", "mout_sw_aclk200" };
-
-PNAME(sw_aclk400_mscl_p) = { "dout_aclk400_mscl", "sclk_spll"};
-PNAME(user_aclk400_mscl_p)	= { "fin_pll", "mout_sw_aclk400_mscl" };
-
-PNAME(sw_aclk333_p) = { "dout_aclk333", "sclk_spll"};
-PNAME(user_aclk333_p)	= { "fin_pll", "mout_sw_aclk333" };
-
-PNAME(sw_aclk166_p) = { "dout_aclk166", "sclk_spll"};
-PNAME(user_aclk166_p)	= { "fin_pll", "mout_sw_aclk166" };
-
-PNAME(sw_aclk266_p) = { "dout_aclk266", "sclk_spll"};
-PNAME(user_aclk266_p)	= { "fin_pll", "mout_sw_aclk266" };
-
-PNAME(sw_aclk333_432_gscl_p) = { "dout_aclk333_432_gscl", "sclk_spll"};
-PNAME(user_aclk333_432_gscl_p)	= { "fin_pll", "mout_sw_aclk333_432_gscl" };
-
-PNAME(sw_aclk300_gscl_p) = { "dout_aclk300_gscl", "sclk_spll"};
-PNAME(user_aclk300_gscl_p)	= { "fin_pll", "mout_sw_aclk300_gscl" };
-
-PNAME(sw_aclk300_disp1_p) = { "dout_aclk300_disp1", "sclk_spll"};
-PNAME(user_aclk300_disp1_p)	= { "fin_pll", "mout_sw_aclk300_disp1" };
-
-PNAME(sw_aclk300_jpeg_p) = { "dout_aclk300_jpeg", "sclk_spll"};
-PNAME(user_aclk300_jpeg_p)	= { "fin_pll", "mout_sw_aclk300_jpeg" };
-
-PNAME(sw_aclk_g3d_p) = { "dout_aclk_g3d", "sclk_spll"};
-PNAME(user_aclk_g3d_p)	= { "fin_pll", "mout_sw_aclk_g3d" };
-
-PNAME(sw_aclk266_g2d_p) = { "dout_aclk266_g2d", "sclk_spll"};
-PNAME(user_aclk266_g2d_p)	= { "fin_pll", "mout_sw_aclk266_g2d" };
-
-PNAME(sw_aclk333_g2d_p) = { "dout_aclk333_g2d", "sclk_spll"};
-PNAME(user_aclk333_g2d_p)	= { "fin_pll", "mout_sw_aclk333_g2d" };
-
-PNAME(audio0_p)	= { "fin_pll", "cdclk0", "sclk_dpll", "sclk_mpll",
-		  "sclk_spll", "sclk_ipll", "sclk_epll", "sclk_rpll" };
-PNAME(audio1_p)	= { "fin_pll", "cdclk1", "sclk_dpll", "sclk_mpll",
-		  "sclk_spll", "sclk_ipll", "sclk_epll", "sclk_rpll" };
-PNAME(audio2_p)	= { "fin_pll", "cdclk2", "sclk_dpll", "sclk_mpll",
-		  "sclk_spll", "sclk_ipll", "sclk_epll", "sclk_rpll" };
-PNAME(spdif_p)	= { "fin_pll", "dout_audio0", "dout_audio1", "dout_audio2",
-		  "spdif_extclk", "sclk_ipll", "sclk_epll", "sclk_rpll" };
-PNAME(hdmi_p)	= { "dout_hdmi_pixel", "sclk_hdmiphy" };
-PNAME(maudio0_p)	= { "fin_pll", "maudio_clk", "sclk_dpll", "sclk_mpll",
-			  "sclk_spll", "sclk_ipll", "sclk_epll", "sclk_rpll" };
+PNAME(mout_mspll_cpu_p) = {"mout_sclk_cpll", "mout_sclk_dpll",
+				"mout_sclk_mpll", "mout_sclk_spll"};
+PNAME(mout_cpu_p) = {"mout_apll" , "mout_mspll_cpu"};
+PNAME(mout_kfc_p) = {"mout_kpll" , "mout_mspll_kfc"};
+PNAME(mout_apll_p) = {"fin_pll", "fout_apll"};
+PNAME(mout_bpll_p) = {"fin_pll", "fout_bpll"};
+PNAME(mout_cpll_p) = {"fin_pll", "fout_cpll"};
+PNAME(mout_dpll_p) = {"fin_pll", "fout_dpll"};
+PNAME(mout_epll_p) = {"fin_pll", "fout_epll"};
+PNAME(mout_ipll_p) = {"fin_pll", "fout_ipll"};
+PNAME(mout_kpll_p) = {"fin_pll", "fout_kpll"};
+PNAME(mout_mpll_p) = {"fin_pll", "fout_mpll"};
+PNAME(mout_rpll_p) = {"fin_pll", "fout_rpll"};
+PNAME(mout_spll_p) = {"fin_pll", "fout_spll"};
+PNAME(mout_vpll_p) = {"fin_pll", "fout_vpll"};
+
+PNAME(mout_group1_p) = {"mout_sclk_cpll", "mout_sclk_dpll",
+					"mout_sclk_mpll"};
+PNAME(mout_group2_p) = {"fin_pll", "mout_sclk_cpll",
+			"mout_sclk_dpll", "mout_sclk_mpll", "mout_sclk_spll",
+			"mout_sclk_ipll", "mout_sclk_epll", "mout_sclk_rpll"};
+PNAME(mout_group3_p) = {"mout_sclk_rpll", "mout_sclk_spll"};
+PNAME(mout_group4_p) = {"mout_sclk_ipll", "mout_sclk_dpll", "mout_sclk_mpll"};
+PNAME(mout_group5_p) = {"mout_sclk_vpll", "mout_sclk_dpll"};
+
+PNAME(mout_sw_aclk66_p)	= {"dout_aclk66", "mout_sclk_spll"};
+PNAME(mout_user_aclk66_peric_p) = {"fin_pll", "mout_sw_aclk66"};
+
+PNAME(mout_sw_aclk200_fsys_p) = {"dout_aclk200_fsys", "mout_sclk_spll"};
+PNAME(mout_user_aclk200_fsys_p)	= {"fin_pll", "mout_sw_aclk200_fsys"};
+
+PNAME(mout_sw_aclk200_fsys2_p) = {"dout_aclk200_fsys2", "mout_sclk_spll"};
+PNAME(mout_user_aclk200_fsys2_p) = {"fin_pll", "mout_sw_aclk200_fsys2"};
+
+PNAME(mout_sw_aclk200_p) = {"dout_aclk200", "mout_sclk_spll"};
+PNAME(mout_aclk200_disp1_p) = {"fin_pll", "mout_sw_aclk200"};
+
+PNAME(mout_sw_aclk400_mscl_p) = {"dout_aclk400_mscl", "mout_sclk_spll"};
+PNAME(mout_user_aclk400_mscl_p)	= {"fin_pll", "mout_sw_aclk400_mscl"};
+
+PNAME(mout_sw_aclk333_p) = {"dout_aclk333", "mout_sclk_spll"};
+PNAME(mout_user_aclk333_p) = {"fin_pll", "mout_sw_aclk333"};
+
+PNAME(mout_sw_aclk166_p) = {"dout_aclk166", "mout_sclk_spll"};
+PNAME(mout_user_aclk166_p) = {"fin_pll", "mout_sw_aclk166"};
+
+PNAME(mout_sw_aclk266_p) = {"dout_aclk266", "mout_sclk_spll"};
+PNAME(mout_user_aclk266_p) = {"fin_pll", "mout_sw_aclk266"};
+
+PNAME(mout_sw_aclk333_432_gscl_p) = {"dout_aclk333_432_gscl", "mout_sclk_spll"};
+PNAME(mout_user_aclk333_432_gscl_p) = {"fin_pll", "mout_sw_aclk333_432_gscl"};
+
+PNAME(mout_sw_aclk300_gscl_p) = {"dout_aclk300_gscl", "mout_sclk_spll"};
+PNAME(mout_user_aclk300_gscl_p)	= {"fin_pll", "mout_sw_aclk300_gscl"};
+
+PNAME(mout_sw_aclk300_disp1_p) = {"dout_aclk300_disp1", "mout_sclk_spll"};
+PNAME(mout_user_aclk300_disp1_p) = {"fin_pll", "mout_sw_aclk300_disp1"};
+
+PNAME(mout_sw_aclk300_jpeg_p) = {"dout_aclk300_jpeg", "mout_sclk_spll"};
+PNAME(mout_user_aclk300_jpeg_p) = {"fin_pll", "mout_sw_aclk300_jpeg"};
+
+PNAME(mout_sw_aclk_g3d_p) = {"dout_aclk_g3d", "mout_sclk_spll"};
+PNAME(mout_user_aclk_g3d_p) = {"fin_pll", "mout_sw_aclk_g3d"};
+
+PNAME(mout_sw_aclk266_g2d_p) = {"dout_aclk266_g2d", "mout_sclk_spll"};
+PNAME(mout_user_aclk266_g2d_p) = {"fin_pll", "mout_sw_aclk266_g2d"};
+
+PNAME(mout_sw_aclk333_g2d_p) = {"dout_aclk333_g2d", "mout_sclk_spll"};
+PNAME(mout_user_aclk333_g2d_p) = {"fin_pll", "mout_sw_aclk333_g2d"};
+
+PNAME(mout_audio0_p) = {"fin_pll", "cdclk0", "mout_sclk_dpll",
+			"mout_sclk_mpll", "mout_sclk_spll", "mout_sclk_ipll",
+			"mout_sclk_epll", "mout_sclk_rpll"};
+PNAME(mout_audio1_p) = {"fin_pll", "cdclk1", "mout_sclk_dpll",
+			"mout_sclk_mpll", "mout_sclk_spll", "mout_sclk_ipll",
+			"mout_sclk_epll", "mout_sclk_rpll"};
+PNAME(mout_audio2_p) = {"fin_pll", "cdclk2", "mout_sclk_dpll",
+			"mout_sclk_mpll", "mout_sclk_spll", "mout_sclk_ipll",
+			"mout_sclk_epll", "mout_sclk_rpll"};
+PNAME(mout_spdif_p) = {"fin_pll", "dout_audio0", "dout_audio1",
+			"dout_audio2", "spdif_extclk", "mout_sclk_ipll",
+			"mout_sclk_epll", "mout_sclk_rpll"};
+PNAME(mout_hdmi_p) = {"dout_hdmi_pixel", "sclk_hdmiphy"};
+PNAME(mout_maudio0_p) = {"fin_pll", "maudio_clk", "mout_sclk_dpll",
+			 "mout_sclk_mpll", "mout_sclk_spll", "mout_sclk_ipll",
+			 "mout_sclk_epll", "mout_sclk_rpll"};
 
 /* fixed rate clocks generated outside the soc */
 static struct samsung_fixed_rate_clock exynos5420_fixed_rate_ext_clks[] __initdata = {
@@ -339,134 +346,145 @@ static struct samsung_fixed_rate_clock exynos5420_fixed_rate_clks[] __initdata =
 };
 
 static struct samsung_fixed_factor_clock exynos5420_fixed_factor_clks[] __initdata = {
-	FFACTOR(0, "sclk_hsic_12m", "fin_pll", 1, 2, 0),
+	FFACTOR(0, "ffactor_hsic_12m", "fin_pll", 1, 2, 0),
 };
 
 static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
-	MUX(0, "mout_mspll_kfc", mspll_cpu_p, SRC_TOP7, 8, 2),
-	MUX(0, "mout_mspll_cpu", mspll_cpu_p, SRC_TOP7, 12, 2),
-	MUX(0, "mout_apll", apll_p, SRC_CPU, 0, 1),
-	MUX(0, "mout_cpu", cpu_p, SRC_CPU, 16, 1),
-	MUX(0, "mout_kpll", kpll_p, SRC_KFC, 0, 1),
-	MUX(0, "mout_cpu_kfc", kfc_p, SRC_KFC, 16, 1),
+	MUX(0, "mout_mspll_kfc", mout_mspll_cpu_p, SRC_TOP7, 8, 2),
+	MUX(0, "mout_mspll_cpu", mout_mspll_cpu_p, SRC_TOP7, 12, 2),
+	MUX(0, "mout_apll", mout_apll_p, SRC_CPU, 0, 1),
+	MUX(0, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1),
+	MUX(0, "mout_kpll", mout_kpll_p, SRC_KFC, 0, 1),
+	MUX(0, "mout_kfc", mout_kfc_p, SRC_KFC, 16, 1),
 
-	MUX(0, "sclk_bpll", bpll_p, SRC_CDREX, 0, 1),
+	MUX(0, "sclk_bpll", mout_bpll_p, TOP_SPARE2, 0, 1),
 
-	MUX_A(0, "mout_aclk400_mscl", group1_p,
+	MUX_A(0, "mout_aclk400_mscl", mout_group1_p,
 			SRC_TOP0, 4, 2, "aclk400_mscl"),
-	MUX(0, "mout_aclk200", group1_p, SRC_TOP0, 8, 2),
-	MUX(0, "mout_aclk200_fsys2", group1_p, SRC_TOP0, 12, 2),
-	MUX(0, "mout_aclk200_fsys", group1_p, SRC_TOP0, 28, 2),
-
-	MUX(0, "mout_aclk333_432_gscl", group4_p, SRC_TOP1, 0, 2),
-	MUX(0, "mout_aclk66", group1_p, SRC_TOP1, 8, 2),
-	MUX(0, "mout_aclk266", group1_p, SRC_TOP1, 20, 2),
-	MUX(0, "mout_aclk166", group1_p, SRC_TOP1, 24, 2),
-	MUX(0, "mout_aclk333", group1_p, SRC_TOP1, 28, 2),
-
-	MUX(0, "mout_aclk333_g2d", group1_p, SRC_TOP2, 8, 2),
-	MUX(0, "mout_aclk266_g2d", group1_p, SRC_TOP2, 12, 2),
-	MUX(0, "mout_aclk_g3d", group5_p, SRC_TOP2, 16, 1),
-	MUX(0, "mout_aclk300_jpeg", group1_p, SRC_TOP2, 20, 2),
-	MUX(0, "mout_aclk300_disp1", group1_p, SRC_TOP2, 24, 2),
-	MUX(0, "mout_aclk300_gscl", group1_p, SRC_TOP2, 28, 2),
-
-	MUX(0, "mout_user_aclk400_mscl", user_aclk400_mscl_p,
+	MUX(0, "mout_aclk200", mout_group1_p, SRC_TOP0, 8, 2),
+	MUX(0, "mout_aclk200_fsys2", mout_group1_p, SRC_TOP0, 12, 2),
+	MUX(0, "mout_aclk200_fsys", mout_group1_p, SRC_TOP0, 28, 2),
+
+	MUX(0, "mout_aclk333_432_gscl", mout_group4_p, SRC_TOP1, 0, 2),
+	MUX(0, "mout_aclk66", mout_group1_p, SRC_TOP1, 8, 2),
+	MUX(0, "mout_aclk266", mout_group1_p, SRC_TOP1, 20, 2),
+	MUX(0, "mout_aclk166", mout_group1_p, SRC_TOP1, 24, 2),
+	MUX(0, "mout_aclk333", mout_group1_p, SRC_TOP1, 28, 2),
+
+	MUX(0, "mout_aclk333_g2d", mout_group1_p, SRC_TOP2, 8, 2),
+	MUX(0, "mout_aclk266_g2d", mout_group1_p, SRC_TOP2, 12, 2),
+	MUX(0, "mout_aclk_g3d", mout_group5_p, SRC_TOP2, 16, 1),
+	MUX(0, "mout_aclk300_jpeg", mout_group1_p, SRC_TOP2, 20, 2),
+	MUX(0, "mout_aclk300_disp1", mout_group1_p, SRC_TOP2, 24, 2),
+	MUX(0, "mout_aclk300_gscl", mout_group1_p, SRC_TOP2, 28, 2),
+
+	MUX(0, "mout_user_aclk400_mscl", mout_user_aclk400_mscl_p,
 			SRC_TOP3, 4, 1),
-	MUX_A(0, "mout_aclk200_disp1", aclk200_disp1_p,
-			SRC_TOP3, 8, 1, "aclk200_disp1"),
-	MUX(0, "mout_user_aclk200_fsys2", user_aclk200_fsys2_p,
+	MUX(0, "mout_aclk200_disp1", mout_aclk200_disp1_p, SRC_TOP3, 8, 1),
+	MUX(0, "mout_user_aclk200_fsys2", mout_user_aclk200_fsys2_p,
 			SRC_TOP3, 12, 1),
-	MUX(0, "mout_user_aclk200_fsys", user_aclk200_fsys_p,
+	MUX(0, "mout_user_aclk200_fsys", mout_user_aclk200_fsys_p,
 			SRC_TOP3, 28, 1),
 
-	MUX(0, "mout_user_aclk333_432_gscl", user_aclk333_432_gscl_p,
-			SRC_TOP4, 0, 1),
-	MUX(0, "mout_aclk66_peric", aclk66_peric_p, SRC_TOP4, 8, 1),
-	MUX(0, "mout_user_aclk266", user_aclk266_p, SRC_TOP4, 20, 1),
-	MUX(0, "mout_user_aclk166", user_aclk166_p, SRC_TOP4, 24, 1),
-	MUX(0, "mout_user_aclk333", user_aclk333_p, SRC_TOP4, 28, 1),
-
-	MUX(0, "mout_aclk66_psgen", aclk66_peric_p, SRC_TOP5, 4, 1),
-	MUX(0, "mout_user_aclk333_g2d", user_aclk333_g2d_p, SRC_TOP5, 8, 1),
-	MUX(0, "mout_user_aclk266_g2d", user_aclk266_g2d_p, SRC_TOP5, 12, 1),
-	MUX_A(0, "mout_user_aclk_g3d", user_aclk_g3d_p,
-			SRC_TOP5, 16, 1, "aclkg3d"),
-	MUX(0, "mout_user_aclk300_jpeg", user_aclk300_jpeg_p,
+	MUX(CLK_MOUT_USER_ACLK333_432_GSCL, "mout_user_aclk333_432_gscl",
+			mout_user_aclk333_432_gscl_p, SRC_TOP4, 0, 1),
+	MUX(0, "mout_user_aclk66_peric", mout_user_aclk66_peric_p,
+			SRC_TOP4, 8, 1),
+	MUX(0, "mout_user_aclk266", mout_user_aclk266_p, SRC_TOP4, 20, 1),
+	MUX(0, "mout_user_aclk166", mout_user_aclk166_p, SRC_TOP4, 24, 1),
+	MUX(CLK_MOUT_USER_ACLK333, "mout_user_aclk333", mout_user_aclk333_p,
+			SRC_TOP4, 28, 1),
+
+	MUX(0, "mout_user_aclk66_psgen", mout_user_aclk66_peric_p, SRC_TOP5,
+			4, 1),
+	MUX(0, "mout_user_aclk333_g2d", mout_user_aclk333_g2d_p, SRC_TOP5,
+			8, 1),
+	MUX(0, "mout_user_aclk266_g2d", mout_user_aclk266_g2d_p, SRC_TOP5,
+			12, 1),
+	MUX(CLK_MOUT_G3D, "mout_user_aclk_g3d", mout_user_aclk_g3d_p,
+			SRC_TOP5, 16, 1),
+	MUX(0, "mout_user_aclk300_jpeg", mout_user_aclk300_jpeg_p,
 			SRC_TOP5, 20, 1),
-	MUX(0, "mout_user_aclk300_disp1", user_aclk300_disp1_p,
+	MUX(0, "mout_user_aclk300_disp1", mout_user_aclk300_disp1_p,
 			SRC_TOP5, 24, 1),
-	MUX(0, "mout_user_aclk300_gscl", user_aclk300_gscl_p,
-			SRC_TOP5, 28, 1),
-
-	MUX(0, "sclk_mpll", mpll_p, SRC_TOP6, 0, 1),
-	MUX(0, "sclk_vpll", vpll_p, SRC_TOP6, 4, 1),
-	MUX(0, "sclk_spll", spll_p, SRC_TOP6, 8, 1),
-	MUX(0, "sclk_ipll", ipll_p, SRC_TOP6, 12, 1),
-	MUX(0, "sclk_rpll", rpll_p, SRC_TOP6, 16, 1),
-	MUX(0, "sclk_epll", epll_p, SRC_TOP6, 20, 1),
-	MUX(0, "sclk_dpll", dpll_p, SRC_TOP6, 24, 1),
-	MUX(0, "sclk_cpll", cpll_p, SRC_TOP6, 28, 1),
-
-	MUX(0, "mout_sw_aclk400_mscl", sw_aclk400_mscl_p, SRC_TOP10, 4, 1),
-	MUX(0, "mout_sw_aclk200", sw_aclk200_p, SRC_TOP10, 8, 1),
-	MUX(0, "mout_sw_aclk200_fsys2", sw_aclk200_fsys2_p,
+	MUX(CLK_MOUT_USER_ACLK300_GSCL, "mout_user_aclk300_gscl",
+			mout_user_aclk300_gscl_p, SRC_TOP5, 28, 1),
+
+	MUX(0, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1),
+	MUX(0, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1),
+	MUX(0, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
+	MUX(0, "mout_sclk_ipll", mout_ipll_p, SRC_TOP6, 12, 1),
+	MUX(0, "mout_sclk_rpll", mout_rpll_p, SRC_TOP6, 16, 1),
+	MUX(0, "mout_sclk_epll", mout_epll_p, SRC_TOP6, 20, 1),
+	MUX(0, "mout_sclk_dpll", mout_dpll_p, SRC_TOP6, 24, 1),
+	MUX(0, "mout_sclk_cpll", mout_cpll_p, SRC_TOP6, 28, 1),
+
+	MUX(0, "mout_sw_aclk400_mscl", mout_sw_aclk400_mscl_p,
+			SRC_TOP10, 4, 1),
+	MUX(0, "mout_sw_aclk200", mout_sw_aclk200_p, SRC_TOP10, 8, 1),
+	MUX(0, "mout_sw_aclk200_fsys2", mout_sw_aclk200_fsys2_p,
 			SRC_TOP10, 12, 1),
-	MUX(0, "mout_sw_aclk200_fsys", sw_aclk200_fsys_p, SRC_TOP10, 28, 1),
-
-	MUX(0, "mout_sw_aclk333_432_gscl", sw_aclk333_432_gscl_p,
-			SRC_TOP11, 0, 1),
-	MUX(0, "mout_sw_aclk66", sw_aclk66_p, SRC_TOP11, 8, 1),
-	MUX(0, "mout_sw_aclk266", sw_aclk266_p, SRC_TOP11, 20, 1),
-	MUX(0, "mout_sw_aclk166", sw_aclk166_p, SRC_TOP11, 24, 1),
-	MUX(0, "mout_sw_aclk333", sw_aclk333_p, SRC_TOP11, 28, 1),
-
-	MUX(0, "mout_sw_aclk333_g2d", sw_aclk333_g2d_p, SRC_TOP12, 8, 1),
-	MUX(0, "mout_sw_aclk266_g2d", sw_aclk266_g2d_p, SRC_TOP12, 12, 1),
-	MUX(0, "mout_sw_aclk_g3d", sw_aclk_g3d_p, SRC_TOP12, 16, 1),
-	MUX(0, "mout_sw_aclk300_jpeg", sw_aclk300_jpeg_p, SRC_TOP12, 20, 1),
-	MUX(0, "mout_sw_aclk300_disp1", sw_aclk300_disp1_p,
+	MUX(0, "mout_sw_aclk200_fsys", mout_sw_aclk200_fsys_p,
+			SRC_TOP10, 28, 1),
+	MUX(CLK_MOUT_SW_ACLK333_432_GSCL, "mout_sw_aclk333_432_gscl",
+			mout_sw_aclk333_432_gscl_p, SRC_TOP11, 0, 1),
+	MUX(0, "mout_sw_aclk66", mout_sw_aclk66_p, SRC_TOP11, 8, 1),
+	MUX(0, "mout_sw_aclk266", mout_sw_aclk266_p, SRC_TOP11, 20, 1),
+	MUX(0, "mout_sw_aclk166", mout_sw_aclk166_p, SRC_TOP11, 24, 1),
+	MUX(CLK_MOUT_SW_ACLK333, "mout_sw_aclk333", mout_sw_aclk333_p,
+			SRC_TOP11, 28, 1),
+
+	MUX(0, "mout_sw_aclk333_g2d", mout_sw_aclk333_g2d_p,
+			SRC_TOP12, 8, 1),
+	MUX(0, "mout_sw_aclk266_g2d", mout_sw_aclk266_g2d_p,
+			SRC_TOP12, 12, 1),
+	MUX(0, "mout_sw_aclk_g3d", mout_sw_aclk_g3d_p, SRC_TOP12, 16, 1),
+	MUX(0, "mout_sw_aclk300_jpeg", mout_sw_aclk300_jpeg_p,
+			SRC_TOP12, 20, 1),
+	MUX(0, "mout_sw_aclk300_disp1", mout_sw_aclk300_disp1_p,
 			SRC_TOP12, 24, 1),
-	MUX(0, "mout_sw_aclk300_gscl", sw_aclk300_gscl_p, SRC_TOP12, 28, 1),
+	MUX(CLK_MOUT_SW_ACLK300_GSCL, "mout_sw_aclk300_gscl",
+			mout_sw_aclk300_gscl_p, SRC_TOP12, 28, 1),
 
 	/* DISP1 Block */
-	MUX(0, "mout_fimd1", group3_p, SRC_DISP10, 4, 1),
-	MUX(0, "mout_mipi1", group2_p, SRC_DISP10, 16, 3),
-	MUX(0, "mout_dp1", group2_p, SRC_DISP10, 20, 3),
-	MUX(0, "mout_pixel", group2_p, SRC_DISP10, 24, 3),
-	MUX(CLK_MOUT_HDMI, "mout_hdmi", hdmi_p, SRC_DISP10, 28, 1),
+	MUX(CLK_MOUT_FIMD1, "mout_fimd1", mout_group3_p, SRC_DISP10, 4, 1),
+	MUX(0, "mout_mipi1", mout_group2_p, SRC_DISP10, 16, 3),
+	MUX(0, "mout_dp1", mout_group2_p, SRC_DISP10, 20, 3),
+	MUX(0, "mout_pixel", mout_group2_p, SRC_DISP10, 24, 3),
+	MUX(CLK_MOUT_HDMI, "mout_hdmi", mout_hdmi_p, SRC_DISP10, 28, 1),
 
 	/* MAU Block */
-	MUX(0, "mout_maudio0", maudio0_p, SRC_MAU, 28, 3),
+	MUX_F(CLK_MOUT_MAUDIO0, "mout_maudio0", mout_maudio0_p, SRC_MAU, 28, 3,
+						CLK_SET_RATE_PARENT, 0),
 
 	/* FSYS Block */
-	MUX(0, "mout_usbd301", group2_p, SRC_FSYS, 4, 3),
-	MUX(0, "mout_mmc0", group2_p, SRC_FSYS, 8, 3),
-	MUX(0, "mout_mmc1", group2_p, SRC_FSYS, 12, 3),
-	MUX(0, "mout_mmc2", group2_p, SRC_FSYS, 16, 3),
-	MUX(0, "mout_usbd300", group2_p, SRC_FSYS, 20, 3),
-	MUX(0, "mout_unipro", group2_p, SRC_FSYS, 24, 3),
+	MUX(0, "mout_usbd301", mout_group2_p, SRC_FSYS, 4, 3),
+	MUX(0, "mout_mmc0", mout_group2_p, SRC_FSYS, 8, 3),
+	MUX(0, "mout_mmc1", mout_group2_p, SRC_FSYS, 12, 3),
+	MUX(0, "mout_mmc2", mout_group2_p, SRC_FSYS, 16, 3),
+	MUX(0, "mout_usbd300", mout_group2_p, SRC_FSYS, 20, 3),
+	MUX(0, "mout_unipro", mout_group2_p, SRC_FSYS, 24, 3),
 
 	/* PERIC Block */
-	MUX(0, "mout_uart0", group2_p, SRC_PERIC0, 4, 3),
-	MUX(0, "mout_uart1", group2_p, SRC_PERIC0, 8, 3),
-	MUX(0, "mout_uart2", group2_p, SRC_PERIC0, 12, 3),
-	MUX(0, "mout_uart3", group2_p, SRC_PERIC0, 16, 3),
-	MUX(0, "mout_pwm", group2_p, SRC_PERIC0, 24, 3),
-	MUX(0, "mout_spdif", spdif_p, SRC_PERIC0, 28, 3),
-	MUX(0, "mout_audio0", audio0_p, SRC_PERIC1, 8, 3),
-	MUX(0, "mout_audio1", audio1_p, SRC_PERIC1, 12, 3),
-	MUX(0, "mout_audio2", audio2_p, SRC_PERIC1, 16, 3),
-	MUX(0, "mout_spi0", group2_p, SRC_PERIC1, 20, 3),
-	MUX(0, "mout_spi1", group2_p, SRC_PERIC1, 24, 3),
-	MUX(0, "mout_spi2", group2_p, SRC_PERIC1, 28, 3),
+	MUX(0, "mout_uart0", mout_group2_p, SRC_PERIC0, 4, 3),
+	MUX(0, "mout_uart1", mout_group2_p, SRC_PERIC0, 8, 3),
+	MUX(0, "mout_uart2", mout_group2_p, SRC_PERIC0, 12, 3),
+	MUX(0, "mout_uart3", mout_group2_p, SRC_PERIC0, 16, 3),
+	MUX(0, "mout_pwm", mout_group2_p, SRC_PERIC0, 24, 3),
+	MUX(0, "mout_spdif", mout_spdif_p, SRC_PERIC0, 28, 3),
+	MUX(0, "mout_audio0", mout_audio0_p, SRC_PERIC1, 8, 3),
+	MUX(0, "mout_audio1", mout_audio1_p, SRC_PERIC1, 12, 3),
+	MUX(0, "mout_audio2", mout_audio2_p, SRC_PERIC1, 16, 3),
+	MUX(CLK_MOUT_SPI0, "mout_spi0", mout_group2_p, SRC_PERIC1, 20, 3),
+	MUX(CLK_MOUT_SPI1, "mout_spi1", mout_group2_p, SRC_PERIC1, 24, 3),
+	MUX(CLK_MOUT_SPI2, "mout_spi2", mout_group2_p, SRC_PERIC1, 28, 3),
 };
 
 static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
-	DIV(0, "div_arm", "mout_cpu", DIV_CPU0, 0, 3),
+	DIV(0, "dout_armclk1", "mout_cpu", DIV_CPU0, 0, 3),
 	DIV(0, "sclk_apll", "mout_apll", DIV_CPU0, 24, 3),
-	DIV(0, "armclk2", "div_arm", DIV_CPU0, 28, 3),
-	DIV(0, "div_kfc", "mout_cpu_kfc", DIV_KFC0, 0, 3),
+	DIV(0, "dout_armclk2", "dout_armclk1", DIV_CPU0, 28, 3),
+	DIV(0, "dout_kfc", "mout_kfc", DIV_KFC0, 0, 3),
 	DIV(0, "sclk_kpll", "mout_kpll", DIV_KFC0, 24, 3),
 
 	DIV(0, "dout_aclk400_mscl", "mout_aclk400_mscl", DIV_TOP0, 4, 3),
@@ -486,12 +504,11 @@ static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
 	DIV(0, "dout_aclk266_g2d", "mout_aclk266_g2d", DIV_TOP2, 12, 3),
 	DIV(0, "dout_aclk_g3d", "mout_aclk_g3d", DIV_TOP2, 16, 3),
 	DIV(0, "dout_aclk300_jpeg", "mout_aclk300_jpeg", DIV_TOP2, 20, 3),
-	DIV_A(0, "dout_aclk300_disp1", "mout_aclk300_disp1",
-			DIV_TOP2, 24, 3, "aclk300_disp1"),
+	DIV(0, "dout_aclk300_disp1", "mout_aclk300_disp1", DIV_TOP2, 24, 3),
 	DIV(0, "dout_aclk300_gscl", "mout_aclk300_gscl", DIV_TOP2, 28, 3),
 
 	/* DISP1 Block */
-	DIV(0, "dout_fimd1", "mout_fimd1", DIV_DISP10, 0, 4),
+	DIV(0, "dout_fimd1", "mout_fimd1_final", DIV_DISP10, 0, 4),
 	DIV(0, "dout_mipi1", "mout_mipi1", DIV_DISP10, 16, 8),
 	DIV(0, "dout_dp1", "mout_dp1", DIV_DISP10, 24, 4),
 	DIV(CLK_DOUT_PIXEL, "dout_hdmi_pixel", "mout_pixel", DIV_DISP10, 28, 4),
@@ -537,41 +554,41 @@ static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
 	DIV(0, "dout_audio2", "mout_audio2", DIV_PERIC3, 28, 4),
 
 	/* SPI Pre-Ratio */
-	DIV(0, "dout_pre_spi0", "dout_spi0", DIV_PERIC4, 8, 8),
-	DIV(0, "dout_pre_spi1", "dout_spi1", DIV_PERIC4, 16, 8),
-	DIV(0, "dout_pre_spi2", "dout_spi2", DIV_PERIC4, 24, 8),
+	DIV(0, "dout_spi0_pre", "dout_spi0", DIV_PERIC4, 8, 8),
+	DIV(0, "dout_spi1_pre", "dout_spi1", DIV_PERIC4, 16, 8),
+	DIV(0, "dout_spi2_pre", "dout_spi2", DIV_PERIC4, 24, 8),
 };
 
 static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
-	/* TODO: Re-verify the CG bits for all the gate clocks */
-	GATE_A(CLK_PCLK_MCT, "pclk_st", "aclk66_psgen",
-			GATE_BUS_PERIS1, 2, 0, 0, "mct"),
-
-	GATE(0, "aclk200_fsys", "mout_user_aclk200_fsys",
-			GATE_BUS_FSYS0, 9, CLK_IGNORE_UNUSED, 0),
-	GATE(0, "aclk200_fsys2", "mout_user_aclk200_fsys2",
-			GATE_BUS_FSYS0, 10, CLK_IGNORE_UNUSED, 0),
-
-	GATE(0, "aclk333_g2d", "mout_user_aclk333_g2d",
-			GATE_BUS_TOP, 0, CLK_IGNORE_UNUSED, 0),
-	GATE(0, "aclk266_g2d", "mout_user_aclk266_g2d",
-			GATE_BUS_TOP, 1, CLK_IGNORE_UNUSED, 0),
-	GATE(0, "aclk300_jpeg", "mout_user_aclk300_jpeg",
-			GATE_BUS_TOP, 4, CLK_IGNORE_UNUSED, 0),
-	GATE(0, "aclk300_gscl", "mout_user_aclk300_gscl",
-			GATE_BUS_TOP, 6, CLK_IGNORE_UNUSED, 0),
-	GATE(0, "aclk333_432_gscl", "mout_user_aclk333_432_gscl",
-			GATE_BUS_TOP, 7, CLK_IGNORE_UNUSED, 0),
-	GATE(0, "pclk66_gpio", "mout_sw_aclk66",
-			GATE_BUS_TOP, 9, CLK_IGNORE_UNUSED, 0),
-	GATE(0, "aclk66_psgen", "mout_aclk66_psgen",
-			GATE_BUS_TOP, 10, CLK_IGNORE_UNUSED, 0),
-	GATE(0, "aclk66_peric", "mout_aclk66_peric",
-			GATE_BUS_TOP, 11, 0, 0),
-	GATE(0, "aclk166", "mout_user_aclk166",
-			GATE_BUS_TOP, 14, CLK_IGNORE_UNUSED, 0),
-	GATE(0, "aclk333", "mout_aclk333",
-			GATE_BUS_TOP, 15, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_PCLK_MCT, "pclk_mct", "aclk66_psgen",
+		GATE_BUS_PERIS1, 2, 0, 0),
+
+	GATE(CLK_ACLK200_FSYS, "aclk200_fsys", "mout_user_aclk200_fsys",
+		GATE_BUS_FSYS0, 9, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK200_FSYS2, "aclk200_fsys2", "mout_user_aclk200_fsys2",
+		GATE_BUS_FSYS0, 10, CLK_IGNORE_UNUSED, 0),
+
+	GATE(CLK_ACLK333_G2D, "aclk333_g2d", "mout_user_aclk333_g2d",
+		GATE_BUS_TOP, 0, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK266_G2D, "aclk266_g2d", "mout_user_aclk266_g2d",
+		GATE_BUS_TOP, 1, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK300_JPEG, "aclk300_jpeg", "mout_user_aclk300_jpeg",
+		GATE_BUS_TOP, 4, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK300_GSCL, "aclk300_gscl", "mout_user_aclk300_gscl",
+		GATE_BUS_TOP, 6, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK333_432_GSCL, "aclk333_432_gscl",
+		"mout_user_aclk333_432_gscl",
+		GATE_BUS_TOP, 7, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_PCLK66_GPIO, "pclk66_gpio", "mout_user_aclk66_gpio",
+		GATE_BUS_TOP, 9, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK66_PSGEN, "aclk66_psgen", "mout_user_aclk66_psgen",
+		GATE_BUS_TOP, 10, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK66_PERIC, "aclk66_peric", "mout_user_aclk66_peric",
+		GATE_BUS_TOP, 11, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK166, "aclk166", "mout_user_aclk166",
+		GATE_BUS_TOP, 14, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK333, "aclk333", "mout_user_aclk333",
+		GATE_BUS_TOP, 15, CLK_IGNORE_UNUSED, 0),
 
 	/* sclk */
 	GATE(CLK_SCLK_UART0, "sclk_uart0", "dout_uart0",
@@ -582,11 +599,11 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 		GATE_TOP_SCLK_PERIC, 2, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_UART3, "sclk_uart3", "dout_uart3",
 		GATE_TOP_SCLK_PERIC, 3, CLK_SET_RATE_PARENT, 0),
-	GATE(CLK_SCLK_SPI0, "sclk_spi0", "dout_pre_spi0",
+	GATE(CLK_SCLK_SPI0, "sclk_spi0", "dout_spi0_pre",
 		GATE_TOP_SCLK_PERIC, 6, CLK_SET_RATE_PARENT, 0),
-	GATE(CLK_SCLK_SPI1, "sclk_spi1", "dout_pre_spi1",
+	GATE(CLK_SCLK_SPI1, "sclk_spi1", "dout_spi1_pre",
 		GATE_TOP_SCLK_PERIC, 7, CLK_SET_RATE_PARENT, 0),
-	GATE(CLK_SCLK_SPI2, "sclk_spi2", "dout_pre_spi2",
+	GATE(CLK_SCLK_SPI2, "sclk_spi2", "dout_spi2_pre",
 		GATE_TOP_SCLK_PERIC, 8, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_SPDIF, "sclk_spdif", "mout_spdif",
 		GATE_TOP_SCLK_PERIC, 9, CLK_SET_RATE_PARENT, 0),
@@ -612,16 +629,16 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 	GATE(CLK_SCLK_USBPHY300, "sclk_usbphy300", "dout_usbphy300",
 		GATE_TOP_SCLK_FSYS, 8, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_USBD300, "sclk_usbd300", "dout_usbd300",
-		GATE_TOP_SCLK_FSYS, 9, CLK_SET_RATE_PARENT, 0),
+		GATE_TOP_SCLK_FSYS, 9, CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_SCLK_USBD301, "sclk_usbd301", "dout_usbd301",
-		GATE_TOP_SCLK_FSYS, 10, CLK_SET_RATE_PARENT, 0),
+		GATE_TOP_SCLK_FSYS, 10, CLK_IGNORE_UNUSED, 0),
 
-	GATE(CLK_SCLK_USBD301, "sclk_unipro", "dout_unipro",
-		SRC_MASK_FSYS, 24, CLK_SET_RATE_PARENT, 0),
+	GATE(CLK_SCLK_UNIPRO, "sclk_unipro", "dout_unipro",
+		GATE_IP_FSYS, 23, CLK_SET_RATE_PARENT, 0),
 
-	GATE(CLK_SCLK_GSCL_WA, "sclk_gscl_wa", "aclK333_432_gscl",
+	GATE(CLK_SCLK_GSCL_WA, "sclk_gscl_wa", "mout_user_aclk333_432_gscl",
 		GATE_TOP_SCLK_GSCL, 6, CLK_SET_RATE_PARENT, 0),
-	GATE(CLK_SCLK_GSCL_WB, "sclk_gscl_wb", "aclk333_432_gscl",
+	GATE(CLK_SCLK_GSCL_WB, "sclk_gscl_wb", "mout_user_aclk333_432_gscl",
 		GATE_TOP_SCLK_GSCL, 7, CLK_SET_RATE_PARENT, 0),
 
 	/* Display */
@@ -643,142 +660,199 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 		GATE_TOP_SCLK_MAU, 1, CLK_SET_RATE_PARENT, 0),
 	/* FSYS */
 	GATE(CLK_TSI, "tsi", "aclk200_fsys", GATE_BUS_FSYS0, 0, 0, 0),
-	GATE(CLK_ACLK_PDMA0, "pdma0", "aclk200_fsys", GATE_BUS_FSYS0, 1, 0, 0),
-	GATE(CLK_ACLK_PDMA1, "pdma1", "aclk200_fsys", GATE_BUS_FSYS0, 2, 0, 0),
+	GATE(CLK_ACLK_PDMA0, "aclk_pdma0", "aclk200_fsys",
+			GATE_BUS_FSYS0, 1, 0, 0),
+	GATE(CLK_ACLK_PDMA1, "aclk_pdma1", "aclk200_fsys",
+			GATE_BUS_FSYS0, 2, 0, 0),
 	GATE(CLK_UFS, "ufs", "aclk200_fsys2", GATE_BUS_FSYS0, 3, 0, 0),
-	GATE(CLK_ACLK_RTIC, "rtic", "aclk200_fsys", GATE_BUS_FSYS0, 5, 0, 0),
-	GATE(CLK_ACLK_MMC0, "mmc0", "aclk200_fsys2", GATE_BUS_FSYS0, 12, 0, 0),
-	GATE(CLK_ACLK_MMC1, "mmc1", "aclk200_fsys2", GATE_BUS_FSYS0, 13, 0, 0),
-	GATE(CLK_ACLK_MMC2, "mmc2", "aclk200_fsys2", GATE_BUS_FSYS0, 14, 0, 0),
-	GATE(CLK_HCLK_SROMC, "sromc", "aclk200_fsys2",
-			GATE_BUS_FSYS0, 19, CLK_IGNORE_UNUSED, 0),
-	GATE(CLK_HCLK_USBH20, "usbh20", "aclk200_fsys",
-			GATE_BUS_FSYS0, 20, 0, 0),
-	GATE(CLK_HCLK_USBD300, "usbd300", "aclk200_fsys",
+	GATE(CLK_ACLK_RTIC, "aclk_rtic", "aclk200_fsys2",
+			GATE_IP_FSYS, 9, 0, 0),
+	GATE(CLK_ACLK_MMC0, "aclk_mmc0", "aclk200_fsys2",
+			GATE_BUS_FSYS0, 12, 0, 0),
+	GATE(CLK_ACLK_MMC1, "aclk_mmc1", "aclk200_fsys2",
+			GATE_BUS_FSYS0, 13, 0, 0),
+	GATE(CLK_ACLK_MMC2, "aclk_mmc2", "aclk200_fsys2",
+			GATE_BUS_FSYS0, 14, 0, 0),
+	GATE(CLK_HCLK_SROMC, "hclk_sromc", "aclk200_fsys2",
+			GATE_IP_FSYS, 17, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_HCLK_USBH20, "hclk_usbh20", "aclk200_fsys",
+			GATE_IP_FSYS, 18, 0, 0),
+	GATE(CLK_HCLK_USBD300, "hclk_usbd300", "aclk200_fsys",
 			GATE_BUS_FSYS0, 21, 0, 0),
-	GATE(CLK_HCLK_USBD301, "usbd301", "aclk200_fsys",
+	GATE(CLK_HCLK_USBD301, "hclk_usbd301", "aclk200_fsys",
 			GATE_BUS_FSYS0, 28, 0, 0),
 
 	/* UART */
-	GATE(CLK_PCLK_UART0, "uart0", "aclk66_peric", GATE_BUS_PERIC, 4, 0, 0),
-	GATE(CLK_PCLK_UART1, "uart1", "aclk66_peric", GATE_BUS_PERIC, 5, 0, 0),
-	GATE_A(CLK_PCLK_UART2, "uart2", "aclk66_peric",
-		GATE_BUS_PERIC, 6, CLK_IGNORE_UNUSED, 0, "uart2"),
-	GATE(CLK_PCLK_UART3, "uart3", "aclk66_peric", GATE_BUS_PERIC, 7, 0, 0),
+	GATE(CLK_PCLK_UART0, "pclk_uart0", "aclk66_peric",
+			GATE_BUS_PERIC, 4, 0, 0),
+	GATE(CLK_PCLK_UART1, "pclk_uart1", "aclk66_peric",
+			GATE_BUS_PERIC, 5, 0, 0),
+	GATE(CLK_PCLK_UART2, "pclk_uart2", "aclk66_peric",
+			GATE_BUS_PERIC, 6, 0, 0),
+	GATE(CLK_PCLK_UART3, "pclk_uart3", "aclk66_peric",
+			GATE_BUS_PERIC, 7, 0, 0),
 	/* I2C */
-	GATE(CLK_PCLK_I2C0, "i2c0", "aclk66_peric", GATE_BUS_PERIC, 9, 0, 0),
-	GATE(CLK_PCLK_I2C1, "i2c1", "aclk66_peric", GATE_BUS_PERIC, 10, 0, 0),
-	GATE(CLK_PCLK_I2C2, "i2c2", "aclk66_peric", GATE_BUS_PERIC, 11, 0, 0),
-	GATE(CLK_PCLK_I2C3, "i2c3", "aclk66_peric", GATE_BUS_PERIC, 12, 0, 0),
-	GATE(CLK_PCLK_I2C_HDMI, "i2c_hdmi", "aclk66_peric",
+	GATE(CLK_PCLK_I2C0, "pclk_i2c0", "aclk66_peric",
+			GATE_IP_PERIC, 6, 0, 0),
+	GATE(CLK_PCLK_I2C1, "pclk_i2c1", "aclk66_peric",
+			GATE_IP_PERIC, 7, 0, 0),
+	GATE(CLK_PCLK_I2C2, "pclk_i2c2", "aclk66_peric",
+			GATE_IP_PERIC, 8, 0, 0),
+	GATE(CLK_PCLK_I2C3, "pclk_i2c3", "aclk66_peric",
+			GATE_IP_PERIC, 9, 0, 0),
+	GATE(CLK_PCLK_USI0, "pclk_usi0", "aclk66_peric",
+			GATE_IP_PERIC, 10, 0, 0),
+	GATE(CLK_PCLK_USI1, "pclk_usi1", "aclk66_peric",
+			GATE_IP_PERIC, 11, 0, 0),
+	GATE(CLK_PCLK_USI2, "pclk_usi2", "aclk66_peric",
+			GATE_IP_PERIC, 12, 0, 0),
+	GATE(CLK_PCLK_USI3, "pclk_usi3", "aclk66_peric",
+			GATE_IP_PERIC, 13, 0, 0),
+	GATE(CLK_PCLK_USI4, "pclk_usi4", "aclk66_peric",
+			GATE_IP_PERIC, 28, 0, 0),
+	GATE(CLK_PCLK_USI5, "pclk_usi5", "aclk66_peric",
+			GATE_IP_PERIC, 30, 0, 0),
+	GATE(CLK_PCLK_USI6, "pclk_usi6", "aclk66_peric",
+			GATE_IP_PERIC, 31, 0, 0),
+
+	GATE(CLK_PCLK_I2C_HDMI, "pclk_i2c_hdmi", "aclk66_peric",
 			GATE_BUS_PERIC, 17, 0, 0),
-	GATE(CLK_PCLK_TSADC, "tsadc", "aclk66_peric", GATE_BUS_PERIC, 18, 0, 0),
+	GATE(CLK_PCLK_TSADC, "pclk_tsadc", "aclk66_peric",
+			GATE_IP_PERIC, 15, 0, 0),
 	/* SPI */
-	GATE(CLK_PCLK_SPI0, "spi0", "aclk66_peric", GATE_BUS_PERIC, 19, 0, 0),
-	GATE(CLK_PCLK_SPI1, "spi1", "aclk66_peric", GATE_BUS_PERIC, 20, 0, 0),
-	GATE(CLK_PCLK_SPI2, "spi2", "aclk66_peric", GATE_BUS_PERIC, 21, 0, 0),
+	GATE(CLK_PCLK_SPI0, "pclk_spi0", "aclk66_peric",
+			GATE_BUS_PERIC, 19, 0, 0),
+	GATE(CLK_PCLK_SPI1, "pclk_spi1", "aclk66_peric",
+			GATE_BUS_PERIC, 20, 0, 0),
+	GATE(CLK_PCLK_SPI2, "pclk_spi2", "aclk66_peric",
+			GATE_BUS_PERIC, 21, 0, 0),
 	GATE(CLK_KEYIF, "keyif", "aclk66_peric", GATE_BUS_PERIC, 22, 0, 0),
 	/* I2S */
-	GATE(CLK_PCLK_I2S1, "i2s1", "aclk66_peric", GATE_BUS_PERIC, 23, 0, 0),
-	GATE(CLK_PCLK_I2S2, "i2s2", "aclk66_peric", GATE_BUS_PERIC, 24, 0, 0),
+	GATE(CLK_PCLK_I2S1, "pclk_i2s1", "aclk66_peric",
+			GATE_BUS_PERIC, 23, 0, 0),
+	GATE(CLK_PCLK_I2S2, "pclk_i2s2", "aclk66_peric",
+			GATE_BUS_PERIC, 24, 0, 0),
 	/* PCM */
-	GATE(CLK_PCLK_PCM1, "pcm1", "aclk66_peric", GATE_BUS_PERIC, 25, 0, 0),
-	GATE(CLK_PCLK_PCM2, "pcm2", "aclk66_peric", GATE_BUS_PERIC, 26, 0, 0),
+	GATE(CLK_PCLK_PCM1, "pclk_pcm1", "aclk66_peric",
+			GATE_BUS_PERIC, 25, 0, 0),
+	GATE(CLK_PCLK_PCM2, "pclk_pcm2", "aclk66_peric",
+			GATE_BUS_PERIC, 26, 0, 0),
 	/* PWM */
 	GATE(CLK_PCLK_PWM, "pwm", "aclk66_peric", GATE_BUS_PERIC, 27, 0, 0),
 	/* SPDIF */
-	GATE(CLK_PCLK_SPDIF, "spdif", "aclk66_peric", GATE_BUS_PERIC, 29, 0, 0),
-
-	GATE(CLK_PCLK_CHIPID, "chipid", "aclk66_psgen",
-			GATE_BUS_PERIS0, 12, CLK_IGNORE_UNUSED, 0),
-	GATE(CLK_PCLK_SYSREG, "sysreg", "aclk66_psgen",
-			GATE_BUS_PERIS0, 13, CLK_IGNORE_UNUSED, 0),
-	GATE(CLK_PCLK_TZPC0, "tzpc0", "aclk66_psgen",
-			GATE_BUS_PERIS0, 18, 0, 0),
-	GATE(CLK_PCLK_TZPC1, "tzpc1", "aclk66_psgen",
-			GATE_BUS_PERIS0, 19, 0, 0),
-	GATE(CLK_PCLK_TZPC2, "tzpc2", "aclk66_psgen",
-			GATE_BUS_PERIS0, 20, 0, 0),
-	GATE(CLK_PCLK_TZPC3, "tzpc3", "aclk66_psgen",
-			GATE_BUS_PERIS0, 21, 0, 0),
-	GATE(CLK_PCLK_TZPC4, "tzpc4", "aclk66_psgen",
-			GATE_BUS_PERIS0, 22, 0, 0),
-	GATE(CLK_PCLK_TZPC5, "tzpc5", "aclk66_psgen",
-			GATE_BUS_PERIS0, 23, 0, 0),
-	GATE(CLK_PCLK_TZPC6, "tzpc6", "aclk66_psgen",
-			GATE_BUS_PERIS0, 24, 0, 0),
-	GATE(CLK_PCLK_TZPC7, "tzpc7", "aclk66_psgen",
-			GATE_BUS_PERIS0, 25, 0, 0),
-	GATE(CLK_PCLK_TZPC8, "tzpc8", "aclk66_psgen",
-			GATE_BUS_PERIS0, 26, 0, 0),
-	GATE(CLK_PCLK_TZPC9, "tzpc9", "aclk66_psgen",
-			GATE_BUS_PERIS0, 27, 0, 0),
-
-	GATE(CLK_HDMI_CEC, "hdmi_cec", "aclk66_psgen", GATE_BUS_PERIS1, 0, 0,
-		0),
+	GATE(CLK_PCLK_SPDIF, "pclk_spdif", "aclk66_peric",
+			GATE_BUS_PERIC, 29, 0, 0),
+
+	GATE(CLK_PCLK_CHIPID, "pclk_chipid", "aclk66_psgen",
+			GATE_IP_PERIS, 0, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_PCLK_SYSREG, "pclk_sysreg", "aclk66_psgen",
+			GATE_IP_PERIS, 1, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_PCLK_TZPC0, "pclk_tzpc0", "aclk66_psgen",
+			GATE_IP_PERIS, 6, 0, 0),
+	GATE(CLK_PCLK_TZPC1, "pclk_tzpc1", "aclk66_psgen",
+			GATE_IP_PERIS, 7, 0, 0),
+	GATE(CLK_PCLK_TZPC2, "pclk_tzpc2", "aclk66_psgen",
+			GATE_IP_PERIS, 8, 0, 0),
+	GATE(CLK_PCLK_TZPC3, "pclk_tzpc3", "aclk66_psgen",
+			GATE_IP_PERIS, 9, 0, 0),
+	GATE(CLK_PCLK_TZPC4, "pclk_tzpc4", "aclk66_psgen",
+			GATE_IP_PERIS, 10, 0, 0),
+	GATE(CLK_PCLK_TZPC5, "pclk_tzpc5", "aclk66_psgen",
+			GATE_IP_PERIS, 11, 0, 0),
+	GATE(CLK_PCLK_TZPC6, "pclk_tzpc6", "aclk66_psgen",
+			GATE_IP_PERIS, 12, 0, 0),
+	GATE(CLK_PCLK_TZPC7, "pclk_tzpc7", "aclk66_psgen",
+			GATE_IP_PERIS, 13, 0, 0),
+	GATE(CLK_PCLK_TZPC8, "pclk_tzpc8", "aclk66_psgen",
+			GATE_IP_PERIS, 14, 0, 0),
+	GATE(CLK_PCLK_TZPC9, "pclk_tzpc9", "aclk66_psgen",
+			GATE_IP_PERIS, 15, 0, 0),
+	GATE(CLK_PCLK_TZPC10, "pclk_tzpc10", "aclk66_psgen",
+			GATE_BUS_GEN, 30, 0, 0),
+	GATE(CLK_PCLK_TZPC11, "pclk_tzpc11", "aclk66_psgen",
+			GATE_BUS_GEN, 31, 0, 0),
+
+	GATE(CLK_HDMI_CEC, "hdmi_cec", "aclk66_psgen",
+			GATE_BUS_PERIS1, 0, 0, 0),
 	GATE(CLK_SECKEY, "seckey", "aclk66_psgen", GATE_BUS_PERIS1, 1, 0, 0),
-	GATE(CLK_PCLK_WDT, "wdt", "aclk66_psgen", GATE_BUS_PERIS1, 3, 0, 0),
-	GATE(CLK_PCLK_RTC, "rtc", "aclk66_psgen", GATE_BUS_PERIS1, 4, 0, 0),
-	GATE(CLK_PCLK_TMU, "tmu", "aclk66_psgen", GATE_BUS_PERIS1, 5, 0, 0),
-	GATE(CLK_PCLK_TMU_GPU, "tmu_gpu", "aclk66_psgen",
-			GATE_BUS_PERIS1, 6, 0, 0),
-
-	GATE(CLK_ACLK_GSCL0, "gscl0", "aclk300_gscl", GATE_IP_GSCL0, 0, 0, 0),
-	GATE(CLK_ACLK_GSCL1, "gscl1", "aclk300_gscl", GATE_IP_GSCL0, 1, 0, 0),
-	GATE(CLK_ACLK_FIMC_3AA, "clk_3aa", "aclk300_gscl",
+	GATE(CLK_PCLK_WDT, "pclk_wdt", "aclk66_psgen", GATE_IP_PERIS, 19, 0, 0),
+	GATE(CLK_PCLK_RTC, "pclk_rtc", "aclk66_psgen", GATE_IP_PERIS, 20, 0, 0),
+	GATE(CLK_PCLK_TMU, "pclk_tmu", "aclk66_psgen", GATE_IP_PERIS, 21, 0, 0),
+	GATE(CLK_PCLK_TMU_GPU, "pclk_tmu_gpu", "aclk66_psgen",
+			GATE_IP_PERIS, 22, 0, 0),
+
+	GATE(CLK_ACLK_GSCL0, "aclk_gscl0", "mout_user_aclk300_gscl",
+			GATE_IP_GSCL0, 0, 0, 0),
+	GATE(CLK_ACLK_GSCL1, "aclk_gscl1", "mout_user_aclk300_gscl",
+			GATE_IP_GSCL0, 1, 0, 0),
+	GATE(CLK_ACLK_FIMC_3AA, "aclk_fimc_3aa", "aclk333_432_gscl",
 			GATE_IP_GSCL0, 4, 0, 0),
 
-	GATE(CLK_SMMU_3AA, "smmu_3aa", "aclk333_432_gscl", GATE_IP_GSCL1, 2, 0,
-		0),
-	GATE(CLK_SMMU_FIMCL0, "smmu_fimcl0", "aclk333_432_gscl",
+	GATE(CLK_SMMU_3AA, "smmu_3aa", "dout_gscl_blk_333",
+			GATE_IP_GSCL1, 2, 0, 0),
+	GATE(CLK_SMMU_FIMCL0, "smmu_fimcl0", "dout_gscl_blk_333",
 			GATE_IP_GSCL1, 3, 0, 0),
-	GATE(CLK_SMMU_FIMCL1, "smmu_fimcl1", "aclk333_432_gscl",
+	GATE(CLK_SMMU_FIMCL1, "smmu_fimcl1", "dout_gscl_blk_333",
 			GATE_IP_GSCL1, 4, 0, 0),
-	GATE(CLK_SMMU_GSCL0, "smmu_gscl0", "aclk300_gscl", GATE_IP_GSCL1, 6, 0,
-		0),
-	GATE(CLK_SMMU_GSCL1, "smmu_gscl1", "aclk300_gscl", GATE_IP_GSCL1, 7, 0,
-		0),
-	GATE(CLK_PCLK_GSCL_WA, "gscl_wa", "aclk300_gscl",
-			GATE_IP_GSCL1, 12, 0, 0),
+	GATE(CLK_SMMU_GSCL0, "smmu_gscl0", "dout_gscl_blk_300",
+			GATE_IP_GSCL1, 6, 0, 0),
+	GATE(CLK_SMMU_GSCL1, "smmu_gscl1", "dout_gscl_blk_300",
+			GATE_IP_GSCL1, 7, 0, 0),
+	GATE(CLK_PCLK_GSCL_WA, "pclk_gscl_wa", "dout_gscl_blk_333",
+			GATE_BUS_GSCL1, 28, 0, 0),
 	GATE(CLK_GSCL_WB, "gscl_wb", "aclk300_gscl", GATE_IP_GSCL1, 13, 0, 0),
-	GATE(CLK_SMMU_FIMCL3, "smmu_fimcl3,", "aclk333_432_gscl",
+	GATE(CLK_SMMU_FIMCL3, "smmu_fimcl3,", "dout_gscl_blk_333",
 			GATE_IP_GSCL1, 16, 0, 0),
-	GATE(CLK_ACLK_FIMC_LITE3, "fimc_lite3", "aclk333_432_gscl",
+	GATE(CLK_ACLK_FIMC_LITE3, "aclk_fimc_lite3", "aclk333_432_gscl",
 			GATE_IP_GSCL1, 17, 0, 0),
 
-	GATE(CLK_ACLK_FIMD1, "fimd1", "aclk300_disp1", GATE_IP_DISP1, 0, 0, 0),
-	GATE(CLK_PCLK_DSIM1, "dsim1", "aclk200_disp1", GATE_IP_DISP1, 3, 0, 0),
-	GATE(CLK_PCLK_DP1, "dp1", "aclk200_disp1", GATE_IP_DISP1, 4, 0, 0),
-	GATE(CLK_ACLK_MIXER, "mixer", "aclk166", GATE_IP_DISP1, 5, 0, 0),
-	GATE(CLK_PCLK_HDMI, "hdmi", "aclk200_disp1", GATE_IP_DISP1, 6, 0, 0),
-	GATE(CLK_SMMU_FIMD1M0, "smmu_fimd1", "aclk300_disp1",
-			GATE_IP_DISP1, 8, 0, 0),
-
-	GATE(CLK_ACLK_MFC, "mfc", "aclk333", GATE_IP_MFC, 0, 0, 0),
-	GATE(CLK_SMMU_MFCL, "smmu_mfcl", "aclk333", GATE_IP_MFC, 1, 0, 0),
-	GATE(CLK_SMMU_MFCR, "smmu_mfcr", "aclk333", GATE_IP_MFC, 2, 0, 0),
-
-	GATE(CLK_G3D, "g3d", "aclkg3d", GATE_IP_G3D, 9, 0, 0),
-
-	GATE(CLK_ACLK_ROTATOR, "rotator", "aclk266", GATE_IP_GEN, 1, 0, 0),
-	GATE(CLK_ACLK_JPEG, "jpeg", "aclk300_jpeg", GATE_IP_GEN, 2, 0, 0),
-	GATE(CLK_ACLK_JPEG2, "jpeg2", "aclk300_jpeg", GATE_IP_GEN, 3, 0, 0),
-	GATE(CLK_ACLK_MDMA1, "mdma1", "aclk266", GATE_IP_GEN, 4, 0, 0),
-	GATE(CLK_SMMU_ROTATOR, "smmu_rotator", "aclk266", GATE_IP_GEN, 6, 0, 0),
-	GATE(CLK_SMMU_JPEG, "smmu_jpeg", "aclk300_jpeg", GATE_IP_GEN, 7, 0, 0),
-	GATE(CLK_SMMU_MDMA1, "smmu_mdma1", "aclk266", GATE_IP_GEN, 9, 0, 0),
-
-	GATE(CLK_ACLK_MSCL0, "mscl0", "aclk400_mscl", GATE_IP_MSCL, 0, 0, 0),
-	GATE(CLK_ACLK_MSCL1, "mscl1", "aclk400_mscl", GATE_IP_MSCL, 1, 0, 0),
-	GATE(CLK_ACLK_MSCL2, "mscl2", "aclk400_mscl", GATE_IP_MSCL, 2, 0, 0),
-	GATE(CLK_SMMU_MSCL0, "smmu_mscl0", "aclk400_mscl", GATE_IP_MSCL, 8, 0,
-		0),
-	GATE(CLK_SMMU_MSCL1, "smmu_mscl1", "aclk400_mscl", GATE_IP_MSCL, 9, 0,
-		0),
-	GATE(CLK_SMMU_MSCL2, "smmu_mscl2", "aclk400_mscl", GATE_IP_MSCL, 10, 0,
-		0),
-	GATE(CLK_SMMU_MIXER, "smmu_mixer", "aclk200_disp1", GATE_IP_DISP1, 9, 0,
-		0),
+	GATE(CLK_ACLK_FIMD1, "aclk_fimd1", "mout_user_aclk300_disp1",
+			GATE_IP_DISP1, 0, 0, 0),
+	GATE(CLK_PCLK_DSIM1, "pclk_dsim1", "dout_disp1_blk",
+			GATE_BUS_DISP1, 17, 0, 0),
+	GATE(CLK_PCLK_DP1, "pclk_dp1", "dout_disp1_blk",
+			GATE_BUS_DISP1, 18, 0, 0),
+	GATE(CLK_ACLK_MIXER, "aclk_mixer", "aclk200_disp1",
+			GATE_IP_DISP1, 5, 0, 0),
+	GATE(CLK_PCLK_HDMI, "pclk_hdmi", "dout_disp1_blk",
+			GATE_BUS_DISP1, 19, 0, 0),
+	GATE(CLK_SMMU_FIMD1M0, "smmu_fimd1m0", "dout_disp1_blk",
+			GATE_IP_DISP1, 7, 0, 0),
+
+	GATE(CLK_ACLK_MFC, "aclk_mfc", "mout_user_aclk333",
+			GATE_BUS_MFC, 0, 0, 0),
+	GATE(CLK_SMMU_MFCL, "smmu_mfcl", "dout_mfc_blk", GATE_IP_MFC, 1, 0, 0),
+	GATE(CLK_SMMU_MFCR, "smmu_mfcr", "dout_mfc_blk", GATE_IP_MFC, 2, 0, 0),
+	GATE(CLK_G3D, "clk_g3d", "mout_user_aclk_g3d",
+			GATE_IP_G3D, 9, 0, 0),
+
+	GATE(CLK_ACLK_ROTATOR, "aclk_rotator", "mout_user_aclk266",
+			GATE_IP_GEN, 1, 0, 0),
+	GATE(CLK_ACLK_JPEG, "aclk_jpeg", "aclk300_jpeg", GATE_IP_GEN, 2, 0, 0),
+	GATE(CLK_ACLK_JPEG2, "aclk_jpeg2", "aclk300_jpeg",
+			GATE_IP_GEN, 3, 0, 0),
+	GATE(CLK_ACLK_MDMA1, "aclk_mdma1", "mout_user_aclk266",
+			GATE_IP_GEN, 4, 0, 0),
+	GATE(CLK_SMMU_ROTATOR, "smmu_rotator", "dout_gen_blk",
+			GATE_IP_GEN, 6, 0, 0),
+	GATE(CLK_SMMU_JPEG, "smmu_jpeg", "dout_jpg_blk", GATE_IP_GEN, 7, 0, 0),
+	GATE(CLK_SMMU_MDMA1, "smmu_mdma1", "dout_gen_blk",
+			GATE_IP_GEN, 9, 0, 0),
+
+	GATE(CLK_ACLK_MSCL0, "aclk_mscl0", "aclk400_mscl",
+			GATE_BUS_MSCL, 0, 0, 0),
+	GATE(CLK_ACLK_MSCL1, "aclk_mscl1", "aclk400_mscl",
+			GATE_BUS_MSCL, 1, 0, 0),
+	GATE(CLK_ACLK_MSCL2, "aclk_mscl2", "aclk400_mscl",
+			GATE_BUS_MSCL, 2, 0, 0),
+	GATE(CLK_SMMU_MSCL0, "smmu_mscl0", "dout_mscl_blk",
+			GATE_IP_MSCL, 8, 0, 0),
+	GATE(CLK_SMMU_MSCL1, "smmu_mscl1", "dout_mscl_blk",
+			GATE_IP_MSCL, 9, 0, 0),
+	GATE(CLK_SMMU_MSCL2, "smmu_mscl2", "dout_mscl_blk",
+			GATE_IP_MSCL, 10, 0, 0),
+	GATE(CLK_SMMU_MIXER, "smmu_mixer", "dout_disp1_blk",
+			GATE_IP_DISP1, 9, 0, 0),
 
 	/* SSS */
 	GATE(CLK_ACLK_SSS, "aclk_sss", "aclk266_g2d", GATE_IP_G2D, 2, 0, 0),
diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index 598eb48..dde01fc 100644
--- a/include/dt-bindings/clock/exynos5420.h
+++ b/include/dt-bindings/clock/exynos5420.h
@@ -79,10 +79,10 @@
 #define CLK_PCLK_I2C1		262
 #define CLK_PCLK_I2C2		263
 #define CLK_PCLK_I2C3		264
-#define CLK_I2C4		265
-#define CLK_I2C5		266
-#define CLK_I2C6		267
-#define CLK_I2C7		268
+#define CLK_PCLK_USI0		265
+#define CLK_PCLK_USI1		266
+#define CLK_PCLK_USI2		267
+#define CLK_PCLK_USI3		268
 #define CLK_PCLK_I2C_HDMI	269
 #define CLK_PCLK_TSADC		270
 #define CLK_PCLK_SPI0		271
@@ -95,9 +95,9 @@
 #define CLK_PCLK_PCM2		278
 #define CLK_PCLK_PWM		279
 #define CLK_PCLK_SPDIF		280
-#define CLK_I2C8		281
-#define CLK_I2C9		282
-#define CLK_I2C10		283
+#define CLK_PCLK_USI4		281
+#define CLK_PCLK_USI5		282
+#define CLK_PCLK_USI6		283
 #define CLK_ACLK66_PSGEN	300
 #define CLK_PCLK_CHIPID		301
 #define CLK_PCLK_SYSREG		302
-- 
1.7.9.5
