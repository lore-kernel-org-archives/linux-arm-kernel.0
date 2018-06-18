From: bugalski.piotr@gmail.com (Piotr Bugalski)
Date: Mon, 18 Jun 2018 18:21:24 +0200
Subject: [RFC PATCH 2/2] dt-bindings: spi: QuadSPI driver for Atmel SAMA5D2
 documentation
In-Reply-To: <20180618162124.21749-1-bugalski.piotr@gmail.com>
References: <20180618162124.21749-1-bugalski.piotr@gmail.com>
Message-ID: <20180618162124.21749-3-bugalski.piotr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Documentation for DT-binding change.

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Piotr Bugalski <pbu@cryptera.com>

---
 .../devicetree/bindings/spi/spi_atmel-qspi.txt     | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi_atmel-qspi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi_atmel-qspi.txt b/Documentation/devicetree/bindings/spi/spi_atmel-qspi.txt
new file mode 100644
index 000000000000..d52b534c9c2b
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi_atmel-qspi.txt
@@ -0,0 +1,41 @@
+* Atmel Quad Serial Peripheral Interface (QSPI)
+
+Required properties:
+- compatible:     Should be "atmel,sama5d2-spi-qspi".
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
+qspi1: spi at f0024000 {
+	compatible = "atmel,sama5d2-spi-qspi";
+	reg = <0xf0024000 0x100>, <0xd8000000 0x08000000>;
+	reg-names = "qspi_base", "qspi_mmap";
+	interrupts = <53 IRQ_TYPE_LEVEL_HIGH 7>;
+	clocks = <&qspi1_clk>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi1_default>;
+	status = "okay";
+
+	flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "winbond,w25m02gv", "spi-nand";
+		reg = <0>;
+		spi-max-frequency = <83000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+
+		...
+	};
+};
+
-- 
2.11.0
