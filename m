From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Thu, 28 Nov 2013 08:19:32 +0100
Subject: [PATCHv2 3/3] ARM: dts: imx27: imx27-apf27dev: add pinctrl for cspi,
 i2c, sdhc and framebuffer
In-Reply-To: <1385623172-87429-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1385623172-87429-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
 <1385623172-87429-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <1385623172-87429-3-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
Changelog:
v2:
 * Fix framebuffer pingroup name: MX27_FB1_PINGRP1 -> MX27_FB_PINGRP1

 arch/arm/boot/dts/imx27-apf27dev.dts | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-apf27dev.dts b/arch/arm/boot/dts/imx27-apf27dev.dts
index 9197329..0010b3e 100644
--- a/arch/arm/boot/dts/imx27-apf27dev.dts
+++ b/arch/arm/boot/dts/imx27-apf27dev.dts
@@ -60,6 +60,8 @@
 &cspi1 {
 	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio4 28 1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_cspi1>;
 	status = "okay";
 };
 
@@ -67,17 +69,23 @@
 	fsl,spi-num-chipselects = <3>;
 	cs-gpios = <&gpio4 21 1>, <&gpio4 27 1>,
 			<&gpio2 17 1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_cspi2>;
 	status = "okay";
 };
 
 &fb {
 	display = <&display>;
 	fsl,dmacr = <0x00020010>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_imxfb1>;
 	status = "okay";
 };
 
 &i2c1 {
 	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
 	rtc at 68 {
@@ -87,11 +95,43 @@
 };
 
 &i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
 };
 
+&iomuxc {
+	imx27-apf27dev {
+		pinctrl_cspi1: cspi1grp {
+			fsl,pins = <MX27_CSPI1_PINGRP1>;
+		};
+
+		pinctrl_cspi2: cspi2grp {
+			fsl,pins = <MX27_CSPI2_PINGRP1>;
+		};
+
+		pinctrl_imxfb1: imxfbgrp {
+			fsl,pins = <MX27_FB_PINGRP1>;
+		};
+
+		pinctrl_i2c1: i2c1grp {
+			fsl,pins = <MX27_I2C1_PINGRP1>;
+		};
+
+		pinctrl_i2c2: i2c2grp {
+			fsl,pins = <MX27_I2C2_PINGRP1>;
+		};
+
+		pinctrl_sdhc2: sdhc2grp {
+			fsl,pins = <MX27_SDHC2_PINGRP1>;
+		};
+	};
+};
+
 &sdhci2 {
 	bus-width = <4>;
 	cd-gpios = <&gpio3 14 0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdhc2>;
 	status = "okay";
 };
-- 
1.8.3.2
