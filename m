From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Tue,  3 Dec 2013 08:50:52 +0100
Subject: [PATCHv2 3/3] ARM: dts: imx27-apf27dev: Add pinctrl for cspi
 chip-select, sdhci2 card-detect, gpio-leds and gpio-keys
In-Reply-To: <1386057052-9978-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1386057052-9978-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
 <1386057052-9978-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <1386057052-9978-3-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 arch/arm/boot/dts/imx27-apf27dev.dts | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-apf27dev.dts b/arch/arm/boot/dts/imx27-apf27dev.dts
index 6069331..c8d3cb4 100644
--- a/arch/arm/boot/dts/imx27-apf27dev.dts
+++ b/arch/arm/boot/dts/imx27-apf27dev.dts
@@ -38,6 +38,8 @@
 
 	gpio-keys {
 		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
 
 		user-key {
 			label = "user";
@@ -48,6 +50,8 @@
 
 	leds {
 		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
 
 		user {
 			label = "Heartbeat";
@@ -61,7 +65,7 @@
 	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio4 28 1>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_cspi1>;
+	pinctrl-0 = <&pinctrl_cspi1 &pinctrl_cspi1_cs>;
 	status = "okay";
 };
 
@@ -70,7 +74,7 @@
 	cs-gpios = <&gpio4 21 1>, <&gpio4 27 1>,
 			<&gpio2 17 1>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_cspi2>;
+	pinctrl-0 = <&pinctrl_cspi2 &pinctrl_cspi2_cs>;
 	status = "okay";
 };
 
@@ -106,10 +110,22 @@
 			fsl,pins = <MX27_CSPI1_PINGRP1>;
 		};
 
+		pinctrl_cspi1_cs: cspi1csgrp {
+			fsl,pins = <MX27_PAD_CSPI1_SS0__GPIO4_28 0x0>;
+		};
+
 		pinctrl_cspi2: cspi2grp {
 			fsl,pins = <MX27_CSPI2_PINGRP1>;
 		};
 
+		pinctrl_cspi2_cs: cspi2csgrp {
+			fsl,pins = <
+				MX27_PAD_CSI_D5__GPIO2_17 0x0
+				MX27_PAD_CSPI2_SS0__GPIO4_21 0x0
+				MX27_PAD_CSPI1_SS1__GPIO4_27 0x0
+			>;
+		};
+
 		pinctrl_imxfb1: imxfbgrp {
 			fsl,pins = <MX27_FB_PINGRP1>;
 		};
@@ -126,9 +142,21 @@
 			fsl,pins = <MX27_SDHC2_PINGRP1>;
 		};
 
+		pinctrl_sdhc2_cd: sdhc2cdgrp {
+			fsl,pins = <MX27_PAD_TOUT__GPIO3_14 0x0>;
+		};
+
 		pinctrl_pwm0: pwm0grp {
 			fsl,pins = <MX27_PWM0_PINGRP1>;
 		};
+
+		pinctrl_gpio_leds: gpioledsgrp {
+			fsl,pins = <MX27_PAD_PC_VS1__GPIO6_14 0x0>;
+		};
+
+		pinctrl_gpio_keys: gpiokeysgrp {
+			fsl,pins = <MX27_PAD_PC_VS2__GPIO6_13 0x0>;
+		};
 	};
 };
 
@@ -136,7 +164,7 @@
 	bus-width = <4>;
 	cd-gpios = <&gpio3 14 0>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sdhc2>;
+	pinctrl-0 = <&pinctrl_sdhc2 &pinctrl_sdhc2_cd>;
 	status = "okay";
 };
 
-- 
1.8.3.2
