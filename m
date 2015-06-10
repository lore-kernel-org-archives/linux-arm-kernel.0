From: ranjit.waghmode@xilinx.com (Ranjit Waghmode)
Date: Wed, 10 Jun 2015 16:08:20 +0530
Subject: [LINUX RFC v3 1/2] devicetree: Add DT bindings documentation for Zynq
 Ultrascale+ MPSoC GQSPI controller
Message-ID: <1433932701-5834-1-git-send-email-ranjit.waghmode@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bindings documentation for GQSPI controller driver used by
Zynq Ultrascale+ MPSoC

Signed-off-by: Ranjit Waghmode <ranjit.waghmode@xilinx.com>
---
Changes in v3:
- Did split in register addressing as per Sorens request

Changes in v2:
No changes in v2
---
 .../devicetree/bindings/spi/spi-zynqmp-qspi.txt    | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.txt b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.txt
new file mode 100644
index 0000000..c8f50e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.txt
@@ -0,0 +1,26 @@
+Xilinx Zynq UltraScale+ MPSoC GQSPI controller Device Tree Bindings
+-------------------------------------------------------------------
+
+Required properties:
+- compatible		: Should be "xlnx,zynqmp-qspi-1.0".
+- reg			: Physical base address and size of GQSPI registers map.
+- interrupts		: Property with a value describing the interrupt
+			  number.
+- interrupt-parent	: Must be core interrupt controller.
+- clock-names		: List of input clock names - "ref_clk", "pclk"
+			  (See clock bindings for details).
+- clocks		: Clock phandles (see clock bindings for details).
+
+Optional properties:
+- num-cs		: Number of chip selects used.
+
+Example:
+	qspi: spi at ff0f0000 {
+		compatible = "xlnx,zynqmp-qspi-1.0";
+		clock-names = "ref_clk", "pclk";
+		clocks = <&misc_clk &misc_clk>;
+		interrupts = <0 15 4>;
+		interrupt-parent = <&gic>;
+		num-cs = <1>;
+		reg = <0x0 0xff0f0000 0x1000>,<0x0 0xc0000000 0x8000000>;
+	};
--
2.1.2
