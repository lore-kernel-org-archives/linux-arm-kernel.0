From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 14 May 2014 14:58:57 +0200
Subject: [PATCH] Documentation: dt: Add new compatible for the A31 USB Phy
Message-ID: <1400072337-30687-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the freshly introduced compatible for the USB phy in use in the
Allwinner A31 SoC.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 .../devicetree/bindings/phy/sun4i-usb-phy.txt      | 23 ++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
index a82361b62015..16528b9eb561 100644
--- a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
+++ b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
@@ -2,15 +2,26 @@ Allwinner sun4i USB PHY
 -----------------------
 
 Required properties:
-- compatible : should be one of "allwinner,sun4i-a10-usb-phy",
-  "allwinner,sun5i-a13-usb-phy" or "allwinner,sun7i-a20-usb-phy"
+- compatible : should be one of
+  * allwinner,sun4i-a10-usb-phy
+  * allwinner,sun5i-a13-usb-phy
+  * allwinner,sun6i-a31-usb-phy
+  * allwinner,sun7i-a20-usb-phy
 - reg : a list of offset + length pairs
-- reg-names : "phy_ctrl", "pmu1" and for sun4i or sun7i "pmu2"
+- reg-names :
+  * "phy_ctrl"
+  * "pmu1"
+  * "pmu2" for sun4i, sun6i or sun7i
 - #phy-cells : from the generic phy bindings, must be 1
-- clocks : phandle + clock specifier for the phy clock
-- clock-names : "usb_phy"
+- clocks : phandle + clock specifier for the phy clocks
+- clock-names :
+  * "usb_phy" for sun4i, sun5i or sun7i
+  * "usb0_phy", "usb1_phy" and "usb2_phy" for sun6i
 - resets : a list of phandle + reset specifier pairs
-- reset-names : "usb0_reset", "usb1_reset" and for sun4i or sun7i "usb2_reset"
+- reset-names :
+  * "usb0_reset"
+  * "usb1_reset"
+  * "usb2_reset" for sun4i, sun6i or sun7i
 
 Example:
 	usbphy: phy at 0x01c13400 {
-- 
1.9.3
