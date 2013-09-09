From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  9 Sep 2013 11:10:08 +0100
Subject: [PATCH 12/14] Documentation: dt: i2c: Add LPS001WP to the Trivial
 Devices list
In-Reply-To: <1378721410-30937-1-git-send-email-lee.jones@linaro.org>
References: <1378721410-30937-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1378721410-30937-13-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LPS001WP is a Pressure and Temperature sensor.

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
