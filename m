From: radu.pirea@microchip.com (Radu Pirea)
Date: Fri, 13 Apr 2018 19:11:16 +0300
Subject: [PATCH 2/3] dt-bindings: add binding for at91-usart in spi mode
In-Reply-To: <20180413161117.20274-1-radu.pirea@microchip.com>
References: <20180413161117.20274-1-radu.pirea@microchip.com>
Message-ID: <20180413161117.20274-3-radu.pirea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are bindings for at91-usart IP in spi spi mode. There is no support for
internal chip select. Only kind of chip selects available are gpio chip
selects.

Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
---
 .../bindings/spi/microchip,at91-usart-spi.txt | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt

diff --git a/Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt b/Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
new file mode 100644
index 000000000000..92d33ccdffae
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
@@ -0,0 +1,24 @@
+* Universal Synchronous Asynchronous Receiver/Transmitter (USART) in SPI mode
+
+Required properties:
+- #size-cells      : Must be <0>
+- #address-cells   : Must be <1>
+- compatible: Should be "microchip,at91sam9g45-usart-spi" or "microchip,sama5d2-usart-spi" 
+- reg: Should contain registers location and length
+- interrupts: Should contain interrupt
+- clocks: phandles to input clocks.
+- clock-names: tuple listing input clock names.
+	Required elements: "usart"
+- cs-gpios: chipselects (internal cs not supported)
+
+Example:
+	spi0: spi at f001c000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "microchip,sama5d2-usart-spi", "microchip,at91sam9g45-usart-spi";
+		reg = <0xf001c000 0x100>;
+		interrupts = <12 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&usart0_clk>;
+		clock-names = "usart";
+		cs-gpios = <&pioB 3 0>;
+	};
-- 
2.17.0
