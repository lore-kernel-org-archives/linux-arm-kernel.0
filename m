From: richard.zhao@linaro.org (Richard Zhao)
Date: Wed, 14 Dec 2011 09:26:44 +0800
Subject: [PATCH V3 1/4] dts/imx: rename gpio labels to consistent with hw spec
In-Reply-To: <1323826007-17937-1-git-send-email-richard.zhao@linaro.org>
References: <1323826007-17937-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1323826007-17937-2-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO1/GPIO2/... is more readable than GPIO0/GPIO1/... .
Remove redundant gpio comments.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/boot/dts/imx51-babbage.dts   |   11 +++++------
 arch/arm/boot/dts/imx51.dtsi          |    8 ++++----
 arch/arm/boot/dts/imx53-ard.dts       |   16 ++++++++--------
 arch/arm/boot/dts/imx53-evk.dts       |   15 +++++++--------
 arch/arm/boot/dts/imx53-qsb.dts       |   16 ++++++++--------
 arch/arm/boot/dts/imx53-smd.dts       |   13 ++++++-------
 arch/arm/boot/dts/imx53.dtsi          |   14 +++++++-------
 arch/arm/boot/dts/imx6q-sabreauto.dts |    6 +++---
 arch/arm/boot/dts/imx6q.dtsi          |   14 +++++++-------
 9 files changed, 55 insertions(+), 58 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index f8766af..ed09dc1 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -35,8 +35,8 @@
 				};
 
 				esdhc at 70008000 { /* ESDHC2 */
-					cd-gpios = <&gpio0 6 0>; /* GPIO1_6 */
-					wp-gpios = <&gpio0 5 0>; /* GPIO1_5 */
+					cd-gpios = <&gpio1 6 0>;
+					wp-gpios = <&gpio1 5 0>;
 					status = "okay";
 				};
 
@@ -47,8 +47,7 @@
 
 				ecspi at 70010000 { /* ECSPI1 */
 					fsl,spi-num-chipselects = <2>;
-					cs-gpios = <&gpio3 24 0>, /* GPIO4_24 */
-						   <&gpio3 25 0>; /* GPIO4_25 */
+					cs-gpios = <&gpio4 24 0>, <&gpio4 25 0>;
 					status = "okay";
 
 					pmic: mc13892 at 0 {
@@ -57,7 +56,7 @@
 						compatible = "fsl,mc13892";
 						spi-max-frequency = <6000000>;
 						reg = <0>;
-						mc13xxx-irq-gpios = <&gpio0 8 0>; /* GPIO1_8 */
+						mc13xxx-irq-gpios = <&gpio1 8 0>;
 						fsl,mc13xxx-uses-regulator;
 					};
 
@@ -127,7 +126,7 @@
 
 		power {
 			label = "Power Button";
-			gpios = <&gpio1 21 0>;
+			gpios = <&gpio2 21 0>;
 			linux,code = <116>; /* KEY_POWER */
 			gpio-key,wakeup;
 		};
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 327ab8e..57a790d 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -117,7 +117,7 @@
 				};
 			};
 
