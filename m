From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Tue, 17 Dec 2013 17:02:01 +0100
Subject: [PATCH] tty/serial: at91: document clock properties
Message-ID: <1387296121-7558-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the clock properties required by the at91 i2c bus driver.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 .../devicetree/bindings/serial/atmel-usart.txt     |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/serial/atmel-usart.txt
index 2191dcb..9c5d19a 100644
--- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
@@ -6,6 +6,9 @@ Required properties:
   additional mode or an USART new feature.
 - reg: Should contain registers location and length
 - interrupts: Should contain interrupt
+- clock-names: tuple listing input clock names.
+	Required elements: "usart"
+- clocks: phandles to input clocks.
 
 Optional properties:
 - atmel,use-dma-rx: use of PDC or DMA for receiving data
@@ -26,6 +29,8 @@ Example:
 		compatible = "atmel,at91sam9260-usart";
 		reg = <0xfff8c000 0x4000>;
 		interrupts = <7>;
+		clocks = <&usart0_clk>;
+		clock-names = "usart";
 		atmel,use-dma-rx;
 		atmel,use-dma-tx;
 	};
@@ -35,6 +40,8 @@ Example:
 		compatible = "atmel,at91sam9260-usart";
 		reg = <0xf001c000 0x100>;
 		interrupts = <12 4 5>;
+		clocks = <&usart0_clk>;
+		clock-names = "usart";
 		atmel,use-dma-rx;
 		atmel,use-dma-tx;
 		dmas = <&dma0 2 0x3>,
-- 
1.7.9.5
