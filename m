From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Wed, 6 Apr 2016 21:45:32 +0530
Subject: [PATCH v3 2/5] Documentation: DT: vdma: update binding doc for AXI DMA
In-Reply-To: <1459959335-24083-1-git-send-email-appanad@xilinx.com>
References: <1459959335-24083-1-git-send-email-appanad@xilinx.com>
Message-ID: <1459959335-24083-3-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the device-tree binding doc for
adding support for AXI DMA.
Also this patch differentiates required properties b/w
DMA and VDMA.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
Changes for v3:
---> Removed AXI DMA DT example from the patch as suggested by Rob.
---> Differentiated required/optional properties for each DMA's
     as suggested by Rob.
Changes for v2:
---> Modified commit message as suggested by Vinod.
---> Moved the patch to forward in the series as suggested by vinod.

 .../devicetree/bindings/dma/xilinx/xilinx_vdma.txt          | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
index 762938f..df80a7c 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
@@ -3,20 +3,28 @@ It can be configured to have one channel or two channels. If configured
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
-- xlnx,num-fstores: Should be the number of framebuffers as configured in h/w.
 - xlnx,addrwidth: Should be the vdma addressing size in bits(ex: 32 bits).
 - dma-ranges: Should be as the following <dma_addr cpu_addr max_len>.
 - dma-channel child node: Should have at least one channel and can have up to
 	two channels per device. This node specifies the properties of each
 	DMA channel (see child node properties below).
 
+Required properties for VDMA:
+- xlnx,num-fstores: Should be the number of framebuffers as configured in h/w.
+
 Optional properties:
 - xlnx,include-sg: Tells configured for Scatter-mode in
 	the hardware.
+Optional properties for VDMA:
 - xlnx,flush-fsync: Tells which channel to Flush on Frame sync.
 	It takes following values:
 	{1}, flush both channels
@@ -33,6 +41,7 @@ Required child node properties:
 Optional child node properties:
 - xlnx,include-dre: Tells hardware is configured for Data
 	Realignment Engine.
+Optional child node properties for VDMA:
 - xlnx,genlock-mode: Tells Genlock synchronization is
 	enabled/disabled in hardware.
 
-- 
2.1.2
