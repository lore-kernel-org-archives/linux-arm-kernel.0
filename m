From: yuantian.tang@nxp.com (yuantian.tang at nxp.com)
Date: Thu, 24 Nov 2016 10:36:55 +0800
Subject: [PATCH v3] clk: qoriq: added ls1012a clock configuration
Message-ID: <1479955015-37514-1-git-send-email-yuantian.tang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tang Yuantian <Yuantian.Tang@nxp.com>

Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
---
v3:
  - rebased to latest kernel and re-sorted the code
v2:
  - remove commit message as it is duplicated to title
 drivers/clk/clk-qoriq.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 7dd4351..697310e 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -291,6 +291,14 @@ static const struct clockgen_muxinfo ls1046a_hwa2 = {
 	},
 };
 
+static const struct clockgen_muxinfo ls1012a_cmux = {
+	{
+		[0] = { CLKSEL_VALID, CGA_PLL1, PLL_DIV1 },
+		{},
+		[2] = { CLKSEL_VALID, CGA_PLL1, PLL_DIV2 },
+	}
+};
+
 static const struct clockgen_muxinfo t1023_hwa1 = {
 	{
 		{},
@@ -529,6 +537,16 @@ static const struct clockgen_chipinfo chipinfo[] = {
 		.flags = CG_PLL_8BIT,
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
 		.compat = "fsl,ls2080a-clockgen",
 		.cmux_groups = {
 			&clockgen2_cmux_cga12, &clockgen2_cmux_cgb
@@ -1316,6 +1334,7 @@ CLK_OF_DECLARE(qoriq_clockgen_2, "fsl,qoriq-clockgen-2.0", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1021a, "fsl,ls1021a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1043a, "fsl,ls1043a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1046a, "fsl,ls1046a-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_ls1012a, "fsl,ls1012a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls2080a, "fsl,ls2080a-clockgen", clockgen_init);
 
 /* Legacy nodes */
-- 
2.1.0.27.g96db324
