From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Sat, 18 Mar 2017 01:01:31 +0100
Subject: [PATCH 1/2] dt-bindings: thermal: add support for Raspberry Pi thermal
Message-ID: <20170318000132.9212-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

This commit documents binding for BCM2835 SoC thermal used in Raspberry
Pi devices.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 .../bindings/thermal/raspberrypi,bcm2835-thermal        | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/raspberrypi,bcm2835-thermal

diff --git a/Documentation/devicetree/bindings/thermal/raspberrypi,bcm2835-thermal b/Documentation/devicetree/bindings/thermal/raspberrypi,bcm2835-thermal
new file mode 100644
index 000000000000..fbffa9291ba9
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/raspberrypi,bcm2835-thermal
@@ -0,0 +1,17 @@
+* Broadcom BCM2835 SoC Raspberry Pi Thermal
+
+This binding describes thermal sensor that is part of BCM2835 SoC.
+
+Required properties:
+- compatible : Must be "raspberrypi,bcm2835-thermal"
+- firmware : Reference to the Raspberry Pi firmware device node, see
+	raspberrypi,bcm2835-firmware for details
+- #thermal-sensor-cells : Should be <0>
+
+Example:
+
+thermal {
+	compatible = "raspberrypi,bcm2835-thermal";
+	firmware = <&firmware>;
+	#thermal-sensor-cells = <0>;
+};
-- 
2.11.0
