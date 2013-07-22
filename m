From: elen.song@atmel.com (Elen Song)
Date: Mon, 22 Jul 2013 16:30:31 +0800
Subject: [PATCH 8/8 V3] serial: at91: add dma support in usart binding
 descriptions
In-Reply-To: <1374481831-24573-1-git-send-email-elen.song@atmel.com>
References: <1374481831-24573-1-git-send-email-elen.song@atmel.com>
Message-ID: <1374481831-24573-9-git-send-email-elen.song@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Elen Song <elen.song@atmel.com>
---
 .../devicetree/bindings/tty/serial/atmel-usart.txt |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/tty/serial/atmel-usart.txt b/Documentation/devicetree/bindings/tty/serial/atmel-usart.txt
index a49d9a1..2191dcb 100644
--- a/Documentation/devicetree/bindings/tty/serial/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/tty/serial/atmel-usart.txt
@@ -10,13 +10,18 @@ Required properties:
 Optional properties:
 - atmel,use-dma-rx: use of PDC or DMA for receiving data
 - atmel,use-dma-tx: use of PDC or DMA for transmitting data
+- add dma bindings for dma transfer:
+	- dmas: DMA specifier, consisting of a phandle to DMA controller node,
+		memory peripheral interface and USART DMA channel ID, FIFO configuration.
+		Refer to dma.txt and atmel-dma.txt for details.
+	- dma-names: "rx" for RX channel, "tx" for TX channel.
 
 <chip> compatible description:
 - at91rm9200:  legacy USART support
 - at91sam9260: generic USART implementation for SAM9 SoCs
 
 Example:
-
+- use PDC:
 	usart0: serial at fff8c000 {
 		compatible = "atmel,at91sam9260-usart";
 		reg = <0xfff8c000 0x4000>;
@@ -25,3 +30,14 @@ Example:
 		atmel,use-dma-tx;
 	};
 
+- use DMA:
+	usart0: serial at f001c000 {
+		compatible = "atmel,at91sam9260-usart";
+		reg = <0xf001c000 0x100>;
+		interrupts = <12 4 5>;
+		atmel,use-dma-rx;
+		atmel,use-dma-tx;
+		dmas = <&dma0 2 0x3>,
+		       <&dma0 2 0x204>;
+		dma-names = "tx", "rx";
+	};
-- 
1.7.9.5
