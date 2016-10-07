From: ahaslam@baylibre.com (ahaslam at baylibre.com)
Date: Fri,  7 Oct 2016 18:42:54 +0200
Subject: [PATCH/RFT 09/12] usb: host: ohci-da8xx: Add devicetree bindings
 documentation
In-Reply-To: <1475858577-10366-1-git-send-email-ahaslam@baylibre.com>
References: <1475858577-10366-1-git-send-email-ahaslam@baylibre.com>
Message-ID: <1475858577-10366-10-git-send-email-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Haslam <ahaslam@baylibre.com>

This patch documents the device tree bindings required for
the ohci controller found in TI da8xx family of SoC's

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 .../devicetree/bindings/usb/ohci-da8xx.txt         | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ohci-da8xx.txt

diff --git a/Documentation/devicetree/bindings/usb/ohci-da8xx.txt b/Documentation/devicetree/bindings/usb/ohci-da8xx.txt
new file mode 100644
index 0000000..e954ce5
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ohci-da8xx.txt
@@ -0,0 +1,32 @@
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
+ - vbus-gpio:  If present, specifies a gpio that needs to be
+               activated for the bus to be powered.
+ - oci-gpio:   If present, specifies a gpio that needs to be
+               activated for the overcurrent detection.
+ - power_on_delay: Power On to Power Good time - in ms.
+
+Example for omap138-lck:
+
+usb_phy: usb-phy {
+        compatible = "ti,da830-usb-phy";
+        #phy-cells = <1>;
+        status = "disabled";
+};
+usb11: usb11 at 0225000 {
+        compatible = "ti,da830-ohci";
+        reg = <0x225000 0x1000>;
+        interrupts = <59>;
+        phys = <&usb_phy 1>;
+        phy-names = "usb-phy";
+        status = "disabled";
+};
-- 
2.7.1
