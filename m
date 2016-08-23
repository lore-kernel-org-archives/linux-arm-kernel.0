From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 23 Aug 2016 09:49:44 +0200
Subject: [PATCH/RFT v2 2/8] clk: renesas: r8a7796: Add SDIF clocks
In-Reply-To: <1471938590-10650-1-git-send-email-horms+renesas@verge.net.au>
References: <1471938590-10650-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1471938590-10650-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds SDIF clocks for R8A7796 SoC.

Based on work by Ai Kyuse and Yoshihiro Shimoda for the r8a7795 SoC.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2
* Add and use SDSRC
---
 drivers/clk/renesas/r8a7796-cpg-mssr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/renesas/r8a7796-cpg-mssr.c b/drivers/clk/renesas/r8a7796-cpg-mssr.c
index 999955c2b23e..891b353e8105 100644
--- a/drivers/clk/renesas/r8a7796-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7796-cpg-mssr.c
@@ -70,6 +70,7 @@ static const struct cpg_core_clk r8a7796_core_clks[] __initconst = {
 	DEF_FIXED(".s1",        CLK_S1,            CLK_PLL1_DIV2,  3, 1),
 	DEF_FIXED(".s2",        CLK_S2,            CLK_PLL1_DIV2,  4, 1),
 	DEF_FIXED(".s3",        CLK_S3,            CLK_PLL1_DIV2,  6, 1),
+	DEF_FIXED(".sdsrc",     CLK_SDSRC,         CLK_PLL1_DIV2,  2, 1),
 
 	/* Core Clock Outputs */
 	DEF_FIXED("ztr",        R8A7796_CLK_ZTR,   CLK_PLL1_DIV2,  6, 1),
@@ -93,6 +94,11 @@ static const struct cpg_core_clk r8a7796_core_clks[] __initconst = {
 	DEF_FIXED("s3d2",       R8A7796_CLK_S3D2,  CLK_S3,         2, 1),
 	DEF_FIXED("s3d4",       R8A7796_CLK_S3D4,  CLK_S3,         4, 1),
 
+	DEF_GEN3_SD("sd0",      R8A7796_CLK_SD0,   CLK_SDSRC,    0x0074),
+	DEF_GEN3_SD("sd1",      R8A7796_CLK_SD1,   CLK_SDSRC,    0x0078),
+	DEF_GEN3_SD("sd2",      R8A7796_CLK_SD2,   CLK_SDSRC,    0x0268),
+	DEF_GEN3_SD("sd3",      R8A7796_CLK_SD3,   CLK_SDSRC,    0x026c),
+
 	DEF_FIXED("cl",         R8A7796_CLK_CL,    CLK_PLL1_DIV2, 48, 1),
 	DEF_FIXED("cp",         R8A7796_CLK_CP,    CLK_EXTAL,      2, 1),
 
@@ -104,6 +110,10 @@ static const struct cpg_core_clk r8a7796_core_clks[] __initconst = {
 
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
