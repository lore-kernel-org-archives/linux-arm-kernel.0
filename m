From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  1 May 2015 00:10:02 +0800
Subject: [PATCH v2 1/5] clk: sunxi: sun6i-apb0: Add support for sun9i A80 apbs
 gates
In-Reply-To: <1430410206-4410-1-git-send-email-wens@csie.org>
References: <1430410206-4410-1-git-send-email-wens@csie.org>
Message-ID: <1430410206-4410-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the PRCM apbs clock gates found on the
Allwinner A80 SoC.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/clock/sunxi.txt | 1 +
 drivers/clk/sunxi/clk-sun6i-apb0-gates.c          | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index 4fa11af3d378..2015b2beb957 100644
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
diff --git a/drivers/clk/sunxi/clk-sun6i-apb0-gates.c b/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
index 64f3e46d383c..ef5560c10447 100644
--- a/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
+++ b/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
@@ -29,9 +29,14 @@ static const struct gates_data sun8i_a23_apb0_gates __initconst = {
 	.mask = {0x5D},
 };
 
+static const struct gates_data sun9i_a80_apbs_gates __initconst = {
+	.mask = {0x1730FF},
+};
+
 static const struct of_device_id sun6i_a31_apb0_gates_clk_dt_ids[] = {
 	{ .compatible = "allwinner,sun6i-a31-apb0-gates-clk", .data = &sun6i_a31_apb0_gates },
 	{ .compatible = "allwinner,sun8i-a23-apb0-gates-clk", .data = &sun8i_a23_apb0_gates },
+	{ .compatible = "allwinner,sun9i-a80-apbs-gates-clk", .data = &sun9i_a80_apbs_gates },
 	{ /* sentinel */ }
 };
 
-- 
2.1.4
