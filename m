From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 10 Sep 2013 13:49:11 +0100
Subject: [PATCH 10/38] Documentation: dt: iio: Add binding for LPS001WP
In-Reply-To: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1378817379-8238-11-git-send-email-lee.jones@linaro.org>
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
index 0000000..3294a65c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/lps001wp.txt
@@ -0,0 +1,21 @@
+* STMicroelectronics Pressure Sensor
+
+Required properties:
+  - compatible: Should be "st,lps001wp_press"
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
+                compatible = "st,lps001wp_press";
+                reg = <0x5c>;
+
+                vdd-supply = <&ab8500_ldo_aux1_reg>;
+                vddio-supply = <&db8500_vsmps2_reg>;
+        };
+};
-- 
1.8.1.2
