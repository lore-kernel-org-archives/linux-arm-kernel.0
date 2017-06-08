From: raviteja.garimella@broadcom.com (Raviteja Garimella)
Date: Thu,  8 Jun 2017 16:05:01 +0530
Subject: [PATCH v8 1/3] dt-bindings: phy: Add DT bindings documentation for
 NS2 USB DRD PHY
In-Reply-To: <1496918103-14948-1-git-send-email-raviteja.garimella@broadcom.com>
References: <1496918103-14948-1-git-send-email-raviteja.garimella@broadcom.com>
Message-ID: <1496918103-14948-2-git-send-email-raviteja.garimella@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DT bindings documentation for NS2 DRD PHY driver.

Signed-off-by: Raviteja Garimella <raviteja.garimella@broadcom.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/phy/brcm,ns2-drd-phy.txt   | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,ns2-drd-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/brcm,ns2-drd-phy.txt b/Documentation/devicetree/bindings/phy/brcm,ns2-drd-phy.txt
new file mode 100644
index 0000000..04f063a
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/brcm,ns2-drd-phy.txt
@@ -0,0 +1,30 @@
+BROADCOM NORTHSTAR2 USB2 (DUAL ROLE DEVICE) PHY
+
+Required properties:
+ - compatible: brcm,ns2-drd-phy
+ - reg: offset and length of the NS2 PHY related registers.
+ - reg-names
+   The below registers must be provided.
+   icfg - for DRD ICFG configurations
+   rst-ctrl - for DRD IDM reset
+   crmu-ctrl - for CRMU core vdd, PHY and PHY PLL reset
+   usb2-strap - for port over current polarity reversal
+ - #phy-cells: Must be 0. No args required.
+ - vbus-gpios: vbus gpio binding
+ - id-gpios: id gpio binding
+
+Refer to phy/phy-bindings.txt for the generic PHY binding properties
+
+Example:
+	usbdrd_phy: phy at 66000960 {
+			#phy-cells = <0>;
+			compatible = "brcm,ns2-drd-phy";
+			reg = <0x66000960 0x24>,
+			      <0x67012800 0x4>,
+			      <0x6501d148 0x4>,
+			      <0x664d0700 0x4>;
+			reg-names = "icfg", "rst-ctrl",
+				    "crmu-ctrl", "usb2-strap";
+			id-gpios = <&gpio_g 30 0>;
+			vbus-gpios = <&gpio_g 31 0>;
+	};
-- 
2.1.0
