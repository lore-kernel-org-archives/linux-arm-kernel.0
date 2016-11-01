From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Tue,  1 Nov 2016 18:10:05 +0100
Subject: [PATCH v2 4/5] ARM: dts: imx6qdl-nit6xlite: use hyphens for nodes name
In-Reply-To: <20161101171006.24594-1-gary.bisson@boundarydevices.com>
References: <20161025211955.5345-1-gary.bisson@boundarydevices.com>
 <20161101171006.24594-1-gary.bisson@boundarydevices.com>
Message-ID: <20161101171006.24594-5-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Therefore aligning the panel nodes name across all platforms.

Also removing the bt_rfkill node since the mainline rfkill-gpio driver
doesn't support device trees.

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi | 32 +++++---------------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi b/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
index 880bd78..63acd54 100644
--- a/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
@@ -97,15 +97,6 @@
 		};
 	};
 
-	bt_rfkill {
-		compatible = "rfkill-gpio";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_bt_rfkill>;
-		gpios = <&gpio6 8 GPIO_ACTIVE_HIGH>;
-		name = "bt_rfkill";
-		type = <2>;
-	};
-
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -160,7 +151,7 @@
 		};
 	};
 
-	backlight_lcd {
+	backlight-lcd {
 		compatible = "pwm-backlight";
 		pwms = <&pwm1 0 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
@@ -169,7 +160,7 @@
 		status = "okay";
 	};
 
-	backlight_lvds0: backlight_lvds0 {
+	backlight_lvds0: backlight-lvds0 {
 		compatible = "pwm-backlight";
 		pwms = <&pwm4 0 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
@@ -178,7 +169,7 @@
 		status = "okay";
 	};
 
-	panel_lvds0 {
+	panel-lvds0 {
 		compatible = "hannstar,hsd100pxn1";
 		backlight = <&backlight_lvds0>;
 
@@ -328,19 +319,6 @@
 			>;
 		};
 
-		pinctrl_bt_rfkill: bt_rfkillgrp {
-			fsl,pins = <
-				/* BT wake */
-				MX6QDL_PAD_NANDF_D2__GPIO2_IO02		0x1b0b0
-				/* BT reset */
-				MX6QDL_PAD_NANDF_ALE__GPIO6_IO08	0x0b0b0
-				/* BT reg en */
-				MX6QDL_PAD_NANDF_CS2__GPIO6_IO15	0x1b0b0
-				/* BT host wake irq */
-				MX6QDL_PAD_NANDF_CS3__GPIO6_IO16	0x100b0
-			>;
-		};
-
 		pinctrl_ecspi1: ecspi1grp {
 			fsl,pins = <
 				MX6QDL_PAD_EIM_D17__ECSPI1_MISO		0x100b1
@@ -374,7 +352,7 @@
 			>;
 		};
 
-		pinctrl_gpio_keys: gpio_keysgrp {
+		pinctrl_gpio_keys: gpio-keysgrp {
 			fsl,pins = <
 				/* Home Button: J14 pin 5 */
 				MX6QDL_PAD_GPIO_18__GPIO7_IO13		0x1b0b0
@@ -457,7 +435,7 @@
 			>;
 		};
 
-		pinctrl_wlan_vmmc: wlan_vmmcgrp {
+		pinctrl_wlan_vmmc: wlan-vmmcgrp {
 			fsl,pins = <
 				MX6QDL_PAD_NANDF_CLE__GPIO6_IO07	0x030b0
 			>;
-- 
2.9.3
