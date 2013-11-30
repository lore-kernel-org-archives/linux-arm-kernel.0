From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Sat, 30 Nov 2013 09:51:13 +0100
Subject: [PATCH 2/2] ARM: apf28dev: dts: set gpio polarity for usb regulator
 and pinctrl for regulator gpio
In-Reply-To: <1385801473-97460-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1385801473-97460-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <1385801473-97460-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 arch/arm/boot/dts/imx28-apf28dev.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
index 741aecb..334dea5 100644
--- a/arch/arm/boot/dts/imx28-apf28dev.dts
+++ b/arch/arm/boot/dts/imx28-apf28dev.dts
@@ -66,6 +66,16 @@
 					fsl,voltage = <MXS_VOLTAGE_HIGH>;
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
+
+				usb0_otg_apf28dev: otg-apf28dev at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX28_PAD_LCD_D23__GPIO_1_23
+					>;
+					fsl,drive-strength = <MXS_DRIVE_4mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
 			};
 
 			lcdif at 80030000 {
@@ -131,6 +141,8 @@
 
 	ahb at 80080000 {
 		usb0: usb at 80080000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&usb0_otg_apf28dev>;
 			vbus-supply = <&reg_usb0_vbus>;
 			status = "okay";
 		};
@@ -160,6 +172,7 @@
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
 			gpio = <&gpio1 23 1>;
+			enable-active-high;
 		};
 	};
 
-- 
1.8.3.2
