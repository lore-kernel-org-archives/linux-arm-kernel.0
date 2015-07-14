From: punnaiah.choudary.kalluri@xilinx.com (Punnaiah Choudary Kalluri)
Date: Tue, 14 Jul 2015 09:06:56 +0530
Subject: [PATCH v3 1/2] Documentation: dt: Add Xilinx zynqmp dma device tree
 binding documentation
Message-ID: <1436845017-27096-1-git-send-email-punnaia@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device-tree binding documentation for Xilinx zynqmp dma engine used in
Zynq UltraScale+ MPSoC.

Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
---
Changes in v3:
- None
Changes in v2:
- None
---
 .../devicetree/bindings/dma/xilinx/zynqmp_dma.txt  |   61 ++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt

diff --git a/Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt
new file mode 100644
index 0000000..e4f92b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt
@@ -0,0 +1,61 @@
+Xilinx ZynqMP DMA engine, it does support memory to memory transfers,
+memory to device and device to memory transfers. It also has flow
+control and rate control support for slave/peripheral dma access.
+
+Required properties:
+- compatible: Should be "xlnx,zynqmp-dma-1.0"
+- #dma-cells: Should be <1>, a single cell holding a line request number
+- reg: Memory map for module access
+- interrupt-parent: Interrupt controller the interrupt is routed through
+- interrupts: Should contain DMA channel interrupt
+- xlnx,bus-width: AXI buswidth in bits. Should contain 128 or 64
+
+Optional properties:
+- xlnx,include-sg: Indicates the controller to operate in simple or scatter
+		   gather dma mode
+- xlnx,ratectrl: Scheduling interval in terms of clock cycles for
+		 source AXI transaction
+- xlnx,overfetch: Tells whether the channel is allowed to over fetch the data
+- xlnx,src-issue: Number of AXI outstanding transactions on source side
+- xlnx,desc-axi-cohrnt: Tells whether the AXI transactions generated for the
+			descriptor read are marked Non-coherent
+- xlnx,src-axi-cohrnt: Tells whether the AXI transactions generated for the
+			source descriptor payload are marked Non-coherent
+- xlnx,dst-axi-cohrnt: Tells whether the AXI transactions generated for the
+			dst descriptor payload are marked Non-coherent
+- xlnx,desc-axi-qos: AXI QOS bits to be used for descriptor fetch
+- xlnx,src-axi-qos: AXI QOS bits to be used for data read
+- xlnx,dst-axi-qos: AXI QOS bits to be used for data write
+- xlnx,desc-axi-cache: AXI cache bits to be used for descriptor fetch.
+- xlnx,desc-axi-cache: AXI cache bits to be used for data read
+- xlnx,desc-axi-cache: AXI cache bits to be used for data write
+- xlnx,src-burst-len: AXI length for data read. Support only power of 2 values
+		      i.e 1,2,4,8 and 16
+- xlnx,dst-burst-len: AXI length for data write. Support only power of 2 values
+		      i.e 1,2,4,8 and 16
+
+Example:
+++++++++
+fpd_dma_chan1: dma at FD500000 {
+	compatible = "xlnx,zynqmp-dma-1.0";
+	reg = <0x0 0xFD500000 0x1000>;
+	#dma_cells = <1>;
+	interrupt-parent = <&gic>;
+	interrupts = <0 117 4>;
+	xlnx,bus-width = <128>;
+	xlnx,include-sg;
+	xlnx,overfetch;
+	xlnx,ratectrl = <0>;
+	xlnx,src-issue = <16>;
+	xlnx,desc-axi-cohrnt;
+	xlnx,src-axi-cohrnt;
+	xlnx,dst-axi-cohrnt;
+	xlnx,desc-axi-qos = <0>;
+	xlnx,desc-axi-cache = <0>;
+	xlnx,src-axi-qos = <0>;
+	xlnx,src-axi-cache = <2>;
+	xlnx,dst-axi-qos = <0>;
+	xlnx,dst-axi-cache = <2>;
+	xlnx,src-burst-len = <4>;
+	xlnx,dst-burst-len = <4>;
+};
-- 
1.7.4
