From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Tue, 15 Mar 2016 22:53:12 +0530
Subject: [PATCH 7/7] dmaengine: xilinx_vdma: Add Support for Xilinx AXI
 Central Direct Memory Access Engine
In-Reply-To: <1458062592-27981-1-git-send-email-appanad@xilinx.com>
References: <1458062592-27981-1-git-send-email-appanad@xilinx.com>
Message-ID: <1458062592-27981-8-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the device-tree binding doc for
adding support for AXI CDMA.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
 .../devicetree/bindings/dma/xilinx/xilinx_vdma.txt        | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
index 3d134a5..f288175 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
@@ -8,8 +8,12 @@ target devices. It can be configured to have one channel or two channels.
 If configured as two channels, one is to transmit to the device and another
 is to receive from the device.
 
+Xilinx AXI CDMA engine, it does transfers between memory-mapped source
+address and a memory-mapped destination address.
+
 Required properties:
 - compatible: Should be "xlnx,axi-vdma-1.00.a" or "xlnx,axi-dma-1.00.a"
+	      or "xlnx,axi-cdma-1.00.a"
 - #dma-cells: Should be <1>, see "dmas" property below
 - reg: Should contain VDMA registers location and length.
 - xlnx,num-fstores: Should be the number of framebuffers as configured in h/w.
@@ -76,6 +80,17 @@ axi_dma_0: axidma at 40400000 {
 	} ;
 } ;
 
+axi_cdma_0: axicdma at 7e200000 {
+       compatible = "xlnx,axi-cdma-1.00.a";
+       #dma-cells = <1>;
+       reg = < 0x7e200000 0x10000 >;
+       dma-channel at 7e200000 {
+               compatible = "xlnx,axi-vdma-mm2s-channel";
+               interrupts = < 0 55 4 >;
+               xlnx,datawidth = <0x40>;
+       } ;
+} ;
+
 * DMA client
 
 Required properties:
-- 
2.1.2
