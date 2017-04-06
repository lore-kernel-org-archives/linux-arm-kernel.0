From: andy.tang@nxp.com (Yuantian Tang)
Date: Thu, 6 Apr 2017 10:21:22 +0800
Subject: [PATCH 1/2] clk: qoriq: add clock configuration for ls1088a soc
Message-ID: <1491445283-13053-1-git-send-email-andy.tang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock on ls1088a chip takes primary clocking input from the external
SYSCLK signal. The SYSCLK input (frequency) is multiplied using
multiple phase locked loops (PLL) to create a variety of frequencies
which can then be passed to a variety of internal logic, including
cores and peripheral IP modules.

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
---
 drivers/clk/clk-qoriq.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index f3931e3..62cf32f 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -537,6 +537,17 @@ static const struct clockgen_chipinfo chipinfo[] = {
 		.flags = CG_PLL_8BIT,
 	},
 	{
+		.compat = "fsl,ls1088a-clockgen",
+		.cmux_groups = {
+			&clockgen2_cmux_cga12
+		},
+		.cmux_to_group = {
+			0, 0, -1
+		},
+		.pll_mask = 0x07,
+		.flags = CG_VER3 | CG_LITTLE_ENDIAN,
+	},
+	{
 		.compat = "fsl,ls1012a-clockgen",
 		.cmux_groups = {
 			&ls1012a_cmux
@@ -1398,6 +1409,7 @@ CLK_OF_DECLARE(qoriq_clockgen_ls1012a, "fsl,ls1012a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1021a, "fsl,ls1021a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1043a, "fsl,ls1043a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1046a, "fsl,ls1046a-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_ls1088a, "fsl,ls1088a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls2080a, "fsl,ls2080a-clockgen", clockgen_init);
 
 /* Legacy nodes */
-- 
2.1.0.27.g96db324
