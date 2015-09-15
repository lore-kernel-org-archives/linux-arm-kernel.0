From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Tue, 15 Sep 2015 17:28:03 +0200
Subject: [linux-next RFC v7 5/6] Documentation: atmel-quadspi: add binding
 file for Atmel QSPI driver
In-Reply-To: <cover.1442330503.git.cyrille.pitchen@atmel.com>
References: <cover.1442330503.git.cyrille.pitchen@atmel.com>
Message-ID: <3d8d6280ef1c48bfa09a15ee8e8b0ef740f3c47e.1442330503.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch documents the DT bindings for the driver of the Atmel QSPI
controller embedded inside sama5d2x SoCs.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Marek Vasut <marex@denx.de>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mtd/atmel-quadspi.txt      | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/atmel-quadspi.txt

diff --git a/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt b/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
new file mode 100644
index 000000000000..0b8d545bb198
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
@@ -0,0 +1,29 @@
+* Atmel Quad Serial Peripheral Interface (QSPI)
+
+Required properties:
+- compatible:     should be "atmel,sama5d2-qspi"
+- reg:            the first contains the register location and length,
+                  the second contains the memory mapping address and length
+- interrupts:     should contain the interrupt for the device
+- clocks:         the phandle of the clock needed by the QSPI controller
+- #address-cells: should be <1>
+- #size-cells:    should be <0>
+
+Example:
+
+spi at f0020000 {
+	compatible = "atmel,sama5d2-qspi";
+	reg = <0xf0020000 0x100>,
+	      <0xd0000000 0x8000000>;
+	interrupts = <52 IRQ_TYPE_LEVEL_HIGH 7>;
+	clocks = <&spi0_clk>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi0_default>;
+	status = "okay";
+
+	m25p80 at 0 {
+		...
+	};
+};
-- 
1.8.2.2
