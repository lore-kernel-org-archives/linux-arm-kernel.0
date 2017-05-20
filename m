From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 20 May 2017 15:50:40 +0200
Subject: [PATCH v4 1/2] Documentation: dt-bindings: Add documentation for the
 Meson GXL USB2 PHY
In-Reply-To: <20170520135041.25679-1-martin.blumenstingl@googlemail.com>
References: <20170417191142.26099-1-martin.blumenstingl@googlemail.com>
 <20170520135041.25679-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170520135041.25679-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the DT binding documentation for the USB2 PHY(s) found in the
Meson GXL and GXM SoCs.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/phy/meson-gxl-usb2-phy.txt      | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/meson-gxl-usb2-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/meson-gxl-usb2-phy.txt b/Documentation/devicetree/bindings/phy/meson-gxl-usb2-phy.txt
new file mode 100644
index 000000000000..a105494a0fc9
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/meson-gxl-usb2-phy.txt
@@ -0,0 +1,17 @@
+* Amlogic Meson GXL and GXM USB2 PHY binding
+
+Required properties:
+- compatible:	Should be "amlogic,meson-gxl-usb2-phy"
+- reg:		The base address and length of the registers
+- #phys-cells:	must be 0 (see phy-bindings.txt in this directory)
+
+Optional properties:
+- phy-supply:	see phy-bindings.txt in this directory
+
+
+Example:
+	usb2_phy0: phy at 78000 {
+		compatible = "amlogic,meson-gxl-usb2-phy";
+		#phy-cells = <0>;
+		reg = <0x0 0x78000 0x0 0x20>;
+	};
-- 
2.13.0