-			gpio0: gpio at 73f84000 { /* GPIO1 */
+			gpio1: gpio at 73f84000 {
 				compatible = "fsl,imx51-gpio", "fsl,imx31-gpio";
 				reg = <0x73f84000 0x4000>;
 				interrupts = <50 51>;
@@ -127,7 +127,7 @@
 				#interrupt-cells = <1>;
 			};
 
-			gpio1: gpio at 73f88000 { /* GPIO2 */
+			gpio2: gpio at 73f88000 {
 				compatible = "fsl,imx51-gpio", "fsl,imx31-gpio";
 				reg = <0x73f88000 0x4000>;
 				interrupts = <52 53>;
@@ -137,7 +137,7 @@
 				#interrupt-cells = <1>;
 			};
 
-			gpio2: gpio at 73f8c000 { /* GPIO3 */
+			gpio3: gpio at 73f8c000 {
 				compatible = "fsl,imx51-gpio", "fsl,imx31-gpio";
 				reg = <0x73f8c000 0x4000>;
 				interrupts = <54 55>;
@@ -147,7 +147,7 @@
 				#interrupt-cells = <1>;
 			};
 
-			gpio3: gpio at 73f90000 { /* GPIO4 */
+			gpio4: gpio at 73f90000 {
 				compatible = "fsl,imx51-gpio", "fsl,imx31-gpio";
 				reg = <0x73f90000 0x4000>;
 				interrupts = <56 57>;
diff --git a/arch/arm/boot/dts/imx53-ard.dts b/arch/arm/boot/dts/imx53-ard.dts
index 2ab7f80..78c949e 100644
--- a/arch/arm/boot/dts/imx53-ard.dts
+++ b/arch/arm/boot/dts/imx53-ard.dts
@@ -29,8 +29,8 @@
 		aips at 50000000 { /* AIPS1 */
 			spba at 50000000 {
 				esdhc at 50004000 { /* ESDHC1 */
-					cd-gpios = <&gpio0 1 0>; /* GPIO1_1 */
-					wp-gpios = <&gpio0 9 0>; /* GPIO1_9 */
+					cd-gpios = <&gpio1 1 0>;
+					wp-gpios = <&gpio1 9 0>;
 					status = "okay";
 				};
 			};
@@ -67,7 +67,7 @@
 			compatible = "smsc,lan9220", "smsc,lan9115";
 			reg = <0xf4000000 0x2000000>;
 			phy-mode = "mii";
-			interrupt-parent = <&gpio1>;
+			interrupt-parent = <&gpio2>;
 			interrupts = <31>;
 			reg-io-width = <4>;
 			smsc,irq-push-pull;
@@ -79,34 +79,34 @@
 
 		home {
 			label = "Home";
-			gpios = <&gpio4 10 0>; /* GPIO5_10 */
+			gpios = <&gpio5 10 0>;
 			linux,code = <102>; /* KEY_HOME */
 			gpio-key,wakeup;
 		};
 
 		back {
 			label = "Back";
-			gpios = <&gpio4 11 0>; /* GPIO5_11 */
+			gpios = <&gpio5 11 0>;
 			linux,code = <158>; /* KEY_BACK */
 			gpio-key,wakeup;
 		};
 
 		program {
 			label = "Program";
-			gpios = <&gpio4 12 0>; /* GPIO5_12 */
+			gpios = <&gpio5 12 0>;
 			linux,code = <362>; /* KEY_PROGRAM */
 			gpio-key,wakeup;
 		};
 
 		volume-up {
 			label = "Volume Up";
-			gpios = <&gpio4 13 0>; /* GPIO5_13 */
+			gpios = <&gpio5 13 0>;
 			linux,code = <115>; /* KEY_VOLUMEUP */
 		};
 
 		volume-down {
 			label = "Volume Down";
-			gpios = <&gpio3 0 0>; /* GPIO4_0 */
+			gpios = <&gpio4 0 0>;
 			linux,code = <114>; /* KEY_VOLUMEDOWN */
 		};
 	};
diff --git a/arch/arm/boot/dts/imx53-evk.dts b/arch/arm/boot/dts/imx53-evk.dts
index 3f3a881..964743e 100644
--- a/arch/arm/boot/dts/imx53-evk.dts
+++ b/arch/arm/boot/dts/imx53-evk.dts
@@ -29,15 +29,14 @@
 		aips at 50000000 { /* AIPS1 */
 			spba at 50000000 {
 				esdhc at 50004000 { /* ESDHC1 */
-					cd-gpios = <&gpio2 13 0>; /* GPIO3_13 */
-					wp-gpios = <&gpio2 14 0>; /* GPIO3_14 */
+					cd-gpios = <&gpio3 13 0>;
+					wp-gpios = <&gpio3 14 0>;
 					status = "okay";
 				};
 
 				ecspi at 50010000 { /* ECSPI1 */
 					fsl,spi-num-chipselects = <2>;
-					cs-gpios = <&gpio1 30 0>, /* GPIO2_30 */
-						   <&gpio2 19 0>; /* GPIO3_19 */
+					cs-gpios = <&gpio2 30 0>, <&gpio3 19 0>;
 					status = "okay";
 
 					flash: at45db321d at 1 {
@@ -61,8 +60,8 @@
 				};
 
 				esdhc at 50020000 { /* ESDHC3 */
-					cd-gpios = <&gpio2 11 0>; /* GPIO3_11 */
-					wp-gpios = <&gpio2 12 0>; /* GPIO3_12 */
+					cd-gpios = <&gpio3 11 0>;
+					wp-gpios = <&gpio3 12 0>;
 					status = "okay";
 				};
 			};
@@ -102,7 +101,7 @@
 
 			fec at 63fec000 {
 				phy-mode = "rmii";
-				phy-reset-gpios = <&gpio6 6 0>; /* GPIO7_6 */
+				phy-reset-gpios = <&gpio7 6 0>;
 				status = "okay";
 			};
 		};
@@ -113,7 +112,7 @@
 
 		green {
 			label = "Heartbeat";
-			gpios = <&gpio6 7 0>; /* GPIO7_7 */
+			gpios = <&gpio7 7 0>;
 			linux,default-trigger = "heartbeat";
 		};
 	};
diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
index ae6de6d..cc43bde 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -29,13 +29,13 @@
 		aips at 50000000 { /* AIPS1 */
 			spba at 50000000 {
 				esdhc at 50004000 { /* ESDHC1 */
-					cd-gpios = <&gpio2 13 0>; /* GPIO3_13 */
+					cd-gpios = <&gpio3 13 0>;
 					status = "okay";
 				};
 
 				esdhc at 50020000 { /* ESDHC3 */
-					cd-gpios = <&gpio2 11 0>; /* GPIO3_11 */
-					wp-gpios = <&gpio2 12 0>; /* GPIO3_12 */
+					cd-gpios = <&gpio3 11 0>;
+					wp-gpios = <&gpio3 12 0>;
 					status = "okay";
 				};
 			};
@@ -84,7 +84,7 @@
 
 			fec at 63fec000 {
 				phy-mode = "rmii";
-				phy-reset-gpios = <&gpio6 6 0>; /* GPIO7_6 */
+				phy-reset-gpios = <&gpio7 6 0>;
 				status = "okay";
 			};
 		};
@@ -95,20 +95,20 @@
 
 		power {
 			label = "Power Button";
-			gpios = <&gpio0 8 0>; /* GPIO1_8 */
+			gpios = <&gpio1 8 0>;
 			linux,code = <116>; /* KEY_POWER */
 			gpio-key,wakeup;
 		};
 
 		volume-up {
 			label = "Volume Up";
-			gpios = <&gpio1 14 0>; /* GPIO2_14 */
+			gpios = <&gpio2 14 0>;
 			linux,code = <115>; /* KEY_VOLUMEUP */
 		};
 
 		volume-down {
 			label = "Volume Down";
-			gpios = <&gpio1 15 0>; /* GPIO2_15 */
+			gpios = <&gpio2 15 0>;
 			linux,code = <114>; /* KEY_VOLUMEDOWN */
 		};
 	};
@@ -118,7 +118,7 @@
 
 		user {
 			label = "Heartbeat";
-			gpios = <&gpio6 7 0>; /* GPIO7_7 */
+			gpios = <&gpio7 7 0>;
 			linux,default-trigger = "heartbeat";
 		};
 	};
diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
index b1c062e..9e51bc3 100644
--- a/arch/arm/boot/dts/imx53-smd.dts
+++ b/arch/arm/boot/dts/imx53-smd.dts
@@ -29,8 +29,8 @@
 		aips at 50000000 { /* AIPS1 */
 			spba at 50000000 {
 				esdhc at 50004000 { /* ESDHC1 */
-					cd-gpios = <&gpio2 13 0>; /* GPIO3_13 */
-					wp-gpios = <&gpio3 11 0>; /* GPIO4_11 */
+					cd-gpios = <&gpio3 13 0>;
+					wp-gpios = <&gpio4 11 0>;
 					status = "okay";
 				};
 
@@ -46,8 +46,7 @@
 
 				ecspi at 50010000 { /* ECSPI1 */
 					fsl,spi-num-chipselects = <2>;
-					cs-gpios = <&gpio1 30 0>, /* GPIO2_30 */
-						   <&gpio2 19 0>; /* GPIO3_19 */
+					cs-gpios = <&gpio2 30 0>, <&gpio3 19 0>;
 					status = "okay";
 
 					zigbee: mc1323 at 0 {
@@ -145,7 +144,7 @@
 
 			fec at 63fec000 {
 				phy-mode = "rmii";
-				phy-reset-gpios = <&gpio6 6 0>; /* GPIO7_6 */
+				phy-reset-gpios = <&gpio7 6 0>;
 				status = "okay";
 			};
 		};
@@ -156,13 +155,13 @@
 
 		volume-up {
 			label = "Volume Up";
-			gpios = <&gpio1 14 0>; /* GPIO2_14 */
+			gpios = <&gpio2 14 0>;
 			linux,code = <115>; /* KEY_VOLUMEUP */
 		};
 
 		volume-down {
 			label = "Volume Down";
-			gpios = <&gpio1 15 0>; /* GPIO2_15 */
+			gpios = <&gpio2 15 0>;
 			linux,code = <114>; /* KEY_VOLUMEDOWN */
 		};
 	};
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 099cd84..3b15cdc 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -119,7 +119,7 @@
 				};
 			};
 
-			gpio0: gpio at 53f84000 { /* GPIO1 */
+			gpio1: gpio at 53f84000 {
 				compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
 				reg = <0x53f84000 0x4000>;
 				interrupts = <50 51>;
@@ -129,7 +129,7 @@
 				#interrupt-cells = <1>;
 			};
 
-			gpio1: gpio at 53f88000 { /* GPIO2 */
+			gpio2: gpio at 53f88000 {
 				compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
 				reg = <0x53f88000 0x4000>;
 				interrupts = <52 53>;
@@ -139,7 +139,7 @@
 				#interrupt-cells = <1>;
 			};
 
-			gpio2: gpio at 53f8c000 { /* GPIO3 */
+			gpio3: gpio at 53f8c000 {
 				compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
 				reg = <0x53f8c000 0x4000>;
 				interrupts = <54 55>;
@@ -149,7 +149,7 @@
 				#interrupt-cells = <1>;
 			};
 
-			gpio3: gpio at 53f90000 { /* GPIO4 */
+			gpio4: gpio at 53f90000 {
 				compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
 				reg = <0x53f90000 0x4000>;
 				interrupts = <56 57>;
@@ -187,7 +187,7 @@
 				status = "disabled";
 			};
 
-			gpio4: gpio at 53fdc000 { /* GPIO5 */
+			gpio5: gpio at 53fdc000 {
 				compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
 				reg = <0x53fdc000 0x4000>;
 				interrupts = <103 104>;
@@ -197,7 +197,7 @@
 				#interrupt-cells = <1>;
 			};
 
-			gpio5: gpio at 53fe0000 { /* GPIO6 */
+			gpio6: gpio at 53fe0000 {
 				compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
 				reg = <0x53fe0000 0x4000>;
 				interrupts = <105 106>;
@@ -207,7 +207,7 @@
 				#interrupt-cells = <1>;
 			};
 
-			gpio6: gpio at 53fe4000 { /* GPIO7 */
+			gpio7: gpio at 53fe4000 {
 				compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
 				reg = <0x53fe4000 0x4000>;
 				interrupts = <107 108>;
diff --git a/arch/arm/boot/dts/imx6q-sabreauto.dts b/arch/arm/boot/dts/imx6q-sabreauto.dts
index 072974e..cd11ab0 100644
--- a/arch/arm/boot/dts/imx6q-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6q-sabreauto.dts
@@ -34,8 +34,8 @@
 			};
 
 			usdhc at 02198000 { /* uSDHC3 */
-				cd-gpios = <&gpio5 11 0>; /* GPIO6_11 */
-				wp-gpios = <&gpio5 14 0>; /* GPIO6_14 */
+				cd-gpios = <&gpio6 11 0>;
+				wp-gpios = <&gpio6 14 0>;
 				status = "okay";
 			};
 
@@ -55,7 +55,7 @@
 
 		debug-led {
 			label = "Heartbeat";
-			gpios = <&gpio2 25 0>; /* GPIO3_25 */
+			gpios = <&gpio3 25 0>;
 			linux,default-trigger = "heartbeat";
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 7dda599..9d0bf4b 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -247,7 +247,7 @@
 				interrupts = <0 55 0x04>;
 			};
 
-			gpio0: gpio at 0209c000 { /* GPIO1 */
+			gpio1: gpio at 0209c000 {
 				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
 				reg = <0x0209c000 0x4000>;
 				interrupts = <0 66 0x04 0 67 0x04>;
@@ -257,7 +257,7 @@
 				#interrupt-cells = <1>;
 			};
 
-			gpio1: gpio at 020a0000 { /* GPIO2 */
+			gpio2: gpio at 020a0000 {
 				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
 				reg = <0x020a0000 0x4000>;
 				interrupts = <0 68 0x04 0 69 0x04>;
@@ -267,7 +267,7 @@
 				#interrupt-cells = <1>;
 			};
 
-			gpio2: gpio at 020a4000 { /* GPIO3 */
+			gpio3: gpio at 020a4000 {
 				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
 				reg = <0x020a4000 0x4000>;
 				interrupts = <0 70 0x04 0 71 0x04>;
@@ -277,7 +277,7 @@
 				#interrupt-cells = <1>;
 			};
 
-			gpio3: gpio at 020a8000 { /* GPIO4 */
+			gpio4: gpio at 020a8000 {
 				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
 				reg = <0x020a8000 0x4000>;
 				interrupts = <0 72 0x04 0 73 0x04>;
@@ -287,7 +287,7 @@
 				#interrupt-cells = <1>;
 			};
 
-			gpio4: gpio at 020ac000 { /* GPIO5 */
+			gpio5: gpio at 020ac000 {
 				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
 				reg = <0x020ac000 0x4000>;
 				interrupts = <0 74 0x04 0 75 0x04>;
@@ -297,7 +297,7 @@
 				#interrupt-cells = <1>;
 			};
 
-			gpio5: gpio at 020b0000 { /* GPIO6 */
+			gpio6: gpio at 020b0000 {
 				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
 				reg = <0x020b0000 0x4000>;
 				interrupts = <0 76 0x04 0 77 0x04>;
@@ -307,7 +307,7 @@
 				#interrupt-cells = <1>;
 			};
 
-			gpio6: gpio at 020b4000 { /* GPIO7 */
+			gpio7: gpio at 020b4000 {
 				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
 				reg = <0x020b4000 0x4000>;
 				interrupts = <0 78 0x04 0 79 0x04>;
-- 
1.7.5.4
