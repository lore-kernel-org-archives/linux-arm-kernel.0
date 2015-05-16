From: manabian@gmail.com (Joachim Eastwood)
Date: Sat, 16 May 2015 19:27:57 +0200
Subject: [PATCH 2/2] doc: dt: add documentation for nxp,lpc1850-usb-otg-phy
In-Reply-To: <1431797277-4906-1-git-send-email-manabian@gmail.com>
References: <1431797277-4906-1-git-send-email-manabian@gmail.com>
Message-ID: <1431797277-4906-3-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding documentation for nxp,lpc1850-usb-otg-phy. This PHY
can found on NXP LPC18xx and LPC43xx devices.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 .../bindings/phy/nxp,lpc1850-usb-otg-phy.txt          | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/nxp,lpc1850-usb-otg-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/nxp,lpc1850-usb-otg-phy.txt b/Documentation/devicetree/bindings/phy/nxp,lpc1850-usb-otg-phy.txt
new file mode 100644
index 000000000000..3da60ca04a42
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/nxp,lpc1850-usb-otg-phy.txt
@@ -0,0 +1,19 @@
+NXP LPC18xx/43xx internal USB OTG PHY binding
+---------------------------------------------
+
+This file contains documentation for the internal USB OTG PHY found
+in NXP LPC18xx and LPC43xx SoCs.
+
+Required properties:
+- compatible	: must be "nxp,lpc1850-usb-otg-phy"
+- clocks	: must be exactly one entry
+See: Documentation/devicetree/bindings/clock/clock-bindings.txt
+- #phy-cells	: must be 0 for this phy
+See: Documentation/devicetree/bindings/phy/phy-bindings.txt
+
+Example:
+usb0_otg_phy: usb0-otg-phy {
+	compatible = "nxp,lpc1850-usb-otg-phy";
+	clocks = <&ccu1 CLK_USB0>;
+	#phy-cells = <0>;
+};
-- 
1.8.0
