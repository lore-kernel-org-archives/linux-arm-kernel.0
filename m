From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Sun, 31 Jan 2016 09:20:54 +0800
Subject: [PATCH 02/14] clk: sunxi: Add apb0 gates for A83T
In-Reply-To: <1454203266-4450-1-git-send-email-vishnupatekar0510@gmail.com>
References: <1454203266-4450-1-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <1454203266-4450-3-git-send-email-vishnupatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

APB0 is part of PRCM, and is compatible with earlier SOCs.
apb0 gates controls R_PIO, R_UART, R_RSB, etc clocks.
This patch adds support for APB0 gates for A83T.

Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
---
 Documentation/devicetree/bindings/clock/sunxi.txt | 1 +
 drivers/clk/sunxi/clk-simple-gates.c              | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index e59f57b..7f19ef5 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -39,6 +39,7 @@ Required properties:
 	"allwinner,sun6i-a31-apb0-clk" - for the APB0 clock on A31
 	"allwinner,sun8i-a23-apb0-clk" - for the APB0 clock on A23
 	"allwinner,sun9i-a80-apb0-clk" - for the APB0 bus clock on A80
+	"allwinner,sun8i-a83t-apb0-gates-clk" - for the APB0 gates on A83T
 	"allwinner,sun4i-a10-apb0-gates-clk" - for the APB0 gates on A10
 	"allwinner,sun5i-a13-apb0-gates-clk" - for the APB0 gates on A13
 	"allwinner,sun5i-a10s-apb0-gates-clk" - for the APB0 gates on A10s
diff --git a/drivers/clk/sunxi/clk-simple-gates.c b/drivers/clk/sunxi/clk-simple-gates.c
index f4da52b..2cfc5a8 100644
--- a/drivers/clk/sunxi/clk-simple-gates.c
+++ b/drivers/clk/sunxi/clk-simple-gates.c
@@ -130,6 +130,8 @@ CLK_OF_DECLARE(sun8i_a23_apb2, "allwinner,sun8i-a23-apb2-gates-clk",
 	       sunxi_simple_gates_init);
 CLK_OF_DECLARE(sun8i_a33_ahb1, "allwinner,sun8i-a33-ahb1-gates-clk",
 	       sunxi_simple_gates_init);
+CLK_OF_DECLARE(sun8i_a83t_apb0, "allwinner,sun8i-a83t-apb0-gates-clk",
+	       sunxi_simple_gates_init);
 CLK_OF_DECLARE(sun9i_a80_ahb0, "allwinner,sun9i-a80-ahb0-gates-clk",
 	       sunxi_simple_gates_init);
 CLK_OF_DECLARE(sun9i_a80_ahb1, "allwinner,sun9i-a80-ahb1-gates-clk",
-- 
1.9.1
