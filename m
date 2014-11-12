From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 12 Nov 2014 14:51:16 +0100
Subject: [PATCH RESEND] Documentation: devicetree: Fix Xilinx VDMA
 specification
Message-ID: <1415800277-6817-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The specification requires xlnx,data-width, but example and driver use
xlnx,datawidth. Change the specification to match the implementation.

Reviewed-by: Michal Simek <michal.simek@xilinx.com>
Fixes: eebeac03db93 ("dma: Add Xilinx Video DMA DT Binding Documentation")
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 This appears to have fallen through the cracks... resending to dmaengine.

 Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
index 1405ed071bb4..e4c4d47f8137 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
@@ -25,7 +25,7 @@ Required child node properties:
 - compatible: It should be either "xlnx,axi-vdma-mm2s-channel" or
 	"xlnx,axi-vdma-s2mm-channel".
 - interrupts: Should contain per channel VDMA interrupts.
-- xlnx,data-width: Should contain the stream data width, take values
+- xlnx,datawidth: Should contain the stream data width, take values
 	{32,64...1024}.
 
 Optional child node properties:
-- 
2.1.2
