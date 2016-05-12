From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Thu, 12 May 2016 17:59:23 +0530
Subject: [PATCH v8 1/2] Documentation: DT: dma: Add Xilinx zynqmp dma device
 tree binding documentation
Message-ID: <1463056164-3210-1-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device-tree binding documentation for Xilinx zynqmp dma engine used in
Zynq UltraScale+ MPSoC.

Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
Changes in v8:
- Removed all the software runtime configuration parameters
  from the binding doc as suggested by the Lars.
Changes in v7:
- None.
Changes in v6:
- Removed desc-axi-cache/dst-axi-cache/src-axi-cache properties
  from the binding doc as it allow broken combinations when dma-coherent
  is set as suggested by Rob.
- Fixed minor comments given by Rob related coding(lower case DT node name).
Changes in v5:
- Use dma-coherent flag for coherent transfers as suggested by rob.
- Removed unnecessary properties from binding doc as suggested by Rob.
Changes in v4:
- None
Changes in v3:
- None
Changes in v2:
- None.

 .../devicetree/bindings/dma/xilinx/zynqmp_dma.txt  | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt

diff --git a/Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt
new file mode 100644
index 0000000..eea9924
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt
@@ -0,0 +1,30 @@
+Xilinx ZynqMP DMA engine, it does support memory to memory transfers,
+memory to device and device to memory transfers. It also has flow
+control and rate control support for slave/peripheral dma access.
+
+Required properties:
+- compatible		: Should be "xlnx,zynqmp-dma-1.0"
+- reg			: Memory map for gdma/adma module access.
+- interrupt-parent	: Interrupt controller the interrupt is routed through
+- interrupts		: Should contain DMA channel interrupt.
+- xlnx,bus-width	: Axi buswidth in bits. Should contain 128 or 64
+- clock-names		: List of input clocks "clk_main", "clk_apb"
+			  (see clock bindings for details)
+
+Optional properties:
+- xlnx,include-sg	: Indicates the controller to operate in simple or
+			  scatter gather dma mode
+- dma-coherent		: Present if dma operations are coherent.
+
+Example:
+++++++++
+fpd_dma_chan1: dma at fd500000 {
+	compatible = "xlnx,zynqmp-dma-1.0";
+	reg = <0x0 0xFD500000 0x1000>;
+	interrupt-parent = <&gic>;
+	interrupts = <0 117 4>;
+	clock-names = "clk_main", "clk_apb";
+	xlnx,bus-width = <128>;
+	xlnx,include-sg;
+	dma-coherent;
+};
-- 
2.1.1
