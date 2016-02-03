From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Wed, 3 Feb 2016 14:26:58 +0100
Subject: [PATCH v3 13/14] Documentation: atmel-quadspi: add binding file for
 Atmel QSPI driver
In-Reply-To: <cover.1454505161.git.cyrille.pitchen@atmel.com>
References: <cover.1454505161.git.cyrille.pitchen@atmel.com>
Message-ID: <6661b477af9b72cca1a29cac8a64c2295116cd8b.1454505161.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch documents the DT bindings for the driver of the Atmel QSPI
controller embedded inside sama5d2x SoCs.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 .../devicetree/bindings/mtd/atmel-quadspi.txt      | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/atmel-quadspi.txt

diff --git a/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt b/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
new file mode 100644
index 000000000000..489807005eda
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
@@ -0,0 +1,32 @@
+* Atmel Quad Serial Peripheral Interface (QSPI)
+
+Required properties:
+- compatible:     Should be "atmel,sama5d2-qspi".
+- reg:            Should contain the locations and lengths of the base registers
+                  and the mapped memory.
+- reg-names:      Should contain the resource reg names:
+                  - qspi_base: configuration register address space
+                  - qspi_mmap: memory mapped address space
+- interrupts:     Should contain the interrupt for the device.
+- clocks:         The phandle of the clock needed by the QSPI controller.
+- #address-cells: Should be <1>.
+- #size-cells:    Should be <0>.
+
+Example:
+
+spi at f0020000 {
+	compatible = "atmel,sama5d2-qspi";
+	reg = <0xf0020000 0x100>, <0xd0000000 0x8000000>;
+	reg-names = "qspi_base", "qspi_mmap";
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
