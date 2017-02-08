From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Thu,  9 Feb 2017 00:30:23 +0100
Subject: [PATCH for-4.11 2/2] Revert "dt-bindings: phy: Add documentation for
 NSP USB3 PHY"
In-Reply-To: <20170208233023.31922-1-zajec5@gmail.com>
References: <20170208233023.31922-1-zajec5@gmail.com>
Message-ID: <20170208233023.31922-2-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

This reverts commit c8ca631f9480 ("dt-bindings: phy: Add documentation
for NSP USB3 PHY") to match reverting commit adding the new PHY driver.
Please note we revert this commit before it reached stable release.

If new compatible string is needed it should be added to the existing
bcm-ns-usb3-phy.txt which already describes this PHY.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 .../devicetree/bindings/phy/brcm,nsp-usb3-phy.txt  | 39 ----------------------
 1 file changed, 39 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/brcm,nsp-usb3-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/brcm,nsp-usb3-phy.txt b/Documentation/devicetree/bindings/phy/brcm,nsp-usb3-phy.txt
deleted file mode 100644
index e68ae5dec9c9..000000000000
--- a/Documentation/devicetree/bindings/phy/brcm,nsp-usb3-phy.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-Broadcom USB3 phy binding for northstar plus SoC
-The USB3 phy is internal to the SoC and is accessed using mdio interface.
-
-Required mdio bus properties:
-- reg: Should be 0x0 for SoC internal USB3 phy
-- #address-cells: must be 1
-- #size-cells: must be 0
-
-Required USB3 PHY properties:
-- compatible: should be "brcm,nsp-usb3-phy"
-- reg: USB3 Phy address on SoC internal MDIO bus and it should be 0x10.
-- usb3-ctrl-syscon: handler of syscon node defining physical address
-  of usb3 control register.
-- #phy-cells: must be 0
-
-Required usb3 control properties:
-- compatible: should be "brcm,nsp-usb3-ctrl"
-- reg: offset and length of the control registers
-
-Example:
-
-	mdio at 0 {
-		reg = <0x0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		usb3_phy: usb-phy at 10 {
-			compatible = "brcm,nsp-usb3-phy";
-			reg = <0x10>;
-			usb3-ctrl-syscon = <&usb3_ctrl>;
-			#phy-cells = <0>;
-			status = "disabled";
-		};
-	};
-
-	usb3_ctrl: syscon at 104408 {
-		compatible = "brcm,nsp-usb3-ctrl", "syscon";
-		reg = <0x104408 0x3fc>;
-	};
-- 
2.11.0
