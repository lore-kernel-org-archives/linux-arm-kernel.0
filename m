From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  3 Jan 2018 13:18:40 +0100
Subject: [PATCH v4 6/6] clk: renesas: r8a7796: Add Z2 clock
In-Reply-To: <20180103121840.29316-1-horms+renesas@verge.net.au>
References: <20180103121840.29316-1-horms+renesas@verge.net.au>
Message-ID: <20180103121840.29316-7-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds Z2 clock for R8A7796 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/renesas/r8a7796-cpg-mssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/r8a7796-cpg-mssr.c b/drivers/clk/renesas/r8a7796-cpg-mssr.c
index 82b444ac66c6..83a68e51e4ec 100644
--- a/drivers/clk/renesas/r8a7796-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7796-cpg-mssr.c
@@ -75,6 +75,7 @@ static const struct cpg_core_clk r8a7796_core_clks[] __initconst = {
 
 	/* Core Clock Outputs */
 	DEF_BASE("z",           R8A7796_CLK_Z,     CLK_TYPE_GEN3_Z, CLK_PLL0),
+	DEF_BASE("z2",          R8A7796_CLK_Z2,    CLK_TYPE_GEN3_Z2, CLK_PLL2),
 	DEF_FIXED("ztr",        R8A7796_CLK_ZTR,   CLK_PLL1_DIV2,  6, 1),
 	DEF_FIXED("ztrd2",      R8A7796_CLK_ZTRD2, CLK_PLL1_DIV2, 12, 1),
 	DEF_FIXED("zt",         R8A7796_CLK_ZT,    CLK_PLL1_DIV2,  4, 1),
-- 
2.11.0
