From: arno@natisbad.org (Arnaud Ebalard)
Date: Fri, 22 Nov 2013 21:07:39 +0100
Subject: [PATCH 4/4] ARM: NETGEAR ReadyNAS Duo v2 and RN102 .dts file
 whitespace cleanup
In-Reply-To: <cover.1385148929.git.arno@natisbad.org>
References: <cover.1385148929.git.arno@natisbad.org>
Message-ID: <9211978b60a76b321db0a5a934d9cb9f959519d9.1385148929.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch provides some whitespace cleanup for NETGEAR
ReadyNAS Duo v2 and 102 .dts files:

 - Fixed bad whitespaces
 - Added spaces between nodes to improve readability

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/armada-370-netgear-rn102.dts     |  1 +
 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  | 48 ++++++++++++++--------
 2 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
index 87cd003..1cbd338 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -64,6 +64,7 @@
 					marvell,pins = "mpp57";
 					marvell,function = "gpio";
 				};
+
 				sata1_led_pin: sata1-led-pin {
 					marvell,pins = "mpp15";
 					marvell,function = "gpio";
diff --git a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
index 65d0587..0961e80 100644
--- a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
+++ b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
@@ -45,34 +45,42 @@
 				marvell,pins = "mpp47";
 				marvell,function = "gpio";
 			};
+
 			pmx_button_backup: pmx-button-backup {
 				marvell,pins = "mpp45";
 				marvell,function = "gpio";
 			};
+
 			pmx_button_reset: pmx-button-reset {
 				marvell,pins = "mpp13";
 				marvell,function = "gpio";
 			};
+
 			pmx_led_blue_power: pmx-led-blue-power {
 				marvell,pins = "mpp31";
 				marvell,function = "gpio";
 			};
+
 			pmx_led_blue_activity: pmx-led-blue-activity {
 				marvell,pins = "mpp38";
 				marvell,function = "gpio";
 			};
+
 			pmx_led_blue_disk1: pmx-led-blue-disk1 {
 				marvell,pins = "mpp23";
 				marvell,function = "gpio";
 			};
+
 			pmx_led_blue_disk2: pmx-led-blue-disk2 {
 				marvell,pins = "mpp22";
 				marvell,function = "gpio";
 			};
+
 			pmx_led_blue_backup: pmx-led-blue-backup {
 				marvell,pins = "mpp29";
 				marvell,function = "gpio";
 			};
+
 			pmx_poweroff: pmx-poweroff {
 				marvell,pins = "mpp30";
 				marvell,function = "gpio";
@@ -129,18 +137,22 @@
 			gpios = <&gpio0 31 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
+
 		activity_led {
 			label = "status:blue:activity_led";
 			gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
 		};
+
 		disk1_led {
 			label = "status:blue:disk1_led";
 			gpios = <&gpio0 23 GPIO_ACTIVE_LOW>;
 		};
+
 		disk2_led {
 			label = "status:blue:disk2_led";
 			gpios = <&gpio0 22 GPIO_ACTIVE_LOW>;
 		};
+
 		backup_led {
 			label = "status:blue:backup_led";
 			gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
@@ -158,11 +170,13 @@
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
 		};
+
 		reset-button {
 			label = "Reset Button";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
 		};
+
 		backup-button {
 			label = "Backup Button";
 			linux,code = <KEY_COPY>;
@@ -177,23 +191,23 @@
 		gpios = <&gpio0 30 GPIO_ACTIVE_LOW>;
 	};
 
-        regulators {
-                compatible = "simple-bus";
-                #address-cells = <1>;
-                #size-cells = <0>;
-
-                usb_power: regulator at 1 {
-                        compatible = "regulator-fixed";
-                        reg = <1>;
-                        regulator-name = "USB 3.0 Power";
-                        regulator-min-microvolt = <5000000>;
-                        regulator-max-microvolt = <5000000>;
-                        enable-active-high;
-                        regulator-always-on;
-                        regulator-boot-on;
-                        gpio = <&gpio1 14 0>;
-                };
-        };
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usb3_regulator: usb3-regulator {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "USB 3.0 Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
+		};
+	};
 };
 
 &nand {
-- 
1.8.4.4
