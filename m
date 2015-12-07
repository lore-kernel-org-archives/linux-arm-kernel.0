From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Mon, 7 Dec 2015 15:09:13 +0100
Subject: [PATCH linux-next 4/5] Documentation: atmel-quadspi: add binding file
 for Atmel QSPI driver
In-Reply-To: <cover.1449494420.git.cyrille.pitchen@atmel.com>
References: <cover.1449494420.git.cyrille.pitchen@atmel.com>
Message-ID: <caec561f882521b3896530404ecb2bbad9950435.1449494420.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch documents the DT bindings for the driver of the Atmel QSPI
controller embedded inside sama5d2x SoCs.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 .../devicetree/bindings/mtd/atmel-quadspi.txt      | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/atmel-quadspi.txt

diff --git a/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt b/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
new file mode 100644
index 000000000000..e81f20f9faf1
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
+	reg-names = "qpsi_base", "qspi_mmap";
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
