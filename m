From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 29 Nov 2015 11:03:07 +0800
Subject: [PATCH v4 2/5] clk: sunxi: Add sun9i A80 apbs gates support
In-Reply-To: <1448766190-11345-1-git-send-email-wens@csie.org>
References: <1448766190-11345-1-git-send-email-wens@csie.org>
Message-ID: <1448766190-11345-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the PRCM apbs clock gates found on the
Allwinner A80 SoC.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/clock/sunxi.txt | 1 +
 drivers/clk/sunxi/clk-simple-gates.c              | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index a94bb56a0e9e..b6859ed6913f 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -55,6 +55,7 @@ Required properties:
 	"allwinner,sun9i-a80-apb1-gates-clk" - for the APB1 gates on A80
 	"allwinner,sun6i-a31-apb2-gates-clk" - for the APB2 gates on A31
 	"allwinner,sun8i-a23-apb2-gates-clk" - for the APB2 gates on A23
+	"allwinner,sun9i-a80-apbs-gates-clk" - for the APBS gates on A80
 	"allwinner,sun5i-a13-mbus-clk" - for the MBUS clock on A13
 	"allwinner,sun4i-a10-mmc-clk" - for the MMC clock
 	"allwinner,sun9i-a80-mmc-clk" - for mmc module clocks on A80
diff --git a/drivers/clk/sunxi/clk-simple-gates.c b/drivers/clk/sunxi/clk-simple-gates.c
index 0214c6548afd..c8acc0612c15 100644
--- a/drivers/clk/sunxi/clk-simple-gates.c
+++ b/drivers/clk/sunxi/clk-simple-gates.c
@@ -140,6 +140,8 @@ CLK_OF_DECLARE(sun9i_a80_apb0, "allwinner,sun9i-a80-apb0-gates-clk",
 	       sunxi_simple_gates_init);
 CLK_OF_DECLARE(sun9i_a80_apb1, "allwinner,sun9i-a80-apb1-gates-clk",
 	       sunxi_simple_gates_init);
+CLK_OF_DECLARE(sun9i_a80_apbs, "allwinner,sun9i-a80-apbs-gates-clk",
+	       sunxi_simple_gates_init);
 
 static const int sun4i_a10_ahb_critical_clocks[] __initconst = {
 	14,	/* ahb_sdram */
-- 
2.6.2
