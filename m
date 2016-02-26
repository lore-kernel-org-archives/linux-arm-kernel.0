From: eric@anholt.net (Eric Anholt)
Date: Fri, 26 Feb 2016 15:05:39 -0800
Subject: [PATCH 1/4] dt-bindings: Add binding for brcm,bcm2835-sdhost.
In-Reply-To: <1456527942-3045-1-git-send-email-eric@anholt.net>
References: <1456527942-3045-1-git-send-email-eric@anholt.net>
Message-ID: <1456527942-3045-2-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the other SD controller on the platform, which can be swapped
to the role of SD card host using pin muxing.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../bindings/mmc/brcm,bcm2835-sdhost.txt           | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt

diff --git a/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt b/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt
new file mode 100644
index 0000000..f55c446
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt
@@ -0,0 +1,25 @@
+Broadcom BCM2835 SDHOST controller
+
+This file documents differences between the core properties described
+by mmc.txt and the properties that represent the BCM2835 SDHOST controller.
+
+Required properties:
+- compatible:	Must be "brcm,bcm2835-sdhost"
+- clocks:	The phandle for the clock feeding the SDHOST controller
+
+Optional properties:
+- dmas:		DMA channel phandles for read and write
+- dma-names:	DMA channel names for read and write, must be "rx" and "tx"
+	          See Documentation/devicetree/bindings/dma/dma.txt for details
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
2.7.0
