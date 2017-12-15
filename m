From: m.tretter@pengutronix.de (Michael Tretter)
Date: Fri, 15 Dec 2017 10:26:24 +0100
Subject: [PATCH] ARM: dts: imx6q-h100: use usdhc2 VSELECT
Message-ID: <20171215092624.12806-1-m.tretter@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The uSDHC controller directly provides a VSELECT signal that can be
muxed to the external voltage select. Mux the VSELECT directly to avoid
using a GPIO.

Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
---
 arch/arm/boot/dts/imx6q-h100.dts | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-h100.dts b/arch/arm/boot/dts/imx6q-h100.dts
index a3269f57df2b..450ec967c257 100644
--- a/arch/arm/boot/dts/imx6q-h100.dts
+++ b/arch/arm/boot/dts/imx6q-h100.dts
@@ -108,21 +108,6 @@
 		regulator-always-on;
 	};
 
-	reg_nvcc_sd2: regulator-nvcc-sd2 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_h100_reg_nvcc_sd2>;
-		compatible = "regulator-gpio";
-		regulator-name = "NVCC_SD2";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-type = "voltage";
-		regulator-boot-on;
-		regulator-always-on;
-		gpios = <&gpio4 9 GPIO_ACTIVE_HIGH>;
-		states = <1800000 0x1
-			  3300000 0x0>;
-	};
-
 	reg_usbh1_vbus: regulator-usb-h1-vbus {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -260,12 +245,6 @@
 			>;
 		};
 
-		pinctrl_h100_reg_nvcc_sd2: h100-reg-nvcc-sd2 {
-			fsl,pins = <
-				MX6QDL_PAD_KEY_ROW1__GPIO4_IO09		0x1b0b0
-			>;
-		};
-
 		pinctrl_h100_sgtl5000: h100-sgtl5000 {
 			fsl,pins = <
 				MX6QDL_PAD_DISP0_DAT19__AUD5_RXD	0x130b0
@@ -316,6 +295,7 @@
 				MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17059
 				MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17059
 				MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x13059
+				MX6QDL_PAD_KEY_ROW1__SD2_VSELECT	0x1b0b0
 			>;
 		};
 
@@ -328,6 +308,7 @@
 				MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x170b9
 				MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x170b9
 				MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x170b9
+				MX6QDL_PAD_KEY_ROW1__SD2_VSELECT	0x1b0b0
 			>;
 		};
 
@@ -340,6 +321,7 @@
 				MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x170f9
 				MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x170f9
 				MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x170f9
+				MX6QDL_PAD_KEY_ROW1__SD2_VSELECT	0x1b0b0
 			>;
 		};
 	};
@@ -389,7 +371,6 @@
 	pinctrl-1 = <&pinctrl_h100_usdhc2_100mhz>;
 	pinctrl-2 = <&pinctrl_h100_usdhc2_200mhz>;
 	vmmc-supply = <&reg_3p3v>;
-	vqmmc-supply = <&reg_nvcc_sd2>;
 	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
-- 
2.11.0
