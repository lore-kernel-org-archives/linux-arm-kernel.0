From: baruch@tkos.co.il (Baruch Siach)
Date: Fri, 27 Mar 2015 07:36:28 +0300
Subject: [PATCH 1/2] phy: dt-binding: document Conexant Digicolor USB PHY
Message-ID: <6284a7672647d46100281959552f9787f98bb552.1427430989.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device tree binding documentation to the USB PHY hardware block on the
Conexant CX92755 SoC. The CX92755 is one of the Digicolor SoCs series. Other
SoCs in that series may share the same hardware block.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 .../devicetree/bindings/phy/digicolor-usb-phy.txt         | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/digicolor-usb-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/digicolor-usb-phy.txt b/Documentation/devicetree/bindings/phy/digicolor-usb-phy.txt
new file mode 100644
index 000000000000..089f218c59c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/digicolor-usb-phy.txt
@@ -0,0 +1,15 @@
+Conexant Digicolor USB2 PHY
+
+Required properties:
+ - compatible: cnxt,cx92755-usbphy
+ - reg: offset and length of the PHY registers
+ - #phy-cells: must be 0
+Refer to phy-bindings.txt for the generic PHY binding properties
+
+Example:
+
+	usb_phy0: usb-phy at f0084000 {
+		compatible = "cnxt,cx92755-usbphy";
+		reg = <0xf0084000 0x100>;
+		#phy-cells = <0>;
+	};
-- 
2.1.4
