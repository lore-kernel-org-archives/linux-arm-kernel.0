From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sat,  5 Mar 2016 18:02:49 +0000
Subject: [PATCH 1/5] dt/bindings: bcm2835: correct description for DMA-int
Message-ID: <1457200973-11662-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

The description for interrupt DMA11 and DMA12 are wrong.

Interrupt DMA11 is the shared interrupt for DMA channels 11 to 14
Interrupt DMA12 is the shared interrupt triggering for any DMA channel
(this also includes DMA channel 15)

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 .../bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt         | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
index 2d6c8bb..b16fca8 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
@@ -71,8 +71,8 @@ Bank 1:
 24: DMA8
 25: DMA9
 26: DMA10
-27: DMA11
-28: DMA12
+27: DMA11-14 - shared interrupt for DMA 11 to 14
+28: DMAALL - triggers on all dma interrupts (including chanel 15)
 29: AUX
 30: ARM
 31: VPUDMA
-- 
2.1.4
