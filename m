From: breno.lima@nxp.com (Breno Lima)
Date: Tue, 9 Aug 2016 15:40:45 -0300
Subject: [PATCH 1/2] ARM: dts: imx7s-warp: Add MPL3115 sensor support
Message-ID: <1470768046-28416-1-git-send-email-breno.lima@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for MPL3115 NXP pressure sensor.

Tested by reading temperature and pressure:

$ cat /sys/bus/iio/devices/iio:device0/in_temp_raw
$ cat /sys/bus/iio/devices/iio:device0/in_pressure_raw

Signed-off-by: Breno Lima <breno.lima@nxp.com>
---
 arch/arm/boot/dts/imx7s-warp.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
index e318c98..ae23781 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -155,6 +155,18 @@
 	};
 };
 
+&i2c4 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	status = "okay";
+
+	mpl3115 at 60 {
+		compatible = "fsl,mpl3115";
+		reg = <0x60>;
+	};
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
@@ -189,6 +201,13 @@
 		>;
 	};
 
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX7D_PAD_I2C4_SCL__I2C4_SCL	0x4000007f
+			MX7D_PAD_I2C4_SDA__I2C4_SDA	0x4000007f
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
-- 
2.7.4
