From: manabian@gmail.com (Joachim Eastwood)
Date: Thu, 21 May 2015 17:59:21 +0200
Subject: [PATCH v2 2/2] phy: dt bindings: add NXP LPC18xx/43xx USB OTG PHY
 bindings
In-Reply-To: <1432223961-26101-1-git-send-email-manabian@gmail.com>
References: <1432223961-26101-1-git-send-email-manabian@gmail.com>
Message-ID: <1432223961-26101-3-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding documentation for NXP LPC18xx/43xx USB OTG PHY. This
PHY can found on NXP LPC18xx and LPC43xx devices with USB support.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 .../devicetree/bindings/phy/phy-lpc18xx-usb-otg.txt   | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-lpc18xx-usb-otg.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-lpc18xx-usb-otg.txt b/Documentation/devicetree/bindings/phy/phy-lpc18xx-usb-otg.txt
new file mode 100644
index 000000000000..3da60ca04a42
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-lpc18xx-usb-otg.txt
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
