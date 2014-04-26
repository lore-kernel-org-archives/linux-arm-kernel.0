From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Sun, 27 Apr 2014 02:08:42 +0530
Subject: [PATCH RFC 2/8] clk: exynos5420: Add aliases for clocks used by
 devfreq
In-Reply-To: <1398544728-2075-1-git-send-email-a.kesavan@samsung.com>
References: <1398544728-2075-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1398544728-2075-3-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Arjun.K.V" <arjun.kv@samsung.com>

Devfreq does not support DT-based lookup of these peripheral clocks,
so add aliases for them.

Signed-off-by: Arun Kumar K <arun.kk@samsung.com>
Signed-off-by: Arjun.K.V <arjun.kv@samsung.com>
Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 77 ++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 6dfd3fd..d3908c8 100755
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -400,20 +400,24 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 	MUX_A(0, "mout_aclk400_mscl", mout_group1_p,
 			SRC_TOP0, 4, 2, "aclk400_mscl"),
 	MUX(0, "mout_aclk200", mout_group1_p, SRC_TOP0, 8, 2),
-	MUX(0, "mout_aclk200_fsys2", mout_group1_p, SRC_TOP0, 12, 2),
-	MUX(0, "mout_aclk200_fsys", mout_group1_p, SRC_TOP0, 28, 2),
+	MUX_A(0, "mout_aclk200_fsys2", mout_group1_p,
+			SRC_TOP0, 12, 2, "aclk200_fsys2"),
+	MUX_A(0, "mout_aclk200_fsys", mout_group1_p,
+			SRC_TOP0, 28, 2, "aclk200_fsys"),
 
 	MUX(0, "mout_aclk333_432_gscl", mout_group4_p, SRC_TOP1, 0, 2),
-	MUX(0, "mout_aclk66", mout_group1_p, SRC_TOP1, 8, 2),
-	MUX(0, "mout_aclk266", mout_group1_p, SRC_TOP1, 20, 2),
-	MUX(0, "mout_aclk166", mout_group1_p, SRC_TOP1, 24, 2),
+	MUX_A(0, "mout_aclk66", mout_group1_p, SRC_TOP1, 8, 2, "aclk66"),
+	MUX_A(0, "mout_aclk266", mout_group1_p, SRC_TOP1, 20, 2, "aclk266"),
+	MUX_A(0, "mout_aclk166", mout_group1_p, SRC_TOP1, 24, 2, "aclk166"),
 	MUX(0, "mout_aclk333", mout_group1_p, SRC_TOP1, 28, 2),
 
 	MUX(0, "mout_aclk333_g2d", mout_group1_p, SRC_TOP2, 8, 2),
 	MUX(0, "mout_aclk266_g2d", mout_group1_p, SRC_TOP2, 12, 2),
 	MUX(0, "mout_aclk_g3d", mout_group5_p, SRC_TOP2, 16, 1),
