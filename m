From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 25 Jul 2014 12:49:53 +0200
Subject: [PATCH 3/3] ARM: dts: nitrogen6x: add i2c3
In-Reply-To: <1406285393-23545-1-git-send-email-l.stach@pengutronix.de>
References: <1406285393-23545-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1406285393-23545-3-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index 4e27cf9f3d2e..3e09f260f5a1 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -202,6 +202,13 @@
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
@@ -286,6 +293,13 @@
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
2.0.1
