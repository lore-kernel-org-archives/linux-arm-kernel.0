From: abailon@baylibre.com (Alexandre Bailon)
Date: Wed, 16 Nov 2016 11:52:23 +0100
Subject: [PATCH v5 1/3] dt/bindings: Add binding for the DA8xx MUSB driver
In-Reply-To: <1479293545-7516-1-git-send-email-abailon@baylibre.com>
References: <1479293545-7516-1-git-send-email-abailon@baylibre.com>
Message-ID: <1479293545-7516-2-git-send-email-abailon@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Petr Kulhavy <petr@barix.com>

DT binding for the TI DA8xx/OMAP-L1x/AM17xx/AM18xx MUSB driver.

Signed-off-by: Petr Kulhavy <petr@barix.com>
Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/usb/da8xx-usb.txt          | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/da8xx-usb.txt

diff --git a/Documentation/devicetree/bindings/usb/da8xx-usb.txt b/Documentation/devicetree/bindings/usb/da8xx-usb.txt
new file mode 100644
index 0000000..ccb844a
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/da8xx-usb.txt
@@ -0,0 +1,43 @@
+TI DA8xx MUSB
+~~~~~~~~~~~~~
+For DA8xx/OMAP-L1x/AM17xx/AM18xx platforms.
+
+Required properties:
+~~~~~~~~~~~~~~~~~~~~
+ - compatible : Should be set to "ti,da830-musb".
+
+ - reg: Offset and length of the USB controller register set.
+
+ - interrupts: The USB interrupt number.
+
+ - interrupt-names: Should be set to "mc".
+
+ - dr_mode: The USB operation mode. Should be one of "host", "peripheral" or "otg".
+
+ - phys: Phandle for the PHY device
+
+ - phy-names: Should be "usb-phy"
+
+Optional properties:
+~~~~~~~~~~~~~~~~~~~~
+ - vbus-supply: Phandle to a regulator providing the USB bus power.
+
+Example:
+	usb_phy: usb-phy {
+		compatible = "ti,da830-usb-phy";
+		#phy-cells = <0>;
+		status = "okay";
+	};
+	usb0: usb at 200000 {
+		compatible = "ti,da830-musb";
+		reg =   <0x00200000 0x10000>;
+		interrupts = <58>;
+		interrupt-names = "mc";
+
+		dr_mode = "host";
+		vbus-supply = <&usb_vbus>;
+		phys = <&usb_phy 0>;
+		phy-names = "usb-phy";
+
+		status = "okay";
+	};
-- 
2.7.3
