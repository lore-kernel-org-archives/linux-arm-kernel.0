From: eric.nelson@boundarydevices.com (Eric Nelson)
Date: Tue,  2 Dec 2014 15:09:00 -0700
Subject: [PATCH 3/3] ARM: dts: sabrelite: add i2c3
In-Reply-To: <1417558140-16770-1-git-send-email-eric.nelson@boundarydevices.com>
References: <1417558140-16770-1-git-send-email-eric.nelson@boundarydevices.com>
Message-ID: <1417558140-16770-4-git-send-email-eric.nelson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Nelson <eric.nelson@boundarydevices.com>
---
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 3bddc8f..0b28a9d 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -200,6 +200,13 @@
 	status = "okay";
 };
 
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
@@ -284,6 +291,13 @@
 			>;
 		};
 
+		pinctrl_i2c3: i2c3grp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_5__I2C3_SCL		0x4001b8b1
+				MX6QDL_PAD_GPIO_16__I2C3_SDA		0x4001b8b1
+			>;
+		};
+
 		pinctrl_pwm1: pwm1grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD1_DAT3__PWM1_OUT 0x1b0b1
-- 
1.9.1
