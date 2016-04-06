From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Wed, 6 Apr 2016 10:44:57 +0530
Subject: [RESEND PATCH v2 3/6] Documentation: DT: vdma: update binding doc for
 AXI DMA
In-Reply-To: <1459919700-6692-1-git-send-email-appanad@xilinx.com>
References: <1459919700-6692-1-git-send-email-appanad@xilinx.com>
Message-ID: <1459919700-6692-4-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the device-tree binding doc for
adding support for AXI DMA.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
Changes for v2:
---> Modified commit message as suggested by Vinod.
---> Moved the patch to forward in the series as suggested by vinod.

 .../devicetree/bindings/dma/xilinx/xilinx_vdma.txt | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
index a86737c..5841421 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
@@ -3,8 +3,13 @@ It can be configured to have one channel or two channels. If configured
 as two channels, one is to transmit to the video device and another is
 to receive from the video device.
 
+Xilinx AXI DMA engine, it does transfers between memory and AXI4 stream
+target devices. It can be configured to have one channel or two channels.
+If configured as two channels, one is to transmit to the device and another
+is to receive from the device.
+
 Required properties:
-- compatible: Should be "xlnx,axi-vdma-1.00.a"
+- compatible: Should be "xlnx,axi-vdma-1.00.a" or "xlnx,axi-dma-1.00.a"
 - #dma-cells: Should be <1>, see "dmas" property below
 - reg: Should contain VDMA registers location and length.
 - xlnx,num-fstores: Should be the number of framebuffers as configured in h/w.
@@ -59,6 +64,21 @@ axi_vdma_0: axivdma at 40030000 {
 	} ;
 } ;
 
+axi_dma_0: axidma at 40400000 {
+	compatible = "xlnx,axi-dma-1.00.a";
+	#dma-cells = <1>;
+	reg = < 0x40400000 0x10000 >;
+	dma-channel at 40400000 {
+		compatible = "xlnx,axi-dma-mm2s-channel";
+		interrupts = < 0 59 4 >;
+		xlnx,datawidth = <0x40>;
+	} ;
+	dma-channel at 40400030 {
+		compatible = "xlnx,axi-dma-s2mm-channel";
+		interrupts = < 0 58 4 >;
+		xlnx,datawidth = <0x40>;
+	} ;
+} ;
 
 * DMA client
 
-- 
2.1.2
