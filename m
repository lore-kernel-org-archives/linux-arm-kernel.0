From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 28 Nov 2013 17:54:44 +0900
Subject: [PATCH 14/16] ARM: shmobile: sh73a0: tidyup clock table order
In-Reply-To: <cover.1385628709.git.horms+renesas@verge.net.au>
References: <cover.1385628709.git.horms+renesas@verge.net.au>
Message-ID: <99b7835e0d9653d0cd61c2b16416556dc72b8f55.1385628709.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

SuperH lookups clock is using CLKDEV_CON/DEV/ICK_ID() macro
for a long term.
But in these days, the ICK clock is defined in random place.
This patch arranges it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-sh73a0.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index c92c023..2aeec46 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -625,12 +625,6 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("sdhi0_clk", &div6_clks[DIV6_SDHI0]),
 	CLKDEV_CON_ID("sdhi1_clk", &div6_clks[DIV6_SDHI1]),
 	CLKDEV_CON_ID("sdhi2_clk", &div6_clks[DIV6_SDHI2]),
-	CLKDEV_ICK_ID("dsit_clk", "sh-mipi-dsi.0", &div6_clks[DIV6_DSIT]),
-	CLKDEV_ICK_ID("dsit_clk", "sh-mipi-dsi.1", &div6_clks[DIV6_DSIT]),
-	CLKDEV_ICK_ID("dsip_clk", "sh-mipi-dsi.0", &div6_clks[DIV6_DSI0P]),
-	CLKDEV_ICK_ID("dsip_clk", "sh-mipi-dsi.1", &div6_clks[DIV6_DSI1P]),
-	CLKDEV_ICK_ID("dsiphy_clk", "sh-mipi-dsi.0", &dsi0phy_clk),
-	CLKDEV_ICK_ID("dsiphy_clk", "sh-mipi-dsi.1", &dsi1phy_clk),
 
 	/* MSTP32 clocks */
 	CLKDEV_DEV_ID("i2c-sh_mobile.2", &mstp_clks[MSTP001]), /* I2C2 */
@@ -680,6 +674,14 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("i2c-sh_mobile.4", &mstp_clks[MSTP410]), /* I2C4 */
 	CLKDEV_DEV_ID("e6828000.i2c", &mstp_clks[MSTP410]), /* I2C4 */
 	CLKDEV_DEV_ID("sh_keysc.0", &mstp_clks[MSTP403]), /* KEYSC */
+
+	/* ICK */
+	CLKDEV_ICK_ID("dsit_clk", "sh-mipi-dsi.0", &div6_clks[DIV6_DSIT]),
+	CLKDEV_ICK_ID("dsit_clk", "sh-mipi-dsi.1", &div6_clks[DIV6_DSIT]),
+	CLKDEV_ICK_ID("dsip_clk", "sh-mipi-dsi.0", &div6_clks[DIV6_DSI0P]),
+	CLKDEV_ICK_ID("dsip_clk", "sh-mipi-dsi.1", &div6_clks[DIV6_DSI1P]),
+	CLKDEV_ICK_ID("dsiphy_clk", "sh-mipi-dsi.0", &dsi0phy_clk),
+	CLKDEV_ICK_ID("dsiphy_clk", "sh-mipi-dsi.1", &dsi1phy_clk),
 };
 
 void __init sh73a0_clock_init(void)
-- 
1.8.4
