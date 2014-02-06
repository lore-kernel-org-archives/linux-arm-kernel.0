From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:21:07 +0900
Subject: [PATCH 10/13] ARM: shmobile: r8a7791: Add ZS clock
In-Reply-To: <cover.1391666228.git.horms+renesas@verge.net.au>
References: <cover.1391666228.git.horms+renesas@verge.net.au>
Message-ID: <5a6f994abbfde8e17671541db04399dfc4aebe62.1391666228.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Valentine Barshak <valentine.barshak@cogentembedded.com>

This adds fixed ratio zs_clk to R8A7791 clocks.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7791.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7791.c b/arch/arm/mach-shmobile/clock-r8a7791.c
index 1074ba4..52d7d13 100644
--- a/arch/arm/mach-shmobile/clock-r8a7791.c
+++ b/arch/arm/mach-shmobile/clock-r8a7791.c
@@ -113,6 +113,7 @@ SH_FIXED_RATIO_CLK_SET(rclk_clk,		pll1_clk,	1, (48 * 1024));
 SH_FIXED_RATIO_CLK_SET(mp_clk,			pll1_div2_clk,	1, 15);
 SH_FIXED_RATIO_CLK_SET(zg_clk,			pll1_clk,	1, 3);
 SH_FIXED_RATIO_CLK_SET(zx_clk,			pll1_clk,	1, 3);
+SH_FIXED_RATIO_CLK_SET(zs_clk,			pll1_clk,	1, 6);
 
 static struct clk *main_clks[] = {
 	&extal_clk,
@@ -128,6 +129,7 @@ static struct clk *main_clks[] = {
 	&cp_clk,
 	&zg_clk,
 	&zx_clk,
+	&zs_clk,
 };
 
 /* MSTP */
@@ -187,6 +189,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("pll1_div2",	&pll1_div2_clk),
 	CLKDEV_CON_ID("pll3",		&pll3_clk),
 	CLKDEV_CON_ID("zg",		&zg_clk),
+	CLKDEV_CON_ID("zs",		&zs_clk),
 	CLKDEV_CON_ID("hp",		&hp_clk),
 	CLKDEV_CON_ID("p",		&p_clk),
 	CLKDEV_CON_ID("rclk",		&rclk_clk),
-- 
1.8.5.2
