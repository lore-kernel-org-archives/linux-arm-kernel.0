From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Thu, 08 May 2014 16:57:58 +0530
Subject: [PATCH v5 09/15] clk: exynos5420: update clocks for WCORE block
In-Reply-To: <1399548484-20626-1-git-send-email-shaik.ameer@samsung.com>
References: <1399548484-20626-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1399548484-20626-10-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds missing clocks for WCORE block.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index b87c58e..d37592d 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -89,6 +89,7 @@
 #define GATE_BUS_PERIC1		0x10754
 #define GATE_BUS_PERIS0		0x10760
 #define GATE_BUS_PERIS1		0x10764
+#define GATE_BUS_NOC		0x10770
 #define GATE_TOP_SCLK_ISP	0x10870
 #define GATE_IP_GSCL0		0x10910
 #define GATE_IP_GSCL1		0x10920
@@ -180,6 +181,7 @@ static unsigned long exynos5420_clk_regs[] __initdata = {
 	GATE_BUS_PERIC1,
 	GATE_BUS_PERIS0,
 	GATE_BUS_PERIS1,
+	GATE_BUS_NOC,
 	GATE_TOP_SCLK_ISP,
 	GATE_IP_GSCL0,
 	GATE_IP_GSCL1,
@@ -271,6 +273,13 @@ PNAME(mout_user_aclk200_fsys_p)	= {"fin_pll", "mout_sw_aclk200_fsys"};
 
 PNAME(mout_sw_aclk200_fsys2_p) = {"dout_aclk200_fsys2", "mout_sclk_spll"};
 PNAME(mout_user_aclk200_fsys2_p) = {"fin_pll", "mout_sw_aclk200_fsys2"};
+PNAME(mout_sw_aclk100_noc_p) = {"dout_aclk100_noc", "mout_sclk_spll"};
+PNAME(mout_user_aclk100_noc_p) = {"fin_pll", "mout_sw_aclk100_noc"};
+
+PNAME(mout_sw_aclk400_wcore_p) = {"dout_aclk400_wcore", "mout_sclk_spll"};
+PNAME(mout_aclk400_wcore_bpll_p) = {"mout_aclk400_wcore", "sclk_bpll"};
+PNAME(mout_user_aclk400_wcore_p) = {"fin_pll", "mout_sw_aclk400_wcore"};
+
 PNAME(mout_sw_aclk400_isp_p) = {"dout_aclk400_isp", "mout_sclk_spll"};
 PNAME(mout_user_aclk400_isp_p) = {"fin_pll", "mout_sw_aclk400_isp"};
 
@@ -370,6 +379,8 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 			SRC_TOP0, 4, 2, "aclk400_mscl"),
 	MUX(0, "mout_aclk200", mout_group1_p, SRC_TOP0, 8, 2),
 	MUX(0, "mout_aclk200_fsys2", mout_group1_p, SRC_TOP0, 12, 2),
+	MUX(0, "mout_aclk400_wcore", mout_group1_p, SRC_TOP0, 16, 2),
+	MUX(0, "mout_aclk100_noc", mout_group1_p, SRC_TOP0, 20, 2),
 	MUX(0, "mout_aclk200_fsys", mout_group1_p, SRC_TOP0, 28, 2),
 
 	MUX(0, "mout_aclk333_432_gscl", mout_group4_p, SRC_TOP1, 0, 2),
@@ -397,6 +408,10 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 			SRC_TOP3, 8, 1),
 	MUX(0, "mout_user_aclk200_fsys2", mout_user_aclk200_fsys2_p,
 			SRC_TOP3, 12, 1),
+	MUX(0, "mout_user_aclk400_wcore", mout_user_aclk400_wcore_p,
+			SRC_TOP3, 16, 1),
+	MUX(0, "mout_user_aclk100_noc", mout_user_aclk100_noc_p,
+			SRC_TOP3, 20, 1),
 	MUX(0, "mout_user_aclk200_fsys", mout_user_aclk200_fsys_p,
 			SRC_TOP3, 28, 1),
 
@@ -447,6 +462,10 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 	MUX(0, "mout_sw_aclk200", mout_sw_aclk200_p, SRC_TOP10, 8, 1),
 	MUX(0, "mout_sw_aclk200_fsys2", mout_sw_aclk200_fsys2_p,
 			SRC_TOP10, 12, 1),
+	MUX(0, "mout_sw_aclk400_wcore", mout_sw_aclk400_wcore_p,
+			SRC_TOP10, 16, 1),
+	MUX(0, "mout_sw_aclk100_noc", mout_sw_aclk100_noc_p,
+			SRC_TOP10, 20, 1),
 	MUX(0, "mout_sw_aclk200_fsys", mout_sw_aclk200_fsys_p,
 			SRC_TOP10, 28, 1),
 
@@ -482,6 +501,9 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 	MUX(0, "mout_pixel", mout_group2_p, SRC_DISP10, 24, 3),
 	MUX(CLK_MOUT_HDMI, "mout_hdmi", mout_hdmi_p, SRC_DISP10, 28, 1),
 	MUX(0, "mout_fimd1_opt", mout_group2_p, SRC_DISP10, 8, 3),
+
+	MUX(0, "mout_aclk400_wcore_bpll", mout_aclk400_wcore_bpll_p,
+			TOP_SPARE2, 4, 1),
 	MUX(0, "mout_fimd1_final", mout_fimd1_final_p, TOP_SPARE2, 8, 1),
 
 	/* MAU Block */
@@ -528,6 +550,9 @@ static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
 	DIV(0, "dout_aclk400_mscl", "mout_aclk400_mscl", DIV_TOP0, 4, 3),
 	DIV(0, "dout_aclk200", "mout_aclk200", DIV_TOP0, 8, 3),
 	DIV(0, "dout_aclk200_fsys2", "mout_aclk200_fsys2", DIV_TOP0, 12, 3),
+	DIV(0, "dout_aclk400_wcore", "mout_aclk400_wcore_bpll",
+			DIV_TOP0, 16, 3),
+	DIV(0, "dout_aclk100_noc", "mout_aclk100_noc", DIV_TOP0, 20, 3),
 	DIV(0, "dout_pclk200_fsys", "mout_pclk200_fsys", DIV_TOP0, 24, 3),
 	DIV(0, "dout_aclk200_fsys", "mout_aclk200_fsys", DIV_TOP0, 28, 3),
 
-- 
1.7.9.5
