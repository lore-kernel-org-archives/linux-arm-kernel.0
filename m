From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Fri,  9 Oct 2015 00:45:05 +0200
Subject: [PATCH 1/3] doc: dt: fpga: Added Documentation for Xilinx Zynq FPGA
 manager.
In-Reply-To: <1444344307-22509-1-git-send-email-moritz.fischer@ettus.com>
References: <1444344307-22509-1-git-send-email-moritz.fischer@ettus.com>
Message-ID: <1444344307-22509-2-git-send-email-moritz.fischer@ettus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
---
 .../bindings/fpga/xilinx-zynq-fpga-mgr.txt         | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.txt

diff --git a/Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.txt
new file mode 100644
index 0000000..82ffda8
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.txt
@@ -0,0 +1,26 @@
+Xilinx Zynq FPGA Manager
+
+Required properties:
+- compatible:		should contain "xlnx,zynq-devcfg-1.0"
+- reg:			base address and size for memory mapped io
+- interrupt parent:	interrupt source phandle
+- interrupts:		interrupt for the FPGA manager device
+- clocks:		phandle for clocks required operation
+- syscon:		phandle for access to SLCR registers
+
+Optional properties:
+- clock-names:		names for clocks
+
+
+
+Example:
+	devcfg: devcfg at f8007000 {
+		compatible = "xlnx,zynq-devcfg-1.0";
+		reg = <0xf8007000 0x100>;
+		interrupt-parent = <&intc>;
+		interrupts = <0 8 4>;
+		clocks = <&clkc 12>;
+		clock-names = "ref_clk";
+		syscon = <&slcr>;
+	};
+
-- 
2.6.1
