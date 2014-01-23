From: syin@broadcom.com (Sherman Yin)
Date: Thu, 23 Jan 2014 12:44:44 -0800
Subject: [PATCH v2 1/4] pinctrl: Rename Broadcom Capri pinctrl binding
In-Reply-To: <1390509887-19278-1-git-send-email-syin@broadcom.com>
References: <1390343886-25852-1-git-send-email-syin@broadcom.com>
 <1390509887-19278-1-git-send-email-syin@broadcom.com>
Message-ID: <1390509887-19278-2-git-send-email-syin@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The compatible string of the Broadcom Capri pinctrl driver is renamed to
"brcm,bcm11351-pinctrl" to match the machine binding here:
Documentation/devicetree/bindings/arm/bcm/bcm11351.txt

Signed-off-by: Sherman Yin <syin@broadcom.com>
Reviewed-by: Matt Porter <mporter@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 ...capri-pinctrl.txt => brcm,bcm11351-pinctrl.txt} |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
 rename Documentation/devicetree/bindings/pinctrl/{brcm,capri-pinctrl.txt => brcm,bcm11351-pinctrl.txt} (98%)

diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,capri-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/brcm,bcm11351-pinctrl.txt
similarity index 98%
rename from Documentation/devicetree/bindings/pinctrl/brcm,capri-pinctrl.txt
rename to Documentation/devicetree/bindings/pinctrl/brcm,bcm11351-pinctrl.txt
index 9e9e9ef..c119deb 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,capri-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm11351-pinctrl.txt
@@ -1,4 +1,4 @@
-Broadcom Capri Pin Controller
+Broadcom BCM281xx Pin Controller
 
 This is a pin controller for the Broadcom BCM281xx SoC family, which includes
 BCM11130, BCM11140, BCM11351, BCM28145, and BCM28155 SoCs.
@@ -7,14 +7,14 @@ BCM11130, BCM11140, BCM11351, BCM28145, and BCM28155 SoCs.
 
 Required Properties:
 
-- compatible:	Must be "brcm,capri-pinctrl".
+- compatible:	Must be "brcm,bcm11351-pinctrl"
 - reg:		Base address of the PAD Controller register block and the size
 		of the block.
 
 For example, the following is the bare minimum node:
 
 	pinctrl at 35004800 {
-		compatible = "brcm,capri-pinctrl";
+		compatible = "brcm,bcm11351-pinctrl";
 		reg = <0x35004800 0x430>;
 	};
 
@@ -119,7 +119,7 @@ Optional Properties (for HDMI pins):
 Example:
 // pin controller node
 pinctrl at 35004800 {
-	compatible = "brcm,capri-pinctrl";
+	compatible = "brcmbcm11351-pinctrl";
 	reg = <0x35004800 0x430>;
 
 	// pin configuration node
-- 
1.7.9.5
