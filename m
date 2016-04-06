From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Wed, 6 Apr 2016 21:45:31 +0530
Subject: [PATCH v3 1/5] Documentation: DT: vdma: Rename vdma-chan prefix to
 dma-chan
In-Reply-To: <1459959335-24083-1-git-send-email-appanad@xilinx.com>
References: <1459959335-24083-1-git-send-email-appanad@xilinx.com>
Message-ID: <1459959335-24083-2-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch renames the vdma-mm2s-channel/vdma-s2mm-channel
property with dma-mm2s-channel/dma-s2mm-channel to sync with
the driver.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
Changes for v3:
---> New patch.

 Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
index a86737c..762938f 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
@@ -24,8 +24,8 @@ Optional properties:
 	{3}, flush s2mm channel
 
 Required child node properties:
-- compatible: It should be either "xlnx,axi-vdma-mm2s-channel" or
-	"xlnx,axi-vdma-s2mm-channel".
+- compatible: It should be either "xlnx,axi-dma-mm2s-channel" or
+	"xlnx,axi-dma-s2mm-channel".
 - interrupts: Should contain per channel VDMA interrupts.
 - xlnx,datawidth: Should contain the stream data width, take values
 	{32,64...1024}.
@@ -48,12 +48,12 @@ axi_vdma_0: axivdma at 40030000 {
 	xlnx,flush-fsync = <0x1>;
 	xlnx,addrwidth = <0x20>;
 	dma-channel at 40030000 {
-		compatible = "xlnx,axi-vdma-mm2s-channel";
+		compatible = "xlnx,axi-dma-mm2s-channel";
 		interrupts = < 0 54 4 >;
 		xlnx,datawidth = <0x40>;
 	} ;
 	dma-channel at 40030030 {
-		compatible = "xlnx,axi-vdma-s2mm-channel";
+		compatible = "xlnx,axi-dma-s2mm-channel";
 		interrupts = < 0 53 4 >;
 		xlnx,datawidth = <0x40>;
 	} ;
-- 
2.1.2
