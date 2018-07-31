From: radhey.shyam.pandey@xilinx.com (Radhey Shyam Pandey)
Date: Tue, 31 Jul 2018 23:16:12 +0530
Subject: [RFC PATCH 1/2] dt-bindings: dmaengine: xilinx_dma: Add binding for
 Xilinx MCDMA IP
In-Reply-To: <1533059173-21405-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1533059173-21405-1-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <1533059173-21405-2-git-send-email-radhey.shyam.pandey@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devicetree binding for Xilinx AXI Multichannel Direct Memory Access
(AXI MCDMA) IP. The AXI MCDMA provides high-bandwidth direct memory
access between memory and AXI4-Stream target peripherals. The AXI MCDMA
core provides scatter-gather interface with multiple channel support.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index 174af2c..57bb02e 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -11,9 +11,13 @@ is to receive from the device.
 Xilinx AXI CDMA engine, it does transfers between memory-mapped source
 address and a memory-mapped destination address.
 
+Xilinx AXI MCDMA engine, it does transfer between memory and AXI4 stream
+target devices. It can be configured to have up to 16 independent transmit
+and receive channels.
+
 Required properties:
 - compatible: Should be "xlnx,axi-vdma-1.00.a" or "xlnx,axi-dma-1.00.a" or
-	      "xlnx,axi-cdma-1.00.a""
+	      "xlnx,axi-cdma-1.00.a" or "xlnx,axi-mcdma-1.00.a".
 - #dma-cells: Should be <1>, see "dmas" property below
 - reg: Should contain VDMA registers location and length.
 - xlnx,addrwidth: Should be the vdma addressing size in bits(ex: 32 bits).
@@ -56,6 +60,8 @@ Required child node properties:
 	For CDMA: It should be "xlnx,axi-cdma-channel".
 	For AXIDMA: It should be either "xlnx,axi-dma-mm2s-channel" or
 	"xlnx,axi-dma-s2mm-channel".
+	For MCDMA: It should be either "xlnx,axi-mcdma-mm2s-channel" or
+	"xlnx,axi-mcdma-s2mm-channel".
 - interrupts: Should contain per channel VDMA interrupts.
 - xlnx,datawidth: Should contain the stream data width, take values
 	{32,64...1024}.
@@ -68,7 +74,7 @@ Optional child node properties for VDMA:
 	enabled/disabled in hardware.
 - xlnx,enable-vert-flip: Tells vertical flip is
 	enabled/disabled in hardware(S2MM path).
-Optional child node properties for AXI DMA:
+Optional child node properties for AXI DMA and MCDMA:
 -dma-channels: Number of dma channels in child node.
 
 Example:
-- 
2.7.4
