From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 25 Oct 2016 12:11:38 +0800
Subject: [PATCH RESEND 1/2] dt: bindings: add allwinner,
 otg-routed property for phy-sun4i-usb
Message-ID: <20161025041139.46454-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some newer Allwinner SoCs (H3 or A64), the PHY0 can be either routed to
the MUSB controller (which is an OTG controller) or the OHCI/EHCI pair
(which is a Host-only controller, but more stable and easy to implement).

This property marks whether on a certain board which controller should be
attached to the PHY.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
index 287150d..a63c766 100644
--- a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
+++ b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
@@ -36,6 +36,12 @@ Optional properties:
 - usb1_vbus-supply : regulator phandle for controller usb1 vbus
 - usb2_vbus-supply : regulator phandle for controller usb2 vbus
 
+Optional properties for H3 or A64 SoCs:
+- allwinner,otg-routed : USB0 (OTG) PHY is routed to OHCI/EHCI pair rather than
+			 MUSB. (boolean, if this property is set, the OHCI/EHCI
+			 controllers at PHY0 should be enabled and the MUSB
+			 controller must *NOT* be enabled)
+
 Example:
 	usbphy: phy at 0x01c13400 {
 		#phy-cells = <1>;
-- 
2.10.1
