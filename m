From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 10 Sep 2013 13:49:14 +0100
Subject: [PATCH 13/38] Documentation: dt: iio: Add binding for LSM303DLH
In-Reply-To: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1378817379-8238-14-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LSM303DLH is a Magnetometer Sensor

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../bindings/iio/magnetometer/lsm303dlh.txt         | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/lsm303dlh.txt

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/lsm303dlh.txt b/Documentation/devicetree/bindings/iio/magnetometer/lsm303dlh.txt
new file mode 100644
index 0000000..5938369
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/lsm303dlh.txt
@@ -0,0 +1,21 @@
+* STMicroelectronics Magnetometer Sensor
+
+Required properties:
+  - compatible: Should be "st,lsm303dlh_magn"
+  - reg: The I2C address of the sensor
+
+Optional properties:
+  - vdd-supply: Phandle to the Vdd supply regulator
+  - vddio-supply: Phandle to the Vdd-IO supply regulator
+
+Example:
+
+i2c at 80128000 {
+	lsm303dlh_magn at 1e {
+		compatible = "st,lsm303dlh_magn";
+		reg = <0x1e>;
+
+		vdd-supply = <&ab8500_ldo_aux1_reg>;
+		vddio-supply = <&db8500_vsmps2_reg>;
+	};
+};
-- 
1.8.1.2
