From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Wed, 6 Apr 2016 21:45:34 +0530
Subject: [PATCH v3 4/5] Documentation: DT: vdma: update binding doc for AXI
 CDMA
In-Reply-To: <1459959335-24083-1-git-send-email-appanad@xilinx.com>
References: <1459959335-24083-1-git-send-email-appanad@xilinx.com>
Message-ID: <1459959335-24083-5-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the device-tree binding doc for
adding support for AXI CDMA.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
Changes for v3:
---> Removed CDMA DT example from the patch as suggested by the Rob.
Changes for v2:
---> Modified commit message as suggested by Vinod.
---> Moved the patch to forward in the series as suggested by vinod.

 Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
index df80a7c..eba7600 100644
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
 - xlnx,addrwidth: Should be the vdma addressing size in bits(ex: 32 bits).
-- 
2.1.2
