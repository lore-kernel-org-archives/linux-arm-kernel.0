From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  9 Jul 2014 15:54:35 +0800
Subject: [PATCH v4 2/6] clk: sunxi: sun6i-a31-apb0-gates: Add A23 APB0 support
In-Reply-To: <1404892479-12222-1-git-send-email-wens@csie.org>
References: <1404892479-12222-1-git-send-email-wens@csie.org>
Message-ID: <1404892479-12222-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds "allwinner,sun8i-a23-apb0-gates-clk", a A23 specific
compatible to the sun6i-a31-apb0-gates clock driver, along with the
gate bitmap.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/clock/sunxi.txt | 1 +
 drivers/clk/sunxi/clk-sun6i-apb0-gates.c          | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index 68dbd3d..d3a5c3c 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -34,6 +34,7 @@ Required properties:
 	"allwinner,sun5i-a10s-apb0-gates-clk" - for the APB0 gates on A10s
 	"allwinner,sun6i-a31-apb0-gates-clk" - for the APB0 gates on A31
 	"allwinner,sun7i-a20-apb0-gates-clk" - for the APB0 gates on A20
+	"allwinner,sun8i-a23-apb0-gates-clk" - for the APB0 gates on A23
 	"allwinner,sun4i-a10-apb1-clk" - for the APB1 clock
 	"allwinner,sun4i-a10-apb1-mux-clk" - for the APB1 clock muxing
 	"allwinner,sun4i-a10-apb1-gates-clk" - for the APB1 gates on A10
diff --git a/drivers/clk/sunxi/clk-sun6i-apb0-gates.c b/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
index 3bd8357..551f220 100644
--- a/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
+++ b/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
@@ -25,8 +25,13 @@ static const struct gates_data sun6i_a31_apb0_gates __initconst = {
 	.mask = {0x7F},
 };
 
+static const struct gates_data sun8i_a23_apb0_gates __initconst = {
+	.mask = {0x5D},
+};
+
 const struct of_device_id sun6i_a31_apb0_gates_clk_dt_ids[] = {
 	{ .compatible = "allwinner,sun6i-a31-apb0-gates-clk", .data = &sun6i_a31_apb0_gates },
+	{ .compatible = "allwinner,sun8i-a23-apb0-gates-clk", .data = &sun8i_a23_apb0_gates },
 	{ /* sentinel */ }
 };
 
-- 
2.0.1
