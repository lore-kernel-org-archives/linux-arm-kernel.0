From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 16 Sep 2013 17:02:13 +0100
Subject: [PATCH 07/20] Documentation: dt: iio: Add binding for LPS001WP
In-Reply-To: <1379347346-823-1-git-send-email-lee.jones@linaro.org>
References: <1379347346-823-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1379347346-823-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LPS001WP is a Pressure and Temperature sensor.

Cc: devicetree at vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/iio/pressure/lps001wp.txt   | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/lps001wp.txt

diff --git a/Documentation/devicetree/bindings/iio/pressure/lps001wp.txt b/Documentation/devicetree/bindings/iio/pressure/lps001wp.txt
new file mode 100644
index 0000000..45cb45c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/lps001wp.txt
@@ -0,0 +1,21 @@
+* STMicroelectronics Pressure Sensor
+
+Required properties:
+  - compatible: Should be "st,lps001wp"
+  - reg: The I2C address of the sensor
+
+Optional properties:
+  - vdd-supply: Phandle to the Vdd supply regulator
+  - vddio-supply: Phandle to the Vdd-IO supply regulator
+
+Example:
+
+i2c at 80128000 {
+        lps001wp at 5c {
+                compatible = "st,lps001wp";
+                reg = <0x5c>;
+
+                vdd-supply = <&ab8500_ldo_aux1_reg>;
+                vddio-supply = <&db8500_vsmps2_reg>;
+        };
+};
-- 
1.8.1.2
