From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 16 Sep 2013 17:02:16 +0100
Subject: [PATCH 10/20] Documentation: dt: iio: Add binding for LSM303DLH - Magn
In-Reply-To: <1379347346-823-1-git-send-email-lee.jones@linaro.org>
References: <1379347346-823-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1379347346-823-11-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LSM303DLH is a Magnetometer Sensor

Cc: devicetree at vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../bindings/iio/magnetometer/lsm303dlhc.txt        | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/lsm303dlhc.txt

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/lsm303dlhc.txt b/Documentation/devicetree/bindings/iio/magnetometer/lsm303dlhc.txt
new file mode 100644
index 0000000..2ad49c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/lsm303dlhc.txt
@@ -0,0 +1,21 @@
+* STMicroelectronics Magnetometer Sensor
+
+Required properties:
+  - compatible: Should be "st,lsm303dlhc_magn"
+  - reg: The I2C address of the sensor
+
+Optional properties:
+  - vdd-supply: Phandle to the Vdd supply regulator
+  - vddio-supply: Phandle to the Vdd-IO supply regulator
+
+Example:
+
+i2c at 80128000 {
+	lsm303dlhc_magn at 1e {
+		compatible = "st,lsm303dlhc_magn";
+		reg = <0x1e>;
+
+		vdd-supply = <&ab8500_ldo_aux1_reg>;
+		vddio-supply = <&db8500_vsmps2_reg>;
+	};
+};
-- 
1.8.1.2
