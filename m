From: yuantian.tang@nxp.com (yuantian.tang at nxp.com)
Date: Wed, 16 Nov 2016 13:58:20 +0800
Subject: [PATCH] clk: qoriq: added ls1012a clock configuration
Message-ID: <1479275900-42365-1-git-send-email-yuantian.tang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tang Yuantian <Yuantian.Tang@nxp.com>

Added ls1012a clock configuation information.

Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
---
 drivers/clk/clk-qoriq.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 1bece0f..563d874 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -202,6 +202,14 @@ static const struct clockgen_muxinfo ls1021a_cmux = {
 	}
 };
 
+static const struct clockgen_muxinfo ls1012a_cmux = {
+	{
+		[0] = { CLKSEL_VALID, CGA_PLL1, PLL_DIV1 },
+		{},
+		[2] = { CLKSEL_VALID, CGA_PLL1, PLL_DIV2 },
+	}
+};
+
 static const struct clockgen_muxinfo t1040_cmux = {
 	{
 		[0] = { CLKSEL_VALID, CGA_PLL1, PLL_DIV1 },
@@ -482,6 +490,16 @@ static const struct clockgen_chipinfo chipinfo[] = {
 		.pll_mask = 0x03,
 	},
 	{
+		.compat = "fsl,ls1012a-clockgen",
+		.cmux_groups = {
+			&ls1012a_cmux
+		},
+		.cmux_to_group = {
+			0, -1
+		},
+		.pll_mask = 0x03,
+	},
+	{
 		.compat = "fsl,ls1043a-clockgen",
 		.init_periph = t2080_init_periph,
 		.cmux_groups = {
@@ -1284,6 +1302,7 @@ CLK_OF_DECLARE(qoriq_clockgen_2, "fsl,qoriq-clockgen-2.0", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1021a, "fsl,ls1021a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1043a, "fsl,ls1043a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls2080a, "fsl,ls2080a-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_ls1012a, "fsl,ls1012a-clockgen", clockgen_init);
 
 /* Legacy nodes */
 CLK_OF_DECLARE(qoriq_sysclk_1, "fsl,qoriq-sysclk-1.0", sysclk_init);
-- 
2.1.0.27.g96db324
