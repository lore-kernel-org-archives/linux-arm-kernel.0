From: yendapally.reddy@broadcom.com (Yendapally Reddy Dhananjaya Reddy)
Date: Wed,  9 Nov 2016 04:33:10 -0500
Subject: [PATCH 2/6] dt-bindings: phy: Add documentation for NSP USB3 PHY
In-Reply-To: <1478683994-12008-1-git-send-email-yendapally.reddy@broadcom.com>
References: <1478683994-12008-1-git-send-email-yendapally.reddy@broadcom.com>
Message-ID: <1478683994-12008-3-git-send-email-yendapally.reddy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for USB3 PHY available in Northstar plus SoC

Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
---
 .../devicetree/bindings/phy/brcm,nsp-usb3-phy.txt  | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,nsp-usb3-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/brcm,nsp-usb3-phy.txt b/Documentation/devicetree/bindings/phy/brcm,nsp-usb3-phy.txt
new file mode 100644
index 0000000..30cf4b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/brcm,nsp-usb3-phy.txt
@@ -0,0 +1,39 @@
+Broadcom USB3 phy binding northstar plus SoC
+This is a child bus node of "brcm,mdio-mux-nsp" node.
+
+Required mdio bus properties:
+- reg: MDIO Bus number for the MDIO interface
+- #address-cells: must be 1
+- #size-cells: must be 0
+
+Required PHY properties:
+- compatible: should be "brcm,nsp-usb3-phy"
+- reg: Phy address in the MDIO interface
+- usb3-ctrl-syscon: handler of syscon node defining physical address
+  of usb3 control register.
+- #phy-cells: must be 0
+
+Required usb3 control properties:
+- compatible: should be "brcm,nsp-usb3-ctrl"
+- reg: offset and length of the control registers
+
+Example:
+
+	mdio at 0 {
+		reg = <0x0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usb3_phy: usb3-phy at 10 {
+			compatible = "brcm,nsp-usb3-phy";
+			reg = <0x10>;
+			usb3-ctrl-syscon = <&usb3_ctrl>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+	}
+
+	usb3_ctrl: syscon at 104408 {
+		compatible = "brcm,nsp-usb3-ctrl", "syscon";
+		reg = <0x104408 0x3fc>;
+	};
-- 
2.1.0