-	MUX(0, "mout_aclk300_jpeg", mout_group1_p, SRC_TOP2, 20, 2),
-	MUX(0, "mout_aclk300_disp1", mout_group1_p, SRC_TOP2, 24, 2),
+	MUX_A(0, "mout_aclk300_jpeg", mout_group1_p, SRC_TOP2, 20, 2,
+			"aclk300_jpeg"),
+	MUX_A(0, "mout_aclk300_disp1", mout_group1_p, SRC_TOP2, 24, 2,
+			"aclk300_disp1"),
 	MUX(0, "mout_aclk300_gscl", mout_group1_p, SRC_TOP2, 28, 2),
 
 	MUX(0, "mout_user_aclk400_mscl", mout_user_aclk400_mscl_p,
@@ -448,14 +452,14 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 	MUX(0, "mout_user_aclk300_gscl", mout_user_aclk300_gscl_p,
 			SRC_TOP5, 28, 1),
 
-	MUX(0, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1),
+	MUX_A(0, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1, "mout_mpll"),
 	MUX(CLK_MOUT_VPLL, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1),
-	MUX(0, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
-	MUX(0, "mout_sclk_ipll", mout_ipll_p, SRC_TOP6, 12, 1),
+	MUX_A(0, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1, "mout_spll"),
+	MUX_A(0, "mout_sclk_ipll", mout_ipll_p, SRC_TOP6, 12, 1, "mout_ipll"),
 	MUX(0, "mout_sclk_rpll", mout_rpll_p, SRC_TOP6, 16, 1),
 	MUX(0, "mout_sclk_epll", mout_epll_p, SRC_TOP6, 20, 1),
-	MUX(0, "mout_sclk_dpll", mout_dpll_p, SRC_TOP6, 24, 1),
-	MUX(0, "mout_sclk_cpll", mout_cpll_p, SRC_TOP6, 28, 1),
+	MUX_A(0, "mout_sclk_dpll", mout_dpll_p, SRC_TOP6, 24, 1, "mout_dpll"),
+	MUX_A(0, "mout_sclk_cpll", mout_cpll_p, SRC_TOP6, 28, 1, "mout_cpll"),
 
 	MUX(0, "mout_sw_aclk400_mscl", mout_sw_aclk400_mscl_p,
 			SRC_TOP10, 4, 1),
@@ -525,24 +529,28 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 		SRC_TOP7, 4, 1),
 	MUX_F(0, "mout_mau_epll_clk", mout_mau_epll_clk_p, SRC_TOP7, 20, 2,
 		CLK_SET_RATE_PARENT, 0),
-	MUX(0, "mout_pclk200_fsys", mout_group1_p, SRC_TOP0, 24, 2),
+	MUX_A(0, "mout_pclk200_fsys", mout_group1_p,
+		SRC_TOP0, 24, 2, "pclk200_fsys"),
 	MUX(0, "mout_sw_pclk200_fsys", mout_sw_pclk200_fsys_p,
 		SRC_TOP10, 24, 1),
 	MUX(0, "mout_user_pclk200_fsys", mout_user_pclk200_fsys_p,
 		SRC_TOP3, 24, 1),
-	MUX(0, "mout_aclk100_noc", mout_group1_p, SRC_TOP0, 20, 2),
+	MUX_A(0, "mout_aclk100_noc", mout_group1_p,
+		SRC_TOP0, 20, 2, "aclk100_noc"),
 	MUX(0, "mout_sw_aclk100_noc", mout_sw_aclk100_noc_p,
 		SRC_TOP10, 20, 1),
 	MUX(0, "mout_user_aclk100_noc", mout_user_aclk100_noc_p,
 		SRC_TOP3, 20, 1),
-	MUX(0, "mout_aclk400_wcore", mout_group1_p, SRC_TOP0, 16, 2),
+	MUX_A(0, "mout_aclk400_wcore", mout_group1_p,
+		SRC_TOP0, 16, 2, "aclk400_wcore"),
 	MUX(0, "mout_aclk400_wcore_bpll", mout_aclk400_wcore_bpll_p,
 		TOP_SPARE2, 4, 1),
 	MUX(0, "mout_sw_aclk400_wcore", mout_sw_aclk400_wcore_p,
 		SRC_TOP10, 16, 1),
 	MUX(0, "mout_user_aclk400_wcore", mout_user_aclk400_wcore_p,
 		SRC_TOP3, 16, 1),
-	MUX(0, "mout_aclk400_isp", mout_group1_p, SRC_TOP0, 0, 2),
+	MUX_A(0, "mout_aclk400_isp", mout_group1_p,
+		SRC_TOP0, 0, 2, "aclk400_isp"),
 	MUX(0, "mout_sw_aclk400_isp", mout_sw_aclk400_isp_p,
 		SRC_TOP10, 0, 1),
 	MUX(0, "mout_user_aclk400_isp", mout_user_aclk400_isp_p,
@@ -560,7 +568,8 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 		SRC_TOP4, 4, 1),
 	MUX(0, "mout_user_aclk266_isp", mout_user_aclk266_isp_p,
 		SRC_TOP4, 16, 1),
-	MUX(0, "mout_aclk400_disp1", mout_group1_p, SRC_TOP2, 4, 2),
+	MUX_A(0, "mout_aclk400_disp1", mout_group1_p,
+		SRC_TOP2, 4, 2, "aclk400_disp1"),
 	MUX(0, "mout_sw_aclk400_disp1", mout_sw_aclk400_disp1_p,
 		SRC_TOP12, 4, 1),
 	MUX(0, "mout_user_aclk400_disp1", mout_user_aclk400_disp1_p,
@@ -581,24 +590,30 @@ static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
 	DIV(0, "dout_kfc", "mout_kfc", DIV_KFC0, 0, 3),
 	DIV(0, "sclk_kpll", "mout_kpll", DIV_KFC0, 24, 3),
 
-	DIV(0, "dout_aclk400_mscl", "mout_aclk400_mscl", DIV_TOP0, 4, 3),
+	DIV_A(0, "dout_aclk400_mscl", "mout_aclk400_mscl",
+			DIV_TOP0, 4, 3, "aclk400_mscl_d"),
 	DIV(0, "dout_aclk200", "mout_aclk200", DIV_TOP0, 8, 3),
-	DIV(0, "dout_aclk200_fsys2", "mout_aclk200_fsys2", DIV_TOP0, 12, 3),
-	DIV(0, "dout_pclk200_fsys", "mout_pclk200_fsys", DIV_TOP0, 24, 3),
-	DIV(0, "dout_aclk200_fsys", "mout_aclk200_fsys", DIV_TOP0, 28, 3),
+	DIV_A(0, "dout_aclk200_fsys2", "mout_aclk200_fsys2",
+			DIV_TOP0, 12, 3, "aclk200_fsys2_d"),
+	DIV_A(0, "dout_pclk200_fsys", "mout_pclk200_fsys",
+			DIV_TOP0, 24, 3, "pclk200_fsys_d"),
+	DIV_A(0, "dout_aclk200_fsys", "mout_aclk200_fsys",
+			DIV_TOP0, 28, 3, "aclk200_fsys_d"),
 
 	DIV(0, "dout_aclk333_432_gscl", "mout_aclk333_432_gscl",
 			DIV_TOP1, 0, 3),
-	DIV(0, "dout_aclk66", "mout_aclk66", DIV_TOP1, 8, 6),
-	DIV(0, "dout_aclk266", "mout_aclk266", DIV_TOP1, 20, 3),
-	DIV(0, "dout_aclk166", "mout_aclk166", DIV_TOP1, 24, 3),
+	DIV_A(0, "dout_aclk66", "mout_aclk66", DIV_TOP1, 8, 6, "aclk66_d"),
+	DIV_A(0, "dout_aclk266", "mout_aclk266", DIV_TOP1, 20, 3, "aclk266_d"),
+	DIV_A(0, "dout_aclk166", "mout_aclk166", DIV_TOP1, 24, 3, "aclk166_d"),
 	DIV(0, "dout_aclk333", "mout_aclk333", DIV_TOP1, 28, 3),
 
 	DIV(0, "dout_aclk333_g2d", "mout_aclk333_g2d", DIV_TOP2, 8, 3),
 	DIV(0, "dout_aclk266_g2d", "mout_aclk266_g2d", DIV_TOP2, 12, 3),
 	DIV(0, "dout_aclk_g3d", "mout_aclk_g3d", DIV_TOP2, 16, 3),
-	DIV(0, "dout_aclk300_jpeg", "mout_aclk300_jpeg", DIV_TOP2, 20, 3),
-	DIV(0, "dout_aclk300_disp1", "mout_aclk300_disp1", DIV_TOP2, 24, 3),
+	DIV_A(0, "dout_aclk300_jpeg", "mout_aclk300_jpeg",
+			DIV_TOP2, 20, 3, "aclk300_jpeg_d"),
+	DIV_A(0, "dout_aclk300_disp1", "mout_aclk300_disp1",
+			DIV_TOP2, 24, 3, "aclk300_disp1_d"),
 	DIV(0, "dout_aclk300_gscl", "mout_aclk300_gscl", DIV_TOP2, 28, 3),
 
 	/* DISP1 Block */
@@ -607,11 +622,13 @@ static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
 	DIV(0, "dout_dp1", "mout_dp1", DIV_DISP10, 24, 4),
 	DIV(CLK_DOUT_PIXEL, "dout_hdmi_pixel", "mout_pixel", DIV_DISP10, 28, 4),
 	DIV(0, "dout_disp1_blk", "aclk200_disp1", DIV2_RATIO0, 16, 2),
-	DIV(0, "dout_aclk400_disp1", "mout_aclk400_disp1", DIV_TOP2, 4, 3),
+	DIV_A(0, "dout_aclk400_disp1", "mout_aclk400_disp1",
+			DIV_TOP2, 4, 3, "aclk400_disp1_d"),
 
-	DIV(0, "dout_aclk100_noc", "mout_aclk100_noc", DIV_TOP0, 20, 3),
-	DIV(0, "dout_aclk400_wcore", "mout_aclk400_wcore_bpll",
-		DIV_TOP0, 16, 3),
+	DIV_A(0, "dout_aclk100_noc", "mout_aclk100_noc",
+			DIV_TOP0, 20, 3, "aclk100_noc_d"),
+	DIV_A(0, "dout_aclk400_wcore", "mout_aclk400_wcore_bpll",
+			DIV_TOP0, 16, 3, "aclk400_wcore_d"),
 
 	/* Audio Block */
 	DIV(0, "dout_maudio0", "mout_maudio0", DIV_MAU, 20, 4),
-- 
1.8.3.2
