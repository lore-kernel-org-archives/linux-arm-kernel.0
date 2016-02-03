From: k@japko.eu (Krzysztof Adamski)
Date: Thu,  4 Feb 2016 00:33:46 +0100
Subject: [PATCH v3 1/5] clk: sunxi: Add apb0 gates for H3
In-Reply-To: <1454542430-16572-1-git-send-email-k@japko.eu>
References: <1454542430-16572-1-git-send-email-k@japko.eu>
Message-ID: <1454542430-16572-2-git-send-email-k@japko.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for APB0 in H3. It seems to be compatible with
earlier SOCs. apb0 gates controls R_ block peripherals (R_PIO, R_IR,
etc).

Signed-off-by: Krzysztof Adamski <k@japko.eu>
---
 Documentation/devicetree/bindings/clock/sunxi.txt | 1 +
 drivers/clk/sunxi/clk-simple-gates.c              | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index e59f57b..751c8b9f0 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -45,6 +45,7 @@ Required properties:
 	"allwinner,sun6i-a31-apb0-gates-clk" - for the APB0 gates on A31
 	"allwinner,sun7i-a20-apb0-gates-clk" - for the APB0 gates on A20
 	"allwinner,sun8i-a23-apb0-gates-clk" - for the APB0 gates on A23
+	"allwinner,sun8i-h3-apb0-gates-clk" - for the APB0 gates on H3
 	"allwinner,sun9i-a80-apb0-gates-clk" - for the APB0 gates on A80
 	"allwinner,sun4i-a10-apb1-clk" - for the APB1 clock
 	"allwinner,sun9i-a80-apb1-clk" - for the APB1 bus clock on A80
diff --git a/drivers/clk/sunxi/clk-simple-gates.c b/drivers/clk/sunxi/clk-simple-gates.c
index f4da52b..6753c87 100644
--- a/drivers/clk/sunxi/clk-simple-gates.c
+++ b/drivers/clk/sunxi/clk-simple-gates.c
@@ -130,6 +130,8 @@ CLK_OF_DECLARE(sun8i_a23_apb2, "allwinner,sun8i-a23-apb2-gates-clk",
 	       sunxi_simple_gates_init);
 CLK_OF_DECLARE(sun8i_a33_ahb1, "allwinner,sun8i-a33-ahb1-gates-clk",
 	       sunxi_simple_gates_init);
+CLK_OF_DECLARE(sun8i_h3_apb0, "allwinner,sun8i-h3-apb0-gates-clk",
+	       sunxi_simple_gates_init);
 CLK_OF_DECLARE(sun9i_a80_ahb0, "allwinner,sun9i-a80-ahb0-gates-clk",
 	       sunxi_simple_gates_init);
 CLK_OF_DECLARE(sun9i_a80_ahb1, "allwinner,sun9i-a80-ahb1-gates-clk",
-- 
2.1.4
