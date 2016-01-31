From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Sun, 31 Jan 2016 09:20:55 +0800
Subject: [PATCH 03/14] clk: sunxi: add bus gates for A83T
In-Reply-To: <1454203266-4450-1-git-send-email-vishnupatekar0510@gmail.com>
References: <1454203266-4450-1-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <1454203266-4450-4-git-send-email-vishnupatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A83T has similar bus gates that of H3, including single gating register has
different clock parent.

As per H3 and A83T datasheet, usbhost is under AHB2.

However,below shows allwinner source code assignment:
bits: 26 (ehci0), 27 (ehci1), 29 (ohci0) => AHB1 for A83T.
bits: 26 (ehci0), 27 (ehci1) => AHB1 for H3
bits  29, 30, 31(ohci0,1,2) => AHB2 for H3.

until, this confusion is cleared keep it H3 way.

Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
---
 Documentation/devicetree/bindings/clock/sunxi.txt | 1 +
 drivers/clk/sunxi/clk-sun8i-bus-gates.c           | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index 7f19ef5..4514d77 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -59,6 +59,7 @@ Required properties:
 	"allwinner,sun6i-a31-apb2-gates-clk" - for the APB2 gates on A31
 	"allwinner,sun8i-a23-apb2-gates-clk" - for the APB2 gates on A23
 	"allwinner,sun8i-h3-bus-gates-clk" - for the bus gates on H3
+	"allwinner,sun8i-a83t-bus-gates-clk" - for the bus gates on A83T
 	"allwinner,sun9i-a80-apbs-gates-clk" - for the APBS gates on A80
 	"allwinner,sun4i-a10-dram-gates-clk" - for the DRAM gates on A10
 	"allwinner,sun5i-a13-mbus-clk" - for the MBUS clock on A13
diff --git a/drivers/clk/sunxi/clk-sun8i-bus-gates.c b/drivers/clk/sunxi/clk-sun8i-bus-gates.c
index 1113eb9..63fdb79 100644
--- a/drivers/clk/sunxi/clk-sun8i-bus-gates.c
+++ b/drivers/clk/sunxi/clk-sun8i-bus-gates.c
@@ -109,3 +109,5 @@ err_unmap:
 
 CLK_OF_DECLARE(sun8i_h3_bus_gates, "allwinner,sun8i-h3-bus-gates-clk",
 	       sun8i_h3_bus_gates_init);
+CLK_OF_DECLARE(sun8i_a83t_bus_gates, "allwinner,sun8i-a83t-bus-gates-clk",
+	       sun8i_h3_bus_gates_init);
-- 
1.9.1
