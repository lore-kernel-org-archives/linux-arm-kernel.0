From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Oct 2017 15:23:56 +0200
Subject: [PATCH v3 5/6] clk: renesas: r8a7796: Add Z clock
In-Reply-To: <1507209837-16938-1-git-send-email-horms+renesas@verge.net.au>
References: <1507209837-16938-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1507209837-16938-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds Z clock for R8A7796 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/renesas/r8a7796-cpg-mssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/r8a7796-cpg-mssr.c b/drivers/clk/renesas/r8a7796-cpg-mssr.c
index e5e7fb212288..e8d5e75afc65 100644
--- a/drivers/clk/renesas/r8a7796-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7796-cpg-mssr.c
@@ -74,6 +74,7 @@ static const struct cpg_core_clk r8a7796_core_clks[] __initconst = {
 	DEF_FIXED(".sdsrc",     CLK_SDSRC,         CLK_PLL1_DIV2,  2, 1),
 
 	/* Core Clock Outputs */
+	DEF_BASE("z",           R8A7796_CLK_Z,     CLK_TYPE_GEN3_Z, CLK_PLL0),
 	DEF_FIXED("ztr",        R8A7796_CLK_ZTR,   CLK_PLL1_DIV2,  6, 1),
 	DEF_FIXED("ztrd2",      R8A7796_CLK_ZTRD2, CLK_PLL1_DIV2, 12, 1),
 	DEF_FIXED("zt",         R8A7796_CLK_ZT,    CLK_PLL1_DIV2,  4, 1),
-- 
2.1.4
