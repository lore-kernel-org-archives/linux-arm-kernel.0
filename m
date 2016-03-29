From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 30 Mar 2016 00:30:46 +0200
Subject: [PATCH 7/7] dt-bindings: phy-lpc18xx-usb-otg: remove unit address
 from binding
In-Reply-To: <1459290646-3592-1-git-send-email-manabian@gmail.com>
References: <1459290646-3592-1-git-send-email-manabian@gmail.com>
Message-ID: <1459290646-3592-8-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT bindings should either use a unit address and a reg property
or none of them. Since either of them aren't really useful for
such a simple device like this one remove the unit address.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/phy/phy-lpc18xx-usb-otg.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-lpc18xx-usb-otg.txt b/Documentation/devicetree/bindings/phy/phy-lpc18xx-usb-otg.txt
index bd61b46..3bb821c 100644
--- a/Documentation/devicetree/bindings/phy/phy-lpc18xx-usb-otg.txt
+++ b/Documentation/devicetree/bindings/phy/phy-lpc18xx-usb-otg.txt
@@ -18,7 +18,7 @@ creg: syscon at 40043000 {
 	compatible = "nxp,lpc1850-creg", "syscon", "simple-mfd";
 	reg = <0x40043000 0x1000>;
 
-	usb0_otg_phy: phy at 004 {
+	usb0_otg_phy: phy {
 		compatible = "nxp,lpc1850-usb-otg-phy";
 		clocks = <&ccu1 CLK_USB0>;
 		#phy-cells = <0>;
-- 
2.7.4
