From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 23 May 2014 15:51:13 +0800
Subject: [PATCH 10/22] clk: sunxi: Add support for PLL6 pre-divider on AHB1
 clock
In-Reply-To: <1400831485-28576-1-git-send-email-wens@csie.org>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
Message-ID: <1400831485-28576-11-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the A31 and A23, the PLL6 input to the AHB1 clock has a 2 bit wide
pre-divider. This was verified from the A23 user manual and A31/A23 SDK
sources.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/clock/sunxi.txt | 2 ++
 drivers/clk/sunxi/clk-sunxi.c                     | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index b9ec668..ae18ec1 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -21,6 +21,8 @@ Required properties:
 	"allwinner,sun5i-a10s-ahb-gates-clk" - for the AHB gates on A10s
 	"allwinner,sun7i-a20-ahb-gates-clk" - for the AHB gates on A20
 	"allwinner,sun6i-a31-ar100-clk" - for the AR100 on A31
+	"allwinner,sun6i-a31-ahb1-pll6-clk" - for the PLL6 pre-divider to
+					      AHB1 on A31
 	"allwinner,sun6i-a31-ahb1-mux-clk" - for the AHB1 multiplexer on A31
 	"allwinner,sun6i-a31-ahb1-gates-clk" - for the AHB1 gates on A31
 	"allwinner,sun4i-a10-apb0-clk" - for the APB0 clock
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 339cabc..89eadbc 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -686,6 +686,12 @@ static const struct div_data sun4i_apb0_data __initconst = {
 	.width	= 2,
 };
 
+static const struct div_data sun6i_a31_ahb1_pll6_data __initconst = {
+	.shift	= 6,
+	.pow	= 0,
+	.width	= 2,
+};
+
 static const struct div_data sun6i_a31_apb2_div_data __initconst = {
 	.shift	= 0,
 	.pow	= 0,
@@ -1128,6 +1134,7 @@ static const struct of_device_id clk_div_match[] __initconst = {
 	{.compatible = "allwinner,sun4i-a10-axi-clk", .data = &sun4i_axi_data,},
 	{.compatible = "allwinner,sun4i-a10-ahb-clk", .data = &sun4i_ahb_data,},
 	{.compatible = "allwinner,sun4i-a10-apb0-clk", .data = &sun4i_apb0_data,},
+	{.compatible = "allwinner,sun6i-a31-ahb1-pll6-clk", .data = &sun6i_a31_ahb1_pll6_data,},
 	{.compatible = "allwinner,sun6i-a31-apb2-div-clk", .data = &sun6i_a31_apb2_div_data,},
 	{}
 };
-- 
2.0.0.rc2
