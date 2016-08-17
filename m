From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 17 Aug 2016 13:31:51 +0200
Subject: [PATCH/RTF 2/7] clk: renesas: r8a7796: Add SDIF clocks
In-Reply-To: <1471433516-4478-1-git-send-email-horms+renesas@verge.net.au>
References: <1471433516-4478-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1471433516-4478-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ai Kyuse <ai.kyuse.uw@renesas.com>

This patch adds SDIF clocks for R8A7796 SoC.

Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/clk/renesas/r8a7796-cpg-mssr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/renesas/r8a7796-cpg-mssr.c b/drivers/clk/renesas/r8a7796-cpg-mssr.c
index 999955c2b23e..4c390a8bc3e1 100644
--- a/drivers/clk/renesas/r8a7796-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7796-cpg-mssr.c
@@ -93,6 +93,11 @@ static const struct cpg_core_clk r8a7796_core_clks[] __initconst = {
 	DEF_FIXED("s3d2",       R8A7796_CLK_S3D2,  CLK_S3,         2, 1),
 	DEF_FIXED("s3d4",       R8A7796_CLK_S3D4,  CLK_S3,         4, 1),
 
+	DEF_GEN3_SD("sd0",      R8A7796_CLK_SD0,   CLK_PLL1_DIV4, 0x0074),
+	DEF_GEN3_SD("sd1",      R8A7796_CLK_SD1,   CLK_PLL1_DIV4, 0x0078),
+	DEF_GEN3_SD("sd2",      R8A7796_CLK_SD2,   CLK_PLL1_DIV4, 0x0268),
+	DEF_GEN3_SD("sd3",      R8A7796_CLK_SD3,   CLK_PLL1_DIV4, 0x026c),
+
 	DEF_FIXED("cl",         R8A7796_CLK_CL,    CLK_PLL1_DIV2, 48, 1),
 	DEF_FIXED("cp",         R8A7796_CLK_CP,    CLK_EXTAL,      2, 1),
 
@@ -104,6 +109,10 @@ static const struct cpg_core_clk r8a7796_core_clks[] __initconst = {
 
 static const struct mssr_mod_clk r8a7796_mod_clks[] __initconst = {
 	DEF_MOD("scif2",		 310,	R8A7796_CLK_S3D4),
+	DEF_MOD("sdif3",		 311,	R8A7796_CLK_SD3),
+	DEF_MOD("sdif2",		 312,	R8A7796_CLK_SD2),
+	DEF_MOD("sdif1",		 313,	R8A7796_CLK_SD1),
+	DEF_MOD("sdif0",		 314,	R8A7796_CLK_SD0),
 	DEF_MOD("rwdt0",		 402,	R8A7796_CLK_R),
 	DEF_MOD("intc-ap",		 408,	R8A7796_CLK_S3D1),
 	DEF_MOD("gpio7",		 905,	R8A7796_CLK_S3D4),
-- 
2.7.0.rc3.207.g0ac5344
