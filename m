From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Sun, 29 Sep 2013 00:49:31 -0300
Subject: [PATCH 02/10] clk: sunxi: add gating support to PLL1
In-Reply-To: <1380426579-32458-1-git-send-email-emilio@elopez.com.ar>
References: <1380426579-32458-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1380426579-32458-3-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds gating support to PLL1 on the clock driver. This makes
the PLL1 implementation fully compatible with PLL4 as well.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 Documentation/devicetree/bindings/clock/sunxi.txt | 2 +-
 drivers/clk/sunxi/clk-sunxi.c                     | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index 00a5c264..7d9245f 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -7,7 +7,7 @@ This binding uses the common clock binding[1].
 Required properties:
 - compatible : shall be one of the following:
 	"allwinner,sun4i-osc-clk" - for a gatable oscillator
-	"allwinner,sun4i-pll1-clk" - for the main PLL clock
+	"allwinner,sun4i-pll1-clk" - for the main PLL clock and PLL4
 	"allwinner,sun6i-a31-pll1-clk" - for the main PLL clock on A31
 	"allwinner,sun4i-cpu-clk" - for the CPU multiplexer clock
 	"allwinner,sun4i-axi-clk" - for the AXI clock
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 5491b1a..77b9f57 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -293,11 +293,13 @@ static struct clk_factors_config sun4i_apb1_config = {
 };
 
 static const struct factors_data sun4i_pll1_data __initconst = {
+	.enable = 31,
 	.table = &sun4i_pll1_config,
 	.getter = sun4i_get_pll1_factors,
 };
 
 static const struct factors_data sun6i_a31_pll1_data __initconst = {
+	.enable = 31,
 	.table = &sun6i_a31_pll1_config,
 	.getter = sun6i_a31_get_pll1_factors,
 };
-- 
1.8.4
