From: david@lechnology.com (David Lechner)
Date: Wed, 16 Mar 2016 21:26:38 -0500
Subject: [PATCH v2 05/11] dt-bindings: Add bindings for phy-da8xx-usb
In-Reply-To: <1458181615-27782-1-git-send-email-david@lechnology.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
Message-ID: <1458181615-27782-6-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device tree binding for new phy-da8xx-usb driver.

Signed-off-by: David Lechner <david@lechnology.com>
---

v2 changes: This is new patch in v2.


 .../devicetree/bindings/phy/phy-da8xx-usb.txt      | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-da8xx-usb.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-da8xx-usb.txt b/Documentation/devicetree/bindings/phy/phy-da8xx-usb.txt
new file mode 100644
index 0000000..ed6b710
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-da8xx-usb.txt
@@ -0,0 +1,34 @@
+TI DaVinci DA8XX USB PHY
+
+Required properties:
+ - compatible: must be "ti,da830-usbphy".
+ - #phy-cells: must be 1.
+ - reg : Address and length of the CFGCHIP2 register.
+
+This device controls the PHY for both the USB 1.1 OHCI and USB 2.0 OTG
+controllers on DA8XX SoCs. Consumers of this device should use index 1 for
+the USB 1.1 phy device and index 2 for the USB 2.0 phy device.
+
+Example:
+
+	usbphy: usbphy at 1c14184 {
+		compatible = "ti,da830-usbphy";
+		#phy-cells = <1>;
+		reg = <0x14184 4>;
+	};
+
+	usb11: usb11 at 1e25000 {
+		compatible = "ti,da830-ohci";
+		reg = <0x225000 0x1000>;
+		interrupts = <59>;
+		phys = <&usbphy 1>;
+		phy-names = "usbphy";
+	};
+
+	usb20: usb at 1e00000 {
+		compatible = "ti,da830-musb";
+		reg = <0x200000 0x1000>;
+		interrupts = <58>;
+		phys = <&usbphy 2>;
+		phy-names = "usbphy";
+	};
-- 
1.9.1
