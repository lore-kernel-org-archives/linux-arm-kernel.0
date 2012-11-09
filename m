From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Fri,  9 Nov 2012 13:42:41 +0100
Subject: [PATCH v2] ARM: mxs: apf28dev: Add I2C and SPI support
Message-ID: <1352464961-6414-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
	- Removed the spidev support.

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 arch/arm/boot/dts/imx28-apf28dev.dts |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
index 1643d25..6d8865b 100644
--- a/arch/arm/boot/dts/imx28-apf28dev.dts
+++ b/arch/arm/boot/dts/imx28-apf28dev.dts
@@ -27,6 +27,13 @@
 				status = "okay";
 			};
 
+			ssp2: ssp at 80014000 {
+				compatible = "fsl,imx28-spi";
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi2_pins_a>;
+				status = "okay";
+			};
+
 			pinctrl at 80018000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_apf28dev>;
@@ -74,6 +81,12 @@
 				status = "okay";
 			};
 
+			i2c0: i2c at 80058000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&i2c0_pins_a>;
+				status = "okay";
+			};
+
 			pwm: pwm at 80064000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pwm3_pins_a &pwm4_pins_a>;
-- 
1.7.8.6
