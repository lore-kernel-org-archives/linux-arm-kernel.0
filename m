From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Tue, 06 May 2014 21:56:36 +0530
Subject: [PATCH v4 01/15] clk: exynos5420: Rename mux parent arrays
In-Reply-To: <1399393610-23394-1-git-send-email-shaik.ameer@samsung.com>
References: <1399393610-23394-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1399393610-23394-2-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch renames the mux parent arrays as per the naming
convension followed by the other exynos specific clock drivers.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c |  359 ++++++++++++++++++----------------
 1 file changed, 186 insertions(+), 173 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 7a9e3b4..831670d 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -216,85 +216,92 @@ static void exynos5420_clk_sleep_init(void) {}
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
+PNAME(mout_aclk66_peric_p)	= { "fin_pll", "mout_sw_aclk66" };
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
@@ -315,130 +322,136 @@ static struct samsung_fixed_factor_clock exynos5420_fixed_factor_clks[] __initda
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
+	MUX(0, "sclk_bpll", mout_bpll_p, SRC_CDREX, 0, 1),
 
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
+	MUX(0, "mout_user_aclk333_432_gscl", mout_user_aclk333_432_gscl_p,
 			SRC_TOP4, 0, 1),
-	MUX(0, "mout_aclk66_peric", aclk66_peric_p, SRC_TOP4, 8, 1),
-	MUX(0, "mout_user_aclk266", user_aclk266_p, SRC_TOP4, 20, 1),
-	MUX(0, "mout_user_aclk166", user_aclk166_p, SRC_TOP4, 24, 1),
-	MUX(0, "mout_user_aclk333", user_aclk333_p, SRC_TOP4, 28, 1),
-
-	MUX(0, "mout_aclk66_psgen", aclk66_peric_p, SRC_TOP5, 4, 1),
-	MUX(0, "mout_user_aclk333_g2d", user_aclk333_g2d_p, SRC_TOP5, 8, 1),
-	MUX(0, "mout_user_aclk266_g2d", user_aclk266_g2d_p, SRC_TOP5, 12, 1),
-	MUX_A(CLK_MOUT_G3D, "mout_user_aclk_g3d", user_aclk_g3d_p,
+	MUX(0, "mout_aclk66_peric", mout_aclk66_peric_p, SRC_TOP4, 8, 1),
+	MUX(0, "mout_user_aclk266", mout_user_aclk266_p, SRC_TOP4, 20, 1),
+	MUX(0, "mout_user_aclk166", mout_user_aclk166_p, SRC_TOP4, 24, 1),
+	MUX(0, "mout_user_aclk333", mout_user_aclk333_p, SRC_TOP4, 28, 1),
+
+	MUX(0, "mout_aclk66_psgen", mout_aclk66_peric_p, SRC_TOP5, 4, 1),
+	MUX(0, "mout_user_aclk333_g2d", mout_user_aclk333_g2d_p, SRC_TOP5,
+			8, 1),
+	MUX(0, "mout_user_aclk266_g2d", mout_user_aclk266_g2d_p, SRC_TOP5,
+			12, 1),
+	MUX_A(CLK_MOUT_G3D, "mout_user_aclk_g3d", mout_user_aclk_g3d_p,
 			SRC_TOP5, 16, 1, "aclkg3d"),
-	MUX(0, "mout_user_aclk300_jpeg", user_aclk300_jpeg_p,
+	MUX(0, "mout_user_aclk300_jpeg", mout_user_aclk300_jpeg_p,
 			SRC_TOP5, 20, 1),
-	MUX(0, "mout_user_aclk300_disp1", user_aclk300_disp1_p,
+	MUX(0, "mout_user_aclk300_disp1", mout_user_aclk300_disp1_p,
 			SRC_TOP5, 24, 1),
-	MUX(0, "mout_user_aclk300_gscl", user_aclk300_gscl_p,
+	MUX(0, "mout_user_aclk300_gscl", mout_user_aclk300_gscl_p,
 			SRC_TOP5, 28, 1),
 
-	MUX(0, "sclk_mpll", mpll_p, SRC_TOP6, 0, 1),
-	MUX(CLK_MOUT_VPLL, "sclk_vpll", vpll_p, SRC_TOP6, 4, 1),
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
+	MUX(0, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1),
+	MUX(CLK_MOUT_VPLL, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1),
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
+	MUX(0, "mout_sw_aclk200_fsys", mout_sw_aclk200_fsys_p,
+			SRC_TOP10, 28, 1),
+	MUX(0, "mout_sw_aclk333_432_gscl", mout_sw_aclk333_432_gscl_p,
 			SRC_TOP11, 0, 1),
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
+	MUX(0, "mout_sw_aclk66", mout_sw_aclk66_p, SRC_TOP11, 8, 1),
+	MUX(0, "mout_sw_aclk266", mout_sw_aclk266_p, SRC_TOP11, 20, 1),
+	MUX(0, "mout_sw_aclk166", mout_sw_aclk166_p, SRC_TOP11, 24, 1),
+	MUX(0, "mout_sw_aclk333", mout_sw_aclk333_p, SRC_TOP11, 28, 1),
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
+	MUX(0, "mout_sw_aclk300_gscl", mout_sw_aclk300_gscl_p,
+			SRC_TOP12, 28, 1),
 
 	/* DISP1 Block */
-	MUX(0, "mout_fimd1", group3_p, SRC_DISP10, 4, 1),
-	MUX(0, "mout_mipi1", group2_p, SRC_DISP10, 16, 3),
-	MUX(0, "mout_dp1", group2_p, SRC_DISP10, 20, 3),
-	MUX(0, "mout_pixel", group2_p, SRC_DISP10, 24, 3),
-	MUX(CLK_MOUT_HDMI, "mout_hdmi", hdmi_p, SRC_DISP10, 28, 1),
+	MUX(0, "mout_fimd1", mout_group3_p, SRC_DISP10, 4, 1),
+	MUX(0, "mout_mipi1", mout_group2_p, SRC_DISP10, 16, 3),
+	MUX(0, "mout_dp1", mout_group2_p, SRC_DISP10, 20, 3),
+	MUX(0, "mout_pixel", mout_group2_p, SRC_DISP10, 24, 3),
+	MUX(CLK_MOUT_HDMI, "mout_hdmi", mout_hdmi_p, SRC_DISP10, 28, 1),
 
 	/* MAU Block */
-	MUX(0, "mout_maudio0", maudio0_p, SRC_MAU, 28, 3),
+	MUX(0, "mout_maudio0", mout_maudio0_p, SRC_MAU, 28, 3),
 
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
+	MUX(0, "mout_spi0", mout_group2_p, SRC_PERIC1, 20, 3),
+	MUX(0, "mout_spi1", mout_group2_p, SRC_PERIC1, 24, 3),
+	MUX(0, "mout_spi2", mout_group2_p, SRC_PERIC1, 28, 3),
 };
 
 static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
 	DIV(0, "div_arm", "mout_cpu", DIV_CPU0, 0, 3),
 	DIV(0, "sclk_apll", "mout_apll", DIV_CPU0, 24, 3),
 	DIV(0, "armclk2", "div_arm", DIV_CPU0, 28, 3),
-	DIV(0, "div_kfc", "mout_cpu_kfc", DIV_KFC0, 0, 3),
+	DIV(0, "div_kfc", "mout_kfc", DIV_KFC0, 0, 3),
 	DIV(0, "sclk_kpll", "mout_kpll", DIV_KFC0, 24, 3),
 
 	DIV(0, "dout_aclk400_mscl", "mout_aclk400_mscl", DIV_TOP0, 4, 3),
-- 
1.7.9.5
