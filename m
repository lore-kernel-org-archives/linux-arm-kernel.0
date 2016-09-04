From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun,  4 Sep 2016 23:31:48 +0200
Subject: [PATCH 3/7] Documentation: dt-bindings: Add documentation for the
 Meson USB2 PHYs
In-Reply-To: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
Message-ID: <20160904213152.25837-4-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the documentation for the bindings for the Meson8b and GXBB USB2
PHYs.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../devicetree/bindings/phy/meson-usb2-phy.txt     | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/meson-usb2-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/meson-usb2-phy.txt b/Documentation/devicetree/bindings/phy/meson-usb2-phy.txt
new file mode 100644
index 0000000..662b537
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/meson-usb2-phy.txt
@@ -0,0 +1,27 @@
+* Amlogic USB2 PHY
+
+Required properties:
+- compatible:	Depending on the platform this should be one of:
+	"amlogic,meson8b-usb2-phy"
+	"amlogic,meson-gxbb-usb2-phy"
+- reg:		The base address and length of the registers
+- #phys-cells:	should be 0 (see phy-bindings.txt in this directory)
+- resets:	reference to the reset controller
+- clocks:	phandle and clock identifier for the phy clocks
+- clock-names:	"usb_general" and "usb"
+
+Optional properties:
+- phy-supply:	see phy-bindings.txt in this directory
+
+
+Example:
+
+usb0_phy: usb_phy at 0 {
+	compatible = "amlogic,meson-gxbb-usb2-phy";
+	#phy-cells = <0>;
+	reg = <0x0 0x0 0x0 0x20>;
+	resets = <&reset 34>;
+	clocks = <&clkc CLKID_USB &clkc CLKID_USB0>;
+	clock-names = "usb_general", "usb";
+	phy-supply = <&usb_vbus>;
+};
-- 
2.9.3
