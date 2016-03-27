From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Sun, 27 Mar 2016 23:36:06 +0530
Subject: [PATCH v2 5/6] Documentation: DT: vdma: update binding doc for AXI
 CDMA
In-Reply-To: <1459101966-9932-1-git-send-email-appanad@xilinx.com>
References: <1459101966-9932-1-git-send-email-appanad@xilinx.com>
Message-ID: <1459101966-9932-2-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the device-tree binding doc for
adding support for AXI CDMA.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
---> Modified commit message as suggested by Vinod.
---> Moved the patch to forward in the series as suggested by vinod.

 .../devicetree/bindings/dma/xilinx/xilinx_vdma.txt     | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
index 5841421..2b0c12b 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
@@ -8,8 +8,12 @@ target devices. It can be configured to have one channel or two channels.
 If configured as two channels, one is to transmit to the device and another
 is to receive from the device.
 
+Xilinx AXI CDMA engine, it does transfers between memory-mapped source
+address and a memory-mapped destination address.
+
 Required properties:
-- compatible: Should be "xlnx,axi-vdma-1.00.a" or "xlnx,axi-dma-1.00.a"
+- compatible: Should be "xlnx,axi-vdma-1.00.a" or "xlnx,axi-dma-1.00.a" or
+	      "xlnx,axi-cdma-1.00.a""
 - #dma-cells: Should be <1>, see "dmas" property below
 - reg: Should contain VDMA registers location and length.
 - xlnx,num-fstores: Should be the number of framebuffers as configured in h/w.
@@ -80,6 +84,18 @@ axi_dma_0: axidma at 40400000 {
 	} ;
 } ;
 
+axi_cdma_0: axicdma at 7e200000 {
+       compatible = "xlnx,axi-cdma-1.00.a";
+       #dma-cells = <1>;
+       reg = < 0x7e200000 0x10000 >;
+       xlnx,addrwidth = <0x20>;
+       dma-channel at 7e200000 {
+               compatible = "xlnx,axi-dma-mm2s-channel";
+               interrupts = < 0 55 4 >;
+               xlnx,datawidth = <0x40>;
+       } ;
+} ;
+
 * DMA client
 
 Required properties:
-- 
2.1.2
