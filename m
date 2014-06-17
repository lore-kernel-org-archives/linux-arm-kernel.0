From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Jun 2014 22:52:50 +0800
Subject: [PATCH v2 13/20] clk: sunxi: Add A23 specific compatible to
 sun6i-a31-apb0-gates-clk
In-Reply-To: <1403016777-15121-1-git-send-email-wens@csie.org>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
Message-ID: <1403016777-15121-14-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sun6i-a31-apb0-gates-clk driver is generic in that it supports
the "clock-indicies" DT property with "clock-output-names" to list
the valid clock gate bits.

However this might lead one to assume that the clock in the A23 is
the same as the A31. To make it clear, we add a new compatible for
the A23, "allwinner,sun8i-a23-apb0-gates-clk".

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/clock/sunxi.txt | 1 +
 drivers/clk/sunxi/clk-sun6i-apb0-gates.c          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index e3a47ec..ad446b2 100644
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
index b342f2a..f147fee 100644
--- a/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
+++ b/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
@@ -85,6 +85,7 @@ static int sun6i_a31_apb0_gates_clk_probe(struct platform_device *pdev)
 
 const struct of_device_id sun6i_a31_apb0_gates_clk_dt_ids[] = {
 	{ .compatible = "allwinner,sun6i-a31-apb0-gates-clk" },
+	{ .compatible = "allwinner,sun8i-a23-apb0-gates-clk" },
 	{ /* sentinel */ }
 };
 
-- 
2.0.0
