From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 15 Feb 2016 21:57:45 +0100
Subject: [PATCH v2 1/4] dma: mmp_pdma: Add the #dma-requests DT property
 documentation
Message-ID: <1455569868-25017-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For pxa based platforms, the number of requestor lines should be
specified, so that the driver can check if the flow control should be
activated (when a requestor line is asked for) or not.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v1: rename of property to #dma-requests
      	  modify default value to 32 as suggested by Vinod
---
 Documentation/devicetree/bindings/dma/mmp-dma.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/mmp-dma.txt b/Documentation/devicetree/bindings/dma/mmp-dma.txt
index 7a802f64e5bd..8f7364a7b349 100644
--- a/Documentation/devicetree/bindings/dma/mmp-dma.txt
+++ b/Documentation/devicetree/bindings/dma/mmp-dma.txt
@@ -12,6 +12,8 @@ Required properties:
 Optional properties:
 - #dma-channels: Number of DMA channels supported by the controller (defaults
   to 32 when not specified)
+- #dma-requests: Number of DMA requestor lines supported by the controller
+  (defaults to 32 when not specified)
 
 "marvell,pdma-1.0"
 Used platforms: pxa25x, pxa27x, pxa3xx, pxa93x, pxa168, pxa910, pxa688.
-- 
2.1.4
