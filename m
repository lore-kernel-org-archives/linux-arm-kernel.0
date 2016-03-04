From: eric@anholt.net (Eric Anholt)
Date: Fri,  4 Mar 2016 12:32:06 -0800
Subject: [PATCH 1/3] dt-bindings: Add binding docs for V3D.
In-Reply-To: <1457123528-13482-1-git-send-email-eric@anholt.net>
References: <1457123528-13482-1-git-send-email-eric@anholt.net>
Message-ID: <1457123528-13482-2-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was missed in the upstreaming process.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt b/Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt
index 56a961a..9f97df4 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt
+++ b/Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt
@@ -35,6 +35,12 @@ Optional properties for HDMI:
 		  as an interrupt/status bit in the HDMI controller
 		  itself).  See bindings/pinctrl/brcm,bcm2835-gpio.txt
 
+Required properties for V3D:
+- compatible:	Should be "brcm,bcm2835-v3d"
+- reg:		Physical base address and length of the V3D's registers
+- interrupts:	The interrupt number
+		  See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
+
 Example:
 pixelvalve at 7e807000 {
 	compatible = "brcm,bcm2835-pixelvalve2";
@@ -60,6 +66,12 @@ hdmi: hdmi at 7e902000 {
 	clock-names = "pixel", "hdmi";
 };
 
+v3d: v3d at 7ec00000 {
+	compatible = "brcm,bcm2835-v3d";
+	reg = <0x7ec00000 0x1000>;
+	interrupts = <1 10>;
+};
+
 vc4: gpu {
 	compatible = "brcm,bcm2835-vc4";
 };
-- 
2.7.0
