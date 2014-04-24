From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Thu, 24 Apr 2014 18:33:45 +0530
Subject: [PATCH v3 09/16] clk: exynos5420: update clocks for WCORE block
In-Reply-To: <1398344632-18623-1-git-send-email-shaik.ameer@samsung.com>
References: <1398344632-18623-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1398344632-18623-10-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds missing clocks from WCORE block.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 6ad87d1..d9996dd 100755
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
 
@@ -486,6 +495,18 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 	MUX(0, "mout_spi0", mout_group2_p, SRC_PERIC1, 20, 3),
 	MUX(0, "mout_spi1", mout_group2_p, SRC_PERIC1, 24, 3),
 	MUX(0, "mout_spi2", mout_group2_p, SRC_PERIC1, 28, 3),
+	MUX(0, "mout_aclk100_noc", mout_group1_p, SRC_TOP0, 20, 2),
+	MUX(0, "mout_sw_aclk100_noc", mout_sw_aclk100_noc_p,
+		SRC_TOP10, 20, 1),
+	MUX(0, "mout_user_aclk100_noc", mout_user_aclk100_noc_p,
+		SRC_TOP3, 20, 1),
+	MUX(0, "mout_aclk400_wcore", mout_group1_p, SRC_TOP0, 16, 2),
+	MUX(0, "mout_aclk400_wcore_bpll", mout_aclk400_wcore_bpll_p,
+		TOP_SPARE2, 4, 1),
+	MUX(0, "mout_sw_aclk400_wcore", mout_sw_aclk400_wcore_p,
+		SRC_TOP10, 16, 1),
+	MUX(0, "mout_user_aclk400_wcore", mout_user_aclk400_wcore_p,
+		SRC_TOP3, 16, 1),
 	MUX(0, "mout_aclk400_isp", mout_group1_p, SRC_TOP0, 0, 2),
 	MUX(0, "mout_sw_aclk400_isp", mout_sw_aclk400_isp_p,
 		SRC_TOP10, 0, 1),
@@ -553,6 +574,10 @@ static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
 	DIV(0, "dout_disp1_blk", "aclk200_disp1", DIV2_RATIO0, 16, 2),
 	DIV(0, "dout_aclk400_disp1", "mout_aclk400_disp1", DIV_TOP2, 4, 3),
 
+	DIV(0, "dout_aclk100_noc", "mout_aclk100_noc", DIV_TOP0, 20, 3),
+	DIV(0, "dout_aclk400_wcore", "mout_aclk400_wcore_bpll",
+		DIV_TOP0, 16, 3),
+
 	/* Audio Block */
 	DIV(0, "dout_maudio0", "mout_maudio0", DIV_MAU, 20, 4),
 	DIV(0, "dout_maupcm0", "dout_maudio0", DIV_MAU, 24, 8),
@@ -867,6 +892,9 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 			GATE_IP_MSCL, 10, 0, 0),
 	GATE(CLK_SMMU_MIXER, "smmu_mixer", "aclk200_disp1",
 			GATE_IP_DISP1, 9, 0, 0),
+	/* aclk266 also gates other IPs in psgen. It should not be gated. */
+	GATE(0, "aclk266", "mout_user_aclk266",
+			GATE_BUS_NOC, 22, CLK_IGNORE_UNUSED, 0),
 	GATE(0, "aclk200_disp1", "mout_user_aclk200_disp1",
 			GATE_BUS_TOP, 18, CLK_IGNORE_UNUSED, 0),
 	GATE(0, "aclk300_disp1", "mout_user_aclk300_disp1",
-- 
1.7.9.5
