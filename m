From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Tue, 12 Jan 2016 12:35:48 +0000
Subject: [PATCH V2 3/3] dt-bindings: bsm2835: fix bindings documentation to
 use new clock framework
In-Reply-To: <1452602149-5875-1-git-send-email-kernel@martin.sperl.org>
References: <1452602149-5875-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1452602149-5875-4-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

The bcm2835-i2s driver has been updated to use the new clock framework
for the bcm2835 SOC.

This patch documents the required changes to the bindings.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt b/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
index 65783de..b331f26 100644
--- a/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
@@ -4,11 +4,10 @@ Required properties:
 - compatible: "brcm,bcm2835-i2s"
 - reg: A list of base address and size entries:
 	* The first entry should cover the PCM registers
-	* The second entry should cover the PCM clock registers
+- clocks: the (PCM) clock to use
 - dmas: List of DMA controller phandle and DMA request line ordered pairs.
 - dma-names: Identifier string for each DMA request line in the dmas property.
   These strings correspond 1:1 with the ordered pairs in dmas.
-
   One of the DMA channels will be responsible for transmission (should be
   named "tx") and one for reception (should be named "rx").
 
@@ -16,8 +15,8 @@ Example:
 
 bcm2835_i2s: i2s at 7e203000 {
 	compatible = "brcm,bcm2835-i2s";
-	reg = <0x7e203000 0x20>,
-	      <0x7e101098 0x02>;
+	reg = <0x7e203000 0x24>;
+	clocks = <&clocks BCM2835_CLOCK_PCM>;
 
 	dmas = <&dma 2>,
 	       <&dma 3>;
-- 
1.7.10.4
