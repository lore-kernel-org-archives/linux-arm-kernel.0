From: kraxel@redhat.com (Gerd Hoffmann)
Date: Fri, 27 Jan 2017 12:36:26 +0100
Subject: [PATCH 1/4] dt-bindings: Add binding for brcm,bcm2835-sdhost.
In-Reply-To: <1485516989-1072-1-git-send-email-kraxel@redhat.com>
References: <1485516989-1072-1-git-send-email-kraxel@redhat.com>
Message-ID: <1485516989-1072-2-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Anholt <eric@anholt.net>

This is the other SD controller on the platform, which can be swapped
to the role of SD card host using pin muxing.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../bindings/mmc/brcm,bcm2835-sdhost.txt           | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt

diff --git a/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt b/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt
new file mode 100644
index 0000000..f9f5982
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt
@@ -0,0 +1,24 @@
+Broadcom BCM2835 SDHOST controller
+
+This file documents differences between the core properties described
+by mmc.txt and the properties that represent the BCM2835 controller.
+
+Required properties:
+- compatible: Should be "brcm,bcm2835-sdhost".
+- clocks: The clock feeding the SDHOST controller.
+
+Optional properties:
+- dmas: DMA channels for read and write.
+          See Documentation/devicetree/bindings/dma/dma.txt for details
+
+Example:
+
+sdhost: sdhost at 7e202000 {
+	compatible = "brcm,bcm2835-sdhost";
+	reg = <0x7e202000 0x100>;
+	interrupts = <2 24>;
+	clocks = <&clocks BCM2835_CLOCK_VPU>;
+	dmas = <&dma 13>,
+	       <&dma 13>;
+	dma-names = "tx", "rx";
+};
-- 
1.8.3.1
