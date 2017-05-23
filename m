From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 23 May 2017 15:39:32 +0200
Subject: [PATCH 1/2] dt-bindings: spi-meson: Add SPICC bindings
In-Reply-To: <1495546773-20479-1-git-send-email-narmstrong@baylibre.com>
References: <1495546773-20479-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1495546773-20479-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the SPICC (SPI Communications Controller) bindings variant.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/spi/spi-meson.txt          | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-meson.txt b/Documentation/devicetree/bindings/spi/spi-meson.txt
index dc6d031..825c39c 100644
--- a/Documentation/devicetree/bindings/spi/spi-meson.txt
+++ b/Documentation/devicetree/bindings/spi/spi-meson.txt
@@ -20,3 +20,34 @@ Required properties:
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
+
+* SPICC (SPI Communication Controller)
+
+The Meson SPICC is generic SPI controller for general purpose Full-Duplex
+communications with dedicated 16 words RX/TX PIO FIFOs.
+
+Required properties:
+ - compatible: should be "amlogic,meson-gx-spicc" on Amlogic GX SoCs.
+ - reg: physical base address and length of the controller registers
+ - interrupts: The interrupt specifier
+ - clock-names: Must contain "core"
+ - clocks: phandle of the input clock for the baud rate generator
+ - #address-cells: should be 1
+ - #size-cells: should be 0
+
+Optional properties:
+ - resets: phandle of the internal reset line
+
+See ../spi/spi-bus.txt for more details on SPI bus master and slave devices
+required and optional properties.
+
+Example :
+	spi at c1108d80 {
+		compatible = "amlogic,meson-gx-spicc";
+		reg = <0xc1108d80 0x80>;
+		interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+		clock-names = "core";
+		clocks = <&clk81>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
-- 
1.9.1
