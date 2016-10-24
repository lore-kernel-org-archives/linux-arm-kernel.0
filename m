From: ahaslam@baylibre.com (ahaslam at baylibre.com)
Date: Mon, 24 Oct 2016 18:46:32 +0200
Subject: [PATCH/RFT v2 15/17] usb: host: ohci-da8xx: Add devicetree bindings
 documentation
In-Reply-To: <20161024164634.4330-1-ahaslam@baylibre.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
Message-ID: <20161024164634.4330-16-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Haslam <ahaslam@baylibre.com>

This patch documents the device tree bindings required for
the ohci controller found in TI da8xx family of SoC's

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 .../devicetree/bindings/usb/ohci-da8xx.txt         | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ohci-da8xx.txt

diff --git a/Documentation/devicetree/bindings/usb/ohci-da8xx.txt b/Documentation/devicetree/bindings/usb/ohci-da8xx.txt
new file mode 100644
index 0000000..4251c84
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ohci-da8xx.txt
@@ -0,0 +1,39 @@
+DA8XX USB OHCI controller
+
+Required properties:
+
+ - compatible: Should be "ti,da830-ohci"
+ - reg:        Should contain one register range i.e. start and length
+ - interrupts: Description of the interrupt line
+ - phys:       Phandle for the PHY device
+ - phy-names:  Should be "usb-phy"
+
+Optional properties:
+ - vbus-supply: Regulator that controls vbus power
+
+Example for omap138-lck:
+
+vbus_fixed: fixed-regulator-vbus {
+        compatible = "regulator-fixed";
+        gpio = <&gpio 109 0>;
+        oc-gpio = <&gpio 36 0>;
+        regulator-boot-on;
+        enable-active-high;
+        regulator-name = "vbus";
+        regulator-min-microvolt = <5000000>;
+        regulator-max-microvolt = <5000000>;
+};
+
+usb_phy: usb-phy {
+        compatible = "ti,da830-usb-phy";
+        #phy-cells = <1>;
+        status = "disabled";
+};
+usb: usb at 0225000 {
+        compatible = "ti,da830-ohci";
+        reg = <0x225000 0x1000>;
+        interrupts = <59>;
+        phys = <&usb_phy 1>;
+        phy-names = "usb-phy";
+        status = "disabled";
+};
-- 
1.9.1
