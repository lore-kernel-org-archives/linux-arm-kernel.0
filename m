From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 22 Jul 2013 22:01:07 -0300
Subject: [PATCH RFC 3/8] clk: sunxi: add gating support to PLL1
In-Reply-To: <1374541272-32173-1-git-send-email-emilio@elopez.com.ar>
References: <1374541272-32173-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1374541272-32173-4-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds gating support to PLL1 on the clock driver. This makes
the PLL1 implementation fully compatible with PLL4 as well.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 Documentation/devicetree/bindings/clock/sunxi.txt | 2 +-
 drivers/clk/sunxi/clk-sunxi.c                     | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index d495521..9a28022 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -7,7 +7,7 @@ This binding uses the common clock binding[1].
 Required properties:
 - compatible : shall be one of the following:
 	"allwinner,sun4i-osc-clk" - for a gatable oscillator
-	"allwinner,sun4i-pll1-clk" - for the main PLL clock
+	"allwinner,sun4i-pll1-clk" - for the main PLL clock as well as PLL4
 	"allwinner,sun4i-cpu-clk" - for the CPU multiplexer clock
 	"allwinner,sun4i-axi-clk" - for the AXI clock
 	"allwinner,sun4i-axi-gates-clk" - for the AXI gates
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index f258a20..4dccdb9 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -201,6 +201,7 @@ static struct clk_factors_config apb1_config = {
 };
 
 static const __initconst struct factors_data pll1_data = {
+	.enable = 31,
 	.table = &pll1_config,
 	.getter = sunxi_get_pll1_factors,
 };
-- 
1.8.3.3
