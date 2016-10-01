From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat,  1 Oct 2016 14:18:58 +0200
Subject: [PATCH v3 1/3] Documentation: dt-bindings: update the meson-usb2-phy
 example
In-Reply-To: <20161001121900.1168-1-martin.blumenstingl@googlemail.com>
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
 <20161001121900.1168-1-martin.blumenstingl@googlemail.com>
Message-ID: <20161001121900.1168-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the example so the node name uses a dash (instead of an
underscore) as per convention.
Additionally it updates the example register offset to a real example
(the old value was taken from a draft where there was an additional PHY
bus).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/phy/meson-usb2-phy.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/meson-usb2-phy.txt b/Documentation/devicetree/bindings/phy/meson-usb2-phy.txt
index 9da5ea2..bc616c1 100644
--- a/Documentation/devicetree/bindings/phy/meson-usb2-phy.txt
+++ b/Documentation/devicetree/bindings/phy/meson-usb2-phy.txt
@@ -16,10 +16,10 @@ Optional properties:
 
 Example:
 
-usb0_phy: usb_phy at 0 {
+usb0_phy: usb-phy at c0000000 {
 	compatible = "amlogic,meson-gxbb-usb2-phy";
 	#phy-cells = <0>;
-	reg = <0x0 0x0 0x0 0x20>;
+	reg = <0x0 0xc0000000 0x0 0x20>;
 	resets = <&reset RESET_USB_OTG>;
 	clocks = <&clkc CLKID_USB>, <&clkc CLKID_USB0>;
 	clock-names = "usb_general", "usb";
-- 
2.10.0
