From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 10 Sep 2013 13:49:12 +0100
Subject: [PATCH 11/38] Documentation: dt: iio: Add binding for LSM303DLH
In-Reply-To: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1378817379-8238-12-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LSM303DLH is a Accelerometer Sensor

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/iio/accel/lsm303dlh.txt     | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/lsm303dlh.txt

diff --git a/Documentation/devicetree/bindings/iio/accel/lsm303dlh.txt b/Documentation/devicetree/bindings/iio/accel/lsm303dlh.txt
new file mode 100644
index 0000000..bb59363
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/lsm303dlh.txt
@@ -0,0 +1,21 @@
+* STMicroelectronics Accelerometer Sensor
+
+Required properties:
+  - compatible: Should be "st,lsm303dlh_accel"
+  - reg: The I2C address of the sensor
+
+Optional properties:
+  - vdd-supply: Phandle to the Vdd supply regulator
+  - vddio-supply: Phandle to the Vdd-IO supply regulator
+
+Example:
+
+i2c at 80128000 {
+	lsm303dlh_accel at 19 {
+		compatible = "st,lsm303dlh_accel";
+		reg = <0x19>;
+
+		vdd-supply = <&ab8500_ldo_aux1_reg>;
+		vddio-supply = <&db8500_vsmps2_reg>;
+	};
+};
-- 
1.8.1.2
