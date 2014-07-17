From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 17 Jul 2014 11:08:47 +0200
Subject: [PATCH 07/14] clk: sunxi: Introduce mbus compatible
In-Reply-To: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1405588134-2396-8-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even though the mbus clock is a regular module clock, given its nature, it
needs to be enabled all the time.

Introduce a new compatible, to differentiate it from the other module clocks.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/clock/sunxi.txt | 1 +
 drivers/clk/sunxi/clk-sunxi.c                     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index d3a5c3c6d677..112d8525b6e0 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -46,6 +46,7 @@ Required properties:
 	"allwinner,sun6i-a31-apb2-div-clk" - for the APB2 gates on A31
 	"allwinner,sun6i-a31-apb2-gates-clk" - for the APB2 gates on A31
 	"allwinner,sun8i-a23-apb2-gates-clk" - for the APB2 gates on A23
+	"allwinner,sun4i-a10-mbus-clk" - for the MBUS clock on A10
 	"allwinner,sun4i-a10-mod0-clk" - for the module 0 family of clocks
 	"allwinner,sun7i-a20-out-clk" - for the external output clocks
 	"allwinner,sun7i-a20-gmac-clk" - for the GMAC clock module on A20/A31
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 130e0d1ae510..bfb82bafbf9b 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1110,6 +1110,7 @@ static const struct of_device_id clk_factors_match[] __initconst = {
 	{.compatible = "allwinner,sun7i-a20-pll4-clk", .data = &sun7i_a20_pll4_data,},
 	{.compatible = "allwinner,sun6i-a31-pll6-clk", .data = &sun6i_a31_pll6_data,},
 	{.compatible = "allwinner,sun4i-a10-apb1-clk", .data = &sun4i_apb1_data,},
+	{.compatible = "allwinner,sun4i-a10-mbus-clk", .data = &sun4i_mod0_data,},
 	{.compatible = "allwinner,sun4i-a10-mod0-clk", .data = &sun4i_mod0_data,},
 	{.compatible = "allwinner,sun7i-a20-out-clk", .data = &sun7i_a20_out_data,},
 	{}
-- 
2.0.1
