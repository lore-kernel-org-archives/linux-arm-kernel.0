From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 15 Apr 2014 17:13:33 +0200
Subject: [PATCH 2/6] dma: mmp_pdma: Fix the #dma-channels DT property
 documentation
In-Reply-To: <1397574817-15559-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1397574817-15559-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1397574817-15559-3-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The property is optional and defaults to 32. Document it as such.

Cc: devicetree at vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 Documentation/devicetree/bindings/dma/mmp-dma.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/mmp-dma.txt b/Documentation/devicetree/bindings/dma/mmp-dma.txt
index a4fa4ef..7a802f6 100644
--- a/Documentation/devicetree/bindings/dma/mmp-dma.txt
+++ b/Documentation/devicetree/bindings/dma/mmp-dma.txt
@@ -1,17 +1,20 @@
 * MARVELL MMP DMA controller
 
 Marvell Peripheral DMA Controller
-Used platfroms: pxa688, pxa910, pxa3xx, etc
+Used platforms: pxa688, pxa910, pxa3xx, etc
 
 Required properties:
 - compatible: Should be "marvell,pdma-1.0"
 - reg: Should contain DMA registers location and length.
 - interrupts: Either contain all of the per-channel DMA interrupts
 		or one irq for pdma device
-- #dma-channels: Number of DMA channels supported by the controller.
+
+Optional properties:
+- #dma-channels: Number of DMA channels supported by the controller (defaults
+  to 32 when not specified)
 
 "marvell,pdma-1.0"
-Used platfroms: pxa25x, pxa27x, pxa3xx, pxa93x, pxa168, pxa910, pxa688.
+Used platforms: pxa25x, pxa27x, pxa3xx, pxa93x, pxa168, pxa910, pxa688.
 
 Examples:
 
@@ -45,7 +48,7 @@ pdma: dma-controller at d4000000 {
 
 
 Marvell Two Channel DMA Controller used specifically for audio
-Used platfroms: pxa688, pxa910
+Used platforms: pxa688, pxa910
 
 Required properties:
 - compatible: Should be "marvell,adma-1.0" or "marvell,pxa910-squ"
-- 
1.8.3.2
