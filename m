From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sat,  5 Mar 2016 10:52:15 +0000
Subject: [PATCH v3 04/11] ARM: bcm2835: dt: add bindings for shared interrupt
 properties
In-Reply-To: <1457175142-28665-1-git-send-email-kernel@martin.sperl.org>
References: <1457175142-28665-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1457175142-28665-5-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add binding documentation for the new shared interrupt properties:
* brcm,dma-channel-shared-mask
* brcm,dma-shared-irq-index

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
index 1396078..f9e84ee 100644
--- a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
+++ b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
@@ -17,6 +17,10 @@ Required properties:
 - brcm,dma-channel-mask: Bit mask representing the channels
 			 not used by the firmware in ascending order,
 			 i.e. first channel corresponds to LSB.
+- brcm,dma-channel-shared-mask: Bit mask representing the channels
+				that use a shared interrupt
+- brcm,dma-shared-irq-index: index of which of the interrupts mentioned
+			     above is the shared interrupt
 
 Example:
 
@@ -39,6 +43,8 @@ dma: dma at 7e007000 {
 
 	#dma-cells = <1>;
 	brcm,dma-channel-mask = <0x7f35>;
+	brcm,dma-channel-shared-mask = <0x0780>;
+	brcm,dma-shared-irq-index = <11>;
 };
 
 DMA clients connected to the BCM2835 DMA controller must use the format
-- 
2.1.4
