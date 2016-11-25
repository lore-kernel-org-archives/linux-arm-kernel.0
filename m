From: sergio.prado@e-labworks.com (Sergio Prado)
Date: Fri, 25 Nov 2016 12:47:28 -0200
Subject: [PATCH 1/2] dt-bindings: usb: add DT binding for s3c2410 USB OHCI
 controller
In-Reply-To: <1480085249-25014-1-git-send-email-sergio.prado@e-labworks.com>
References: <1480085249-25014-1-git-send-email-sergio.prado@e-labworks.com>
Message-ID: <1480085249-25014-2-git-send-email-sergio.prado@e-labworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds the device tree bindings description for Samsung S3C2410 and
compatible USB OHCI controller.

Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
---
 .../devicetree/bindings/usb/s3c2410-usb.txt        | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/s3c2410-usb.txt

diff --git a/Documentation/devicetree/bindings/usb/s3c2410-usb.txt b/Documentation/devicetree/bindings/usb/s3c2410-usb.txt
new file mode 100644
index 000000000000..e45b38ce2986
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/s3c2410-usb.txt
@@ -0,0 +1,22 @@
+Samsung S3C2410 and compatible SoC USB controller
+
+OHCI
+
+Required properties:
+ - compatible: should be "samsung,s3c2410-ohci" for USB host controller
+ - reg: address and lenght of the controller memory mapped region
+ - interrupts: interrupt number for the USB OHCI controller
+ - clocks: Should reference the bus and host clocks
+ - clock-names: Should contain two strings
+		"usb-bus-host" for the USB bus clock
+		"usb-host" for the USB host clock
+
+Example:
+
+usb0: ohci at 49000000 {
+	compatible = "samsung,s3c2410-ohci";
+	reg = <0x49000000 0x100>;
+	interrupts = <0 0 26 3>;
+	clocks = <&clocks UCLK>, <&clocks HCLK_USBH>;
+	clock-names = "usb-bus-host", "usb-host";
+};
-- 
1.9.1
