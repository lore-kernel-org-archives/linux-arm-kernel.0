From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 14 Jan 2016 16:24:51 +0100
Subject: [PATCH v2 08/26] clk: sun5i: add DRAM gates
In-Reply-To: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1452785109-6172-9-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner SoCs have a gate controller to gate the access to the DRAM
clock to the some devices that need to access the DRAM directly (mostly
display / image related IPs).

Use a simple gates driver to support the one found in the A13 / R8 SoCs.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/clock/sunxi.txt | 1 +
 drivers/clk/sunxi/clk-simple-gates.c              | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index fe34fc56e803..2a76cc3718d4 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -57,6 +57,7 @@ Required properties:
 	"allwinner,sun6i-a31-apb2-gates-clk" - for the APB2 gates on A31
 	"allwinner,sun8i-a23-apb2-gates-clk" - for the APB2 gates on A23
 	"allwinner,sun4i-a10-display-clk" - for the display clocks on the A10
+	"allwinner,sun5i-a13-dram-gates-clk" - for the DRAM gates on A13
 	"allwinner,sun5i-a13-mbus-clk" - for the MBUS clock on A13
 	"allwinner,sun4i-a10-mmc-clk" - for the MMC clock
 	"allwinner,sun9i-a80-mmc-clk" - for mmc module clocks on A80
diff --git a/drivers/clk/sunxi/clk-simple-gates.c b/drivers/clk/sunxi/clk-simple-gates.c
index 0214c6548afd..5666c767fa14 100644
--- a/drivers/clk/sunxi/clk-simple-gates.c
+++ b/drivers/clk/sunxi/clk-simple-gates.c
@@ -112,6 +112,8 @@ CLK_OF_DECLARE(sun5i_a13_apb0, "allwinner,sun5i-a13-apb0-gates-clk",
 	       sunxi_simple_gates_init);
 CLK_OF_DECLARE(sun5i_a13_apb1, "allwinner,sun5i-a13-apb1-gates-clk",
 	       sunxi_simple_gates_init);
+CLK_OF_DECLARE(sun5i_a13_dram, "allwinner,sun5i-a13-dram-gates-clk",
+	       sunxi_simple_gates_init);
 CLK_OF_DECLARE(sun6i_a31_ahb1, "allwinner,sun6i-a31-ahb1-gates-clk",
 	       sunxi_simple_gates_init);
 CLK_OF_DECLARE(sun6i_a31_apb1, "allwinner,sun6i-a31-apb1-gates-clk",
-- 
2.6.4
