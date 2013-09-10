From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 10 Sep 2013 13:49:13 +0100
Subject: [PATCH 12/38] Documentation: dt: iio: Add binding for L3G4200D
In-Reply-To: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1378817379-8238-13-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

L3G4200D is a Gyroscope Sensor

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/iio/gyro/l3g4200d.txt       | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/gyro/l3g4200d.txt

diff --git a/Documentation/devicetree/bindings/iio/gyro/l3g4200d.txt b/Documentation/devicetree/bindings/iio/gyro/l3g4200d.txt
new file mode 100644
index 0000000..29baf9d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/gyro/l3g4200d.txt
@@ -0,0 +1,21 @@
+* STMicroelectronics Gyroscope Sensor
+
+Required properties:
+  - compatible: Should be "st,l3g4200d_gyro"
+  - reg: The I2C address of the sensor
+
+Optional properties:
+  - vdd-supply: Phandle to the Vdd supply regulator
+  - vddio-supply: Phandle to the Vdd-IO supply regulator
+
+Example:
+
+i2c at 80128000 {
+	l3g4200d_gyro at 68 {
+		compatible = "st,l3g4200d_gyro";
+		reg = <0x68>;
+
+		vdd-supply = <&ab8500_ldo_aux1_reg>;
+		vddio-supply = <&db8500_vsmps2_reg>;
+	};
+};
-- 
1.8.1.2
