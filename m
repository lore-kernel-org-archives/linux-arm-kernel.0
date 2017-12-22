From: eugen.hristev@microchip.com (Eugen Hristev)
Date: Fri, 22 Dec 2017 17:07:11 +0200
Subject: [PATCH 04/14] dt-bindings: input: touchscreen: sama5d2_rts: create
 bindings
In-Reply-To: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
Message-ID: <1513955241-10985-5-git-send-email-eugen.hristev@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added bindings for Microchip SAMA5D2 resistive touchscreen.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 .../bindings/input/touchscreen/sama5d2_rts.txt     | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/sama5d2_rts.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sama5d2_rts.txt b/Documentation/devicetree/bindings/input/touchscreen/sama5d2_rts.txt
new file mode 100644
index 0000000..ea52a5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/sama5d2_rts.txt
@@ -0,0 +1,31 @@
+Microchip SAMA5D2 resistive touchscreen
+
+Required properties:
+
+ - compatible: microchip,sama5d2-resistive-touch
+
+Optional properties:
+
+The device must be connected to an IIO device that provides channels for
+position and pressure measurement, and a trigger output that will periodically
+trigger when the touch is pressed.
+Refer to ../iio/iio-bindings.txt for details
+
+ - io-channels: can have two or three channels connected to an IIO device.
+These should correspond to the channels exposed by the IIO device and should
+have the right index as the ADC registers them.
+ - io-channel-names: must have the two or three channels' names :
+"x", "y", or "x", "y" and "pressure"
+ - io-triggers: can have a trigger input connected to an IIO device.
+ - microchip,pressure-threshold: a pressure threshold for the touchscreen.
+   Represented by an integer value.
+
+Example:
+
+	resistive_touch: resistive-touch {
+		compatible = "microchip,sama5d2-resistive-touch";
+		microchip,pressure-threshold = <3000>;
+		io-channels = <&adc 19>, <&adc 20>, <&adc 21>;
+		io-channel-names = "x", "y", "pressure";
+		io-triggers = <&adc 1>;
+	};
-- 
2.7.4
