From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 15 May 2013 16:03:02 +0200
Subject: [PATCH 2/5] ARM: at91: dt: switch to standard GPIO flag defines.
In-Reply-To: <1368626585-24425-1-git-send-email-plagnioj@jcrosoft.com>
References: <20130515135821.GG22508@game.jcrosoft.org>
 <1368626585-24425-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1368626585-24425-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/aks-cdu.dts               |   10 ++++-----
 arch/arm/boot/dts/animeo_ip.dts             |   16 +++++++-------
 arch/arm/boot/dts/at91-ariag25.dts          |    4 ++--
 arch/arm/boot/dts/at91rm9200.dtsi           |    9 ++++----
 arch/arm/boot/dts/at91rm9200ek.dts          |    8 +++----
 arch/arm/boot/dts/at91sam9260.dtsi          |    9 ++++----
 arch/arm/boot/dts/at91sam9263.dtsi          |    9 ++++----
 arch/arm/boot/dts/at91sam9263ek.dts         |   18 ++++++++--------
 arch/arm/boot/dts/at91sam9g20ek.dts         |    4 ++--
 arch/arm/boot/dts/at91sam9g20ek_2mmc.dts    |    6 +++---
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |    8 +++----
 arch/arm/boot/dts/at91sam9g45.dtsi          |    9 ++++----
 arch/arm/boot/dts/at91sam9m10g45ek.dts      |   30 +++++++++++++--------------
 arch/arm/boot/dts/at91sam9n12.dtsi          |    9 ++++----
 arch/arm/boot/dts/at91sam9n12ek.dts         |   10 ++++-----
 arch/arm/boot/dts/at91sam9x5.dtsi           |   17 ++++++++-------
 arch/arm/boot/dts/at91sam9x5cm.dtsi         |    6 +++---
 arch/arm/boot/dts/at91sam9x5ek.dtsi         |    8 +++----
 arch/arm/boot/dts/ethernut5.dts             |    4 ++--
 arch/arm/boot/dts/evk-pro3.dts              |    2 +-
 arch/arm/boot/dts/kizbox.dts                |   12 +++++------
 arch/arm/boot/dts/mpa1600.dts               |    2 +-
 arch/arm/boot/dts/pm9g45.dts                |   14 ++++++-------
 arch/arm/boot/dts/sama5d3.dtsi              |    1 +
 arch/arm/boot/dts/sama5d31ek.dts            |    2 +-
 arch/arm/boot/dts/sama5d34ek.dts            |    2 +-
 arch/arm/boot/dts/sama5d35ek.dts            |    2 +-
 arch/arm/boot/dts/sama5d3xcm.dtsi           |    2 +-
 arch/arm/boot/dts/sama5d3xmb.dtsi           |   12 +++++------
 arch/arm/boot/dts/tny_a9263.dts             |    2 +-
 arch/arm/boot/dts/usb_a9260_common.dtsi     |    6 +++---
 arch/arm/boot/dts/usb_a9263.dts             |    6 +++---
 arch/arm/boot/dts/usb_a9g20-dab-mmx.dtsi    |   22 ++++++++++----------
 33 files changed, 144 insertions(+), 137 deletions(-)

diff --git a/arch/arm/boot/dts/aks-cdu.dts b/arch/arm/boot/dts/aks-cdu.dts
index 08b82a4..54cb5cf 100644
--- a/arch/arm/boot/dts/aks-cdu.dts
+++ b/arch/arm/boot/dts/aks-cdu.dts
@@ -46,7 +46,7 @@
 			};
 
 			usb1: gadget at fffa4000 {
-				atmel,vbus-gpio = <&pioC 15 0>;
+				atmel,vbus-gpio = <&pioC 15 GPIO_ACTIVE_HIGH>;
 				status = "okay";
 			};
 		};
@@ -90,23 +90,23 @@
 		compatible = "gpio-leds";
 
 		red {
-			gpios = <&pioC 10 0>;
+			gpios = <&pioC 10 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "none";
 		};
 
 		green {
-			gpios = <&pioA 5 1>;
+			gpios = <&pioA 5 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 			default-state = "on";
 		};
 
 		yellow {
-			gpios = <&pioB 20 1>;
+			gpios = <&pioB 20 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 		};
 
 		blue {
-			gpios = <&pioB 21 1>;
+			gpios = <&pioB 21 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 		};
 	};
diff --git a/arch/arm/boot/dts/animeo_ip.dts b/arch/arm/boot/dts/animeo_ip.dts
index b765892..3a1de9e 100644
--- a/arch/arm/boot/dts/animeo_ip.dts
+++ b/arch/arm/boot/dts/animeo_ip.dts
@@ -123,7 +123,7 @@
 
 		usb0: ohci at 00500000 {
 			num-ports = <2>;
-			atmel,vbus-gpio = <&pioB 15 1>;
+			atmel,vbus-gpio = <&pioB 15 GPIO_ACTIVE_LOW>;
 			status = "okay";
 		};
 	};
@@ -133,23 +133,23 @@
 
 		power_green {
 			label = "power_green";
-			gpios = <&pioC 17 0>;
+			gpios = <&pioC 17 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
 		power_red {
 			label = "power_red";
-			gpios = <&pioA 2 0>;
+			gpios = <&pioA 2 GPIO_ACTIVE_HIGH>;
 		};
 
 		tx_green {
 			label = "tx_green";
-			gpios = <&pioC 19 0>;
+			gpios = <&pioC 19 GPIO_ACTIVE_HIGH>;
 		};
 
 		tx_red {
 			label = "tx_red";
-			gpios = <&pioC 18 0>;
+			gpios = <&pioC 18 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
@@ -160,21 +160,21 @@
 
 		keyswitch_in {
 			label = "keyswitch_in";
-			gpios = <&pioB 1 0>;
+			gpios = <&pioB 1 GPIO_ACTIVE_HIGH>;
 			linux,code = <28>;
 			gpio-key,wakeup;
 		};
 
 		error_in {
 			label = "error_in";
-			gpios = <&pioB 2 0>;
+			gpios = <&pioB 2 GPIO_ACTIVE_HIGH>;
 			linux,code = <29>;
 			gpio-key,wakeup;
 		};
 
 		btn {
 			label = "btn";
-			gpios = <&pioC 23 0>;
+			gpios = <&pioC 23 GPIO_ACTIVE_HIGH>;
 			linux,code = <31>;
 			gpio-key,wakeup;
 		};
diff --git a/arch/arm/boot/dts/at91-ariag25.dts b/arch/arm/boot/dts/at91-ariag25.dts
index 09beeb4..5ede767 100644
--- a/arch/arm/boot/dts/at91-ariag25.dts
+++ b/arch/arm/boot/dts/at91-ariag25.dts
@@ -156,7 +156,7 @@
 		/* little green LED in middle of Aria G25 module */
 		aria_led {
 			label = "aria_led";
-			gpios = <&pioB 8 0>; /* PB8 */
+			gpios = <&pioB 8 GPIO_ACTIVE_HIGH>; /* PB8 */
 			linux,default-trigger = "heartbeat";
 		};
 
@@ -164,7 +164,7 @@
 
 	onewire at 0 {
 		compatible = "w1-gpio";
-		gpios = <&pioA 21 1>;
+		gpios = <&pioA 21 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_w1_0>;
 	};
diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 6329679..7ebfe6c 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -11,6 +11,7 @@
  */
 
 #include "skeleton.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Atmel AT91RM9200 family SoC";
@@ -503,9 +504,9 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand>;
 			nand-ecc-mode = "soft";
-			gpios = <&pioC 2 0
+			gpios = <&pioC 2 GPIO_ACTIVE_HIGH
 				 0
-				 &pioB 1 0
+				 &pioB 1 GPIO_ACTIVE_HIGH
 				>;
 			status = "disabled";
 		};
@@ -520,8 +521,8 @@
 
 	i2c at 0 {
 		compatible = "i2c-gpio";
-		gpios = <&pioA 25 0 /* sda */
-			 &pioA 26 0 /* scl */
+		gpios = <&pioA 25 GPIO_ACTIVE_HIGH /* sda */
+			 &pioA 26 GPIO_ACTIVE_HIGH /* scl */
 			>;
 		i2c-gpio,sda-open-drain;
 		i2c-gpio,scl-open-drain;
diff --git a/arch/arm/boot/dts/at91rm9200ek.dts b/arch/arm/boot/dts/at91rm9200ek.dts
index 5dffeb3..1405812 100644
--- a/arch/arm/boot/dts/at91rm9200ek.dts
+++ b/arch/arm/boot/dts/at91rm9200ek.dts
@@ -50,7 +50,7 @@
 			};
 
 			usb1: gadget at fffb0000 {
-				atmel,vbus-gpio = <&pioD 4 0>;
+				atmel,vbus-gpio = <&pioD 4 GPIO_ACTIVE_HIGH>;
 				status = "okay";
 			};
 		};
@@ -66,19 +66,19 @@
 
 		ds2 {
 			label = "green";
-			gpios = <&pioB 0 0x1>;
+			gpios = <&pioB 0 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "mmc0";
 		};
 
 		ds4 {
 			label = "yellow";
-			gpios = <&pioB 1 0x1>;
+			gpios = <&pioB 1 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
 		};
 
 		ds6 {
 			label = "red";
-			gpios = <&pioB 2 0x1>;
+			gpios = <&pioB 2 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index b130b3e..717625d 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -9,6 +9,7 @@
  */
 
 #include "skeleton.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Atmel AT91SAM9260 family SoC";
@@ -567,8 +568,8 @@
 			atmel,nand-cmd-offset = <22>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand>;
-			gpios = <&pioC 13 0
-				 &pioC 14 0
+			gpios = <&pioC 13 GPIO_ACTIVE_HIGH
+				 &pioC 14 GPIO_ACTIVE_HIGH
 				 0
 				>;
 			status = "disabled";
@@ -584,8 +585,8 @@
 
 	i2c at 0 {
 		compatible = "i2c-gpio";
-		gpios = <&pioA 23 0 /* sda */
-			 &pioA 24 0 /* scl */
+		gpios = <&pioA 23 GPIO_ACTIVE_HIGH /* sda */
+			 &pioA 24 GPIO_ACTIVE_HIGH /* scl */
 			>;
 		i2c-gpio,sda-open-drain;
 		i2c-gpio,scl-open-drain;
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 89f4e94..5edfadf 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -7,6 +7,7 @@
  */
 
 #include "skeleton.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Atmel AT91SAM9263 family SoC";
@@ -515,8 +516,8 @@
 			atmel,nand-cmd-offset = <22>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand>;
-			gpios = <&pioA 22 0
-				 &pioD 15 0
+			gpios = <&pioA 22 GPIO_ACTIVE_HIGH
+				 &pioD 15 GPIO_ACTIVE_HIGH
 				 0
 				>;
 			status = "disabled";
@@ -532,8 +533,8 @@
 
 	i2c at 0 {
 		compatible = "i2c-gpio";
-		gpios = <&pioB 4 0 /* sda */
-			 &pioB 5 0 /* scl */
+		gpios = <&pioB 4 GPIO_ACTIVE_HIGH /* sda */
+			 &pioB 5 GPIO_ACTIVE_HIGH /* scl */
 			>;
 		i2c-gpio,sda-open-drain;
 		i2c-gpio,scl-open-drain;
diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index 6b646d4..e1942ec 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -51,7 +51,7 @@
 			};
 
 			usb1: gadget at fff78000 {
-				atmel,vbus-gpio = <&pioA 25 0>;
+				atmel,vbus-gpio = <&pioA 25 GPIO_ACTIVE_HIGH>;
 				status = "okay";
 			};
 
@@ -65,8 +65,8 @@
 				slot at 0 {
 					reg = <0>;
 					bus-width = <4>;
-					cd-gpios = <&pioE 18 0>;
-					wp-gpios = <&pioE 19 0>;
+					cd-gpios = <&pioE 18 GPIO_ACTIVE_HIGH>;
+					wp-gpios = <&pioE 19 GPIO_ACTIVE_HIGH>;
 				};
 			};
 
@@ -141,8 +141,8 @@
 		usb0: ohci at 00a00000 {
 			num-ports = <2>;
 			status = "okay";
-			atmel,vbus-gpio = <&pioA 24 0
-					   &pioA 21 0
+			atmel,vbus-gpio = <&pioA 24 GPIO_ACTIVE_HIGH
+					   &pioA 21 GPIO_ACTIVE_HIGH
 					  >;
 		};
 	};
@@ -152,13 +152,13 @@
 
 		d3 {
 			label = "d3";
-			gpios = <&pioB 7 0>;
+			gpios = <&pioB 7 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
 		d2 {
 			label = "d2";
-			gpios = <&pioC 29 1>;
+			gpios = <&pioC 29 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "nand-disk";
 		};
 	};
@@ -168,14 +168,14 @@
 
 		left_click {
 			label = "left_click";
-			gpios = <&pioC 5 1>;
+			gpios = <&pioC 5 GPIO_ACTIVE_LOW>;
 			linux,code = <272>;
 			gpio-key,wakeup;
 		};
 
 		right_click {
 			label = "right_click";
-			gpios = <&pioC 4 1>;
+			gpios = <&pioC 4 GPIO_ACTIVE_LOW>;
 			linux,code = <273>;
 			gpio-key,wakeup;
 		};
diff --git a/arch/arm/boot/dts/at91sam9g20ek.dts b/arch/arm/boot/dts/at91sam9g20ek.dts
index 3f15a3f..bbfd753 100644
--- a/arch/arm/boot/dts/at91sam9g20ek.dts
+++ b/arch/arm/boot/dts/at91sam9g20ek.dts
@@ -17,13 +17,13 @@
 
 		ds1 {
 			label = "ds1";
-			gpios = <&pioA 9 0>;
+			gpios = <&pioA 9 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
 		ds5 {
 			label = "ds5";
-			gpios = <&pioA 6 1>;
+			gpios = <&pioA 6 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/at91sam9g20ek_2mmc.dts b/arch/arm/boot/dts/at91sam9g20ek_2mmc.dts
index 942aa10..ec108b9 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_2mmc.dts
+++ b/arch/arm/boot/dts/at91sam9g20ek_2mmc.dts
@@ -23,7 +23,7 @@
 				slot at 0 {
 					reg = <0>;
 					bus-width = <4>;
-					cd-gpios = <&pioC 2 0>;
+					cd-gpios = <&pioC 2 GPIO_ACTIVE_HIGH>;
 				};
 			};
 
@@ -43,13 +43,13 @@
 
 		ds1 {
 			label = "ds1";
-			gpios = <&pioB 9 0>;
+			gpios = <&pioB 9 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
 		ds5 {
 			label = "ds5";
-			gpios = <&pioB 8 1>;
+			gpios = <&pioB 8 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index 253960f..7933839 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -65,7 +65,7 @@
 			};
 
 			usb1: gadget at fffa4000 {
-				atmel,vbus-gpio = <&pioC 5 0>;
+				atmel,vbus-gpio = <&pioC 5 GPIO_ACTIVE_HIGH>;
 				status = "okay";
 			};
 
@@ -79,7 +79,7 @@
 				slot at 1 {
 					reg = <1>;
 					bus-width = <4>;
-					cd-gpios = <&pioC 9 0>;
+					cd-gpios = <&pioC 9 GPIO_ACTIVE_HIGH>;
 				};
 			};
 
@@ -180,14 +180,14 @@
 
 		btn3 {
 			label = "Button 3";
-			gpios = <&pioA 30 1>;
+			gpios = <&pioA 30 GPIO_ACTIVE_LOW>;
 			linux,code = <0x103>;
 			gpio-key,wakeup;
 		};
 
 		btn4 {
 			label = "Button 4";
-			gpios = <&pioA 31 1>;
+			gpios = <&pioA 31 GPIO_ACTIVE_LOW>;
 			linux,code = <0x104>;
 			gpio-key,wakeup;
 		};
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 18ea761..5d7c1f7 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -10,6 +10,7 @@
  */
 
 #include "skeleton.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Atmel AT91SAM9G45 family SoC";
@@ -592,8 +593,8 @@
 			atmel,nand-cmd-offset = <22>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand>;
-			gpios = <&pioC 8 0
-				 &pioC 14 0
+			gpios = <&pioC 8 GPIO_ACTIVE_HIGH
+				 &pioC 14 GPIO_ACTIVE_HIGH
 				 0
 				>;
 			status = "disabled";
@@ -616,8 +617,8 @@
 
 	i2c at 0 {
 		compatible = "i2c-gpio";
-		gpios = <&pioA 20 0 /* sda */
-			 &pioA 21 0 /* scl */
+		gpios = <&pioA 20 GPIO_ACTIVE_HIGH /* sda */
+			 &pioA 21 GPIO_ACTIVE_HIGH /* scl */
 			>;
 		i2c-gpio,sda-open-drain;
 		i2c-gpio,scl-open-drain;
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index ba1205d..85e9c5e 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -68,7 +68,7 @@
 				slot at 0 {
 					reg = <0>;
 					bus-width = <4>;
-					cd-gpios = <&pioD 10 0>;
+					cd-gpios = <&pioD 10 GPIO_ACTIVE_HIGH>;
 				};
 			};
 
@@ -81,8 +81,8 @@
 				slot at 0 {
 					reg = <0>;
 					bus-width = <4>;
-					cd-gpios = <&pioD 11 0>;
-					wp-gpios = <&pioD 29 0>;
+					cd-gpios = <&pioD 11 GPIO_ACTIVE_HIGH>;
+					wp-gpios = <&pioD 29 GPIO_ACTIVE_HIGH>;
 				};
 			};
 
@@ -139,8 +139,8 @@
 		usb0: ohci at 00700000 {
 			status = "okay";
 			num-ports = <2>;
-			atmel,vbus-gpio = <&pioD 1 1
-					   &pioD 3 1>;
+			atmel,vbus-gpio = <&pioD 1 GPIO_ACTIVE_LOW
+					   &pioD 3 GPIO_ACTIVE_LOW>;
 		};
 
 		usb1: ehci at 00800000 {
@@ -153,19 +153,19 @@
 
 		d8 {
 			label = "d8";
-			gpios = <&pioD 30 0>;
+			gpios = <&pioD 30 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
 		d6 {
 			label = "d6";
-			gpios = <&pioD 0 1>;
+			gpios = <&pioD 0 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "nand-disk";
 		};
 
 		d7 {
 			label = "d7";
-			gpios = <&pioD 31 1>;
+			gpios = <&pioD 31 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "mmc0";
 		};
 	};
@@ -175,45 +175,45 @@
 
 		left_click {
 			label = "left_click";
-			gpios = <&pioB 6 1>;
+			gpios = <&pioB 6 GPIO_ACTIVE_LOW>;
 			linux,code = <272>;
 			gpio-key,wakeup;
 		};
 
 		right_click {
 			label = "right_click";
-			gpios = <&pioB 7 1>;
+			gpios = <&pioB 7 GPIO_ACTIVE_LOW>;
 			linux,code = <273>;
 			gpio-key,wakeup;
 		};
 
 		left {
 			label = "Joystick Left";
-			gpios = <&pioB 14 1>;
+			gpios = <&pioB 14 GPIO_ACTIVE_LOW>;
 			linux,code = <105>;
 		};
 
 		right {
 			label = "Joystick Right";
-			gpios = <&pioB 15 1>;
+			gpios = <&pioB 15 GPIO_ACTIVE_LOW>;
 			linux,code = <106>;
 		};
 
 		up {
 			label = "Joystick Up";
-			gpios = <&pioB 16 1>;
+			gpios = <&pioB 16 GPIO_ACTIVE_LOW>;
 			linux,code = <103>;
 		};
 
 		down {
 			label = "Joystick Down";
-			gpios = <&pioB 17 1>;
+			gpios = <&pioB 17 GPIO_ACTIVE_LOW>;
 			linux,code = <108>;
 		};
 
 		enter {
 			label = "Joystick Press";
-			gpios = <&pioB 18 1>;
+			gpios = <&pioB 18 GPIO_ACTIVE_LOW>;
 			linux,code = <28>;
 		};
 	};
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index e848870..5205403 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -8,6 +8,7 @@
  */
 
 #include "skeleton.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Atmel AT91SAM9N12 SoC";
@@ -438,8 +439,8 @@
 			atmel,nand-cmd-offset = <22>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand>;
-			gpios = <&pioD 5 0
-				 &pioD 4 0
+			gpios = <&pioD 5 GPIO_ACTIVE_HIGH
+				 &pioD 4 GPIO_ACTIVE_HIGH
 				 0
 				>;
 			status = "disabled";
@@ -455,8 +456,8 @@
 
 	i2c at 0 {
 		compatible = "i2c-gpio";
-		gpios = <&pioA 30 0 /* sda */
-			 &pioA 31 0 /* scl */
+		gpios = <&pioA 30 GPIO_ACTIVE_HIGH /* sda */
+			 &pioA 31 GPIO_ACTIVE_HIGH /* scl */
 			>;
 		i2c-gpio,sda-open-drain;
 		i2c-gpio,scl-open-drain;
diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index b9e300e..8eece27 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -55,7 +55,7 @@
 				slot at 0 {
 					reg = <0>;
 					bus-width = <4>;
-					cd-gpios = <&pioA 7 0>;
+					cd-gpios = <&pioA 7 GPIO_ACTIVE_HIGH>;
 				};
 			};
 
@@ -95,19 +95,19 @@
 
 		d8 {
 			label = "d8";
-			gpios = <&pioB 4 1>;
+			gpios = <&pioB 4 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "mmc0";
 		};
 
 		d9 {
 			label = "d6";
-			gpios = <&pioB 5 1>;
+			gpios = <&pioB 5 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "nand-disk";
 		};
 
 		d10 {
 			label = "d7";
-			gpios = <&pioB 6 0>;
+			gpios = <&pioB 6 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 	};
@@ -117,7 +117,7 @@
 
 		enter {
 			label = "Enter";
-			gpios = <&pioB 4 1>;
+			gpios = <&pioB 4 GPIO_ACTIVE_LOW>;
 			linux,code = <28>;
 			gpio-key,wakeup;
 		};
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 69b386f..949b8ea 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -10,6 +10,7 @@
  */
 
 #include "skeleton.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Atmel AT91SAM9x5 family SoC";
@@ -664,8 +665,8 @@
 			atmel,nand-cmd-offset = <22>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand>;
-			gpios = <&pioD 5 0
-				 &pioD 4 0
+			gpios = <&pioD 5 GPIO_ACTIVE_HIGH
+				 &pioD 4 GPIO_ACTIVE_HIGH
 				 0
 				>;
 			status = "disabled";
@@ -688,8 +689,8 @@
 
 	i2c at 0 {
 		compatible = "i2c-gpio";
-		gpios = <&pioA 30 0 /* sda */
-			 &pioA 31 0 /* scl */
+		gpios = <&pioA 30 GPIO_ACTIVE_HIGH /* sda */
+			 &pioA 31 GPIO_ACTIVE_HIGH /* scl */
 			>;
 		i2c-gpio,sda-open-drain;
 		i2c-gpio,scl-open-drain;
@@ -703,8 +704,8 @@
 
 	i2c at 1 {
 		compatible = "i2c-gpio";
-		gpios = <&pioC 0 0 /* sda */
-			 &pioC 1 0 /* scl */
+		gpios = <&pioC 0 GPIO_ACTIVE_HIGH /* sda */
+			 &pioC 1 GPIO_ACTIVE_HIGH /* scl */
 			>;
 		i2c-gpio,sda-open-drain;
 		i2c-gpio,scl-open-drain;
@@ -718,8 +719,8 @@
 
 	i2c at 2 {
 		compatible = "i2c-gpio";
-		gpios = <&pioB 4 0 /* sda */
-			 &pioB 5 0 /* scl */
+		gpios = <&pioB 4 GPIO_ACTIVE_HIGH /* sda */
+			 &pioB 5 GPIO_ACTIVE_HIGH /* scl */
 			>;
 		i2c-gpio,sda-open-drain;
 		i2c-gpio,scl-open-drain;
diff --git a/arch/arm/boot/dts/at91sam9x5cm.dtsi b/arch/arm/boot/dts/at91sam9x5cm.dtsi
index 347a74a..94723c3 100644
--- a/arch/arm/boot/dts/at91sam9x5cm.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5cm.dtsi
@@ -75,19 +75,19 @@
 
 		pb18 {
 			label = "pb18";
-			gpios = <&pioB 18 1>;
+			gpios = <&pioB 18 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
 		};
 
 		pd21 {
 			label = "pd21";
-			gpios = <&pioD 21 0>;
+			gpios = <&pioD 21 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
 	1wire_cm {
 		compatible = "w1-gpio";
-		gpios = <&pioB 18 0>;
+		gpios = <&pioB 18 GPIO_ACTIVE_HIGH>;
 		linux,open-drain;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_1wire_cm>;
diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
index 24781f2..95f88c7 100644
--- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
@@ -27,7 +27,7 @@
 				slot at 0 {
 					reg = <0>;
 					bus-width = <4>;
-					cd-gpios = <&pioD 15 0>;
+					cd-gpios = <&pioD 15 GPIO_ACTIVE_HIGH>;
 				};
 			};
 
@@ -40,7 +40,7 @@
 				slot at 0 {
 					reg = <0>;
 					bus-width = <4>;
-					cd-gpios = <&pioD 14 0>;
+					cd-gpios = <&pioD 14 GPIO_ACTIVE_HIGH>;
 				};
 			};
 
@@ -86,8 +86,8 @@
 		usb0: ohci at 00600000 {
 			status = "okay";
 			num-ports = <2>;
-			atmel,vbus-gpio = <&pioD 19 1
-					   &pioD 20 1
+			atmel,vbus-gpio = <&pioD 19 GPIO_ACTIVE_LOW
+					   &pioD 20 GPIO_ACTIVE_LOW
 					  >;
 		};
 
diff --git a/arch/arm/boot/dts/ethernut5.dts b/arch/arm/boot/dts/ethernut5.dts
index 2067c66..143b6d2 100644
--- a/arch/arm/boot/dts/ethernut5.dts
+++ b/arch/arm/boot/dts/ethernut5.dts
@@ -40,7 +40,7 @@
 			};
 
 			usb1: gadget at fffa4000 {
-				atmel,vbus-gpio = <&pioC 5 0>;
+				atmel,vbus-gpio = <&pioC 5 GPIO_ACTIVE_HIGH>;
 				status = "okay";
 			};
 		};
@@ -52,7 +52,7 @@
 			status = "okay";
 
 			gpios = <0
-				 &pioC 14 0
+				 &pioC 14 GPIO_ACTIVE_HIGH
 				 0
 				>;
 
diff --git a/arch/arm/boot/dts/evk-pro3.dts b/arch/arm/boot/dts/evk-pro3.dts
index eae2cd7..4d82968 100644
--- a/arch/arm/boot/dts/evk-pro3.dts
+++ b/arch/arm/boot/dts/evk-pro3.dts
@@ -31,7 +31,7 @@
 			};
 
 			usb1: gadget at fffa4000 {
-				atmel,vbus-gpio = <&pioC 5 0>;
+				atmel,vbus-gpio = <&pioC 5 GPIO_ACTIVE_HIGH>;
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/kizbox.dts b/arch/arm/boot/dts/kizbox.dts
index 8328fed..02df191 100644
--- a/arch/arm/boot/dts/kizbox.dts
+++ b/arch/arm/boot/dts/kizbox.dts
@@ -94,26 +94,26 @@
 
 		led1g {
 			label = "led1:green";
-			gpios = <&pioB 0 1>;
+			gpios = <&pioB 0 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 		};
 
 		led1r {
 			label = "led1:red";
-			gpios = <&pioB 1 1>;
+			gpios = <&pioB 1 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 		};
 
 		led2g {
 			label = "led2:green";
-			gpios = <&pioB 2 1>;
+			gpios = <&pioB 2 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 			default-state = "on";
 		};
 
 		led2r {
 			label = "led2:red";
-			gpios = <&pioB 3 1>;
+			gpios = <&pioB 3 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 		};
 	};
@@ -125,14 +125,14 @@
 
 		reset {
 			label = "reset";
-			gpios = <&pioB 30 1>;
+			gpios = <&pioB 30 GPIO_ACTIVE_LOW>;
 			linux,code = <0x100>;
 			gpio-key,wakeup;
 		};
 
 		mode {
 			label = "mode";
-			gpios = <&pioB 31 1>;
+			gpios = <&pioB 31 GPIO_ACTIVE_LOW>;
 			linux,code = <0x101>;
 			gpio-key,wakeup;
 		};
diff --git a/arch/arm/boot/dts/mpa1600.dts b/arch/arm/boot/dts/mpa1600.dts
index f1b54a2..ccf9ea2 100644
--- a/arch/arm/boot/dts/mpa1600.dts
+++ b/arch/arm/boot/dts/mpa1600.dts
@@ -62,7 +62,7 @@
 
 		monitor_mute {
 			label = "Monitor mute";
-			gpios = <&pioC 1 1>;
+			gpios = <&pioC 1 GPIO_ACTIVE_LOW>;
 			linux,code = <113>;
 		};
 	};
diff --git a/arch/arm/boot/dts/pm9g45.dts b/arch/arm/boot/dts/pm9g45.dts
index 639410b..315d927 100644
--- a/arch/arm/boot/dts/pm9g45.dts
+++ b/arch/arm/boot/dts/pm9g45.dts
@@ -64,7 +64,7 @@
 				slot at 0 {
 					reg = <0>;
 					bus-width = <4>;
-					cd-gpios = <&pioD 6 0>;
+					cd-gpios = <&pioD 6 GPIO_ACTIVE_HIGH>;
 				};
 			};
 
@@ -81,8 +81,8 @@
 			nand-on-flash-bbt;
 			pinctrl-0 = <&pinctrl_board_nand>;
 
-			gpios = <&pioD 3 0
-				 &pioC 14 0
+			gpios = <&pioD 3 GPIO_ACTIVE_HIGH
+				 &pioC 14 GPIO_ACTIVE_HIGH
 				 0
 				>;
 
@@ -134,13 +134,13 @@
 
 		led0 {
 			label = "led0";
-			gpios = <&pioD 0 1>;
+			gpios = <&pioD 0 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "nand-disk";
 		};
 
 		led1 {
 			label = "led1";
-			gpios = <&pioD 31 0>;
+			gpios = <&pioD 31 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 	};
@@ -152,13 +152,13 @@
 
 		right {
 			label = "SW4";
-			gpios = <&pioE 7 1>;
+			gpios = <&pioE 7 GPIO_ACTIVE_LOW>;
 			linux,code = <106>;
 		};
 
 		up {
 			label = "SW3";
-			gpios = <&pioE 8 1>;
+			gpios = <&pioE 8 GPIO_ACTIVE_LOW>;
 			linux,code = <103>;
 		};
 	};
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 2293fa1..0d65e3d 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -9,6 +9,7 @@
  */
 
 #include "skeleton.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Atmel SAMA5D3 family SoC";
diff --git a/arch/arm/boot/dts/sama5d31ek.dts b/arch/arm/boot/dts/sama5d31ek.dts
index 5bffd66..027bac7 100644
--- a/arch/arm/boot/dts/sama5d31ek.dts
+++ b/arch/arm/boot/dts/sama5d31ek.dts
@@ -41,7 +41,7 @@
 	leds {
 		d3 {
 			label = "d3";
-			gpios = <&pioE 24 0>;
+			gpios = <&pioE 24 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/sama5d34ek.dts b/arch/arm/boot/dts/sama5d34ek.dts
index d88ff72..fb8ee11 100644
--- a/arch/arm/boot/dts/sama5d34ek.dts
+++ b/arch/arm/boot/dts/sama5d34ek.dts
@@ -51,7 +51,7 @@
 	leds {
 		d3 {
 			label = "d3";
-			gpios = <&pioE 24 0>;
+			gpios = <&pioE 24 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/sama5d35ek.dts b/arch/arm/boot/dts/sama5d35ek.dts
index 3c364d2..509a53d 100644
--- a/arch/arm/boot/dts/sama5d35ek.dts
+++ b/arch/arm/boot/dts/sama5d35ek.dts
@@ -48,7 +48,7 @@
 
 		pb_user1 {
 			label = "pb_user1";
-			gpios = <&pioE 27 0>;
+			gpios = <&pioE 27 GPIO_ACTIVE_HIGH>;
 			linux,code = <0x100>;
 			gpio-key,wakeup;
 		};
diff --git a/arch/arm/boot/dts/sama5d3xcm.dtsi b/arch/arm/boot/dts/sama5d3xcm.dtsi
index b552917..60637e4 100644
--- a/arch/arm/boot/dts/sama5d3xcm.dtsi
+++ b/arch/arm/boot/dts/sama5d3xcm.dtsi
@@ -85,7 +85,7 @@
 
 		d2 {
 			label = "d2";
-			gpios = <&pioE 25 1>;	/* PE25, conflicts with A25, RXD2 */
+			gpios = <&pioE 25 GPIO_ACTIVE_LOW>;	/* PE25, conflicts with A25, RXD2 */
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/sama5d3xmb.dtsi
index a5e7131..205e64c 100644
--- a/arch/arm/boot/dts/sama5d3xmb.dtsi
+++ b/arch/arm/boot/dts/sama5d3xmb.dtsi
@@ -20,7 +20,7 @@
 				slot at 0 {
 					reg = <0>;
 					bus-width = <4>;
-					cd-gpios = <&pioD 17 0>;
+					cd-gpios = <&pioD 17 GPIO_ACTIVE_HIGH>;
 				};
 			};
 
@@ -62,7 +62,7 @@
 				slot at 0 {
 					reg = <0>;
 					bus-width = <4>;
-					cd-gpios = <&pioD 18 0>;
+					cd-gpios = <&pioD 18 GPIO_ACTIVE_HIGH>;
 				};
 			};
 
@@ -127,7 +127,7 @@
 		};
 
 		usb0: gadget at 00500000 {
-			atmel,vbus-gpio = <&pioD 29 0>;
+			atmel,vbus-gpio = <&pioD 29 GPIO_ACTIVE_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usba_vbus>;
 			status = "okay";
@@ -135,9 +135,9 @@
 
 		usb1: ohci at 00600000 {
 			num-ports = <3>;
-			atmel,vbus-gpio = <&pioD 25 0
-					   &pioD 26 1
-					   &pioD 27 1
+			atmel,vbus-gpio = <&pioD 25 GPIO_ACTIVE_HIGH
+					   &pioD 26 GPIO_ACTIVE_LOW
+					   &pioD 27 GPIO_ACTIVE_LOW
 					  >;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/tny_a9263.dts b/arch/arm/boot/dts/tny_a9263.dts
index 45f059b..0751a6a9 100644
--- a/arch/arm/boot/dts/tny_a9263.dts
+++ b/arch/arm/boot/dts/tny_a9263.dts
@@ -38,7 +38,7 @@
 			};
 
 			usb1: gadget at fff78000 {
-				atmel,vbus-gpio = <&pioB 11 0>;
+				atmel,vbus-gpio = <&pioB 11 GPIO_ACTIVE_HIGH>;
 				status = "okay";
 			};
 		};
diff --git a/arch/arm/boot/dts/usb_a9260_common.dtsi b/arch/arm/boot/dts/usb_a9260_common.dtsi
index e70d229..2859776 100644
--- a/arch/arm/boot/dts/usb_a9260_common.dtsi
+++ b/arch/arm/boot/dts/usb_a9260_common.dtsi
@@ -30,7 +30,7 @@
 			};
 
 			usb1: gadget at fffa4000 {
-				atmel,vbus-gpio = <&pioC 5 0>;
+				atmel,vbus-gpio = <&pioC 5 GPIO_ACTIVE_HIGH>;
 				status = "okay";
 			};
 		};
@@ -93,7 +93,7 @@
 
 		user_led {
 			label = "user_led";
-			gpios = <&pioB 21 1>;
+			gpios = <&pioB 21 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
 		};
 	};
@@ -105,7 +105,7 @@
 
 		user_pb {
 			label = "user_pb";
-			gpios = <&pioB 10 1>;
+			gpios = <&pioB 10 GPIO_ACTIVE_LOW>;
 			linux,code = <28>;
 			gpio-key,wakeup;
 		};
diff --git a/arch/arm/boot/dts/usb_a9263.dts b/arch/arm/boot/dts/usb_a9263.dts
index 82e204a..f8ec36c 100644
--- a/arch/arm/boot/dts/usb_a9263.dts
+++ b/arch/arm/boot/dts/usb_a9263.dts
@@ -43,7 +43,7 @@
 			};
 
 			usb1: gadget at fff78000 {
-				atmel,vbus-gpio = <&pioB 11 0>;
+				atmel,vbus-gpio = <&pioB 11 GPIO_ACTIVE_HIGH>;
 				status = "okay";
 			};
 
@@ -107,7 +107,7 @@
 
 		user_led {
 			label = "user_led";
-			gpios = <&pioB 21 0>;
+			gpios = <&pioB 21 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 	};
@@ -119,7 +119,7 @@
 
 		user_pb {
 			label = "user_pb";
-			gpios = <&pioB 10 1>;
+			gpios = <&pioB 10 GPIO_ACTIVE_LOW>;
 			linux,code = <28>;
 			gpio-key,wakeup;
 		};
diff --git a/arch/arm/boot/dts/usb_a9g20-dab-mmx.dtsi b/arch/arm/boot/dts/usb_a9g20-dab-mmx.dtsi
index ad3eca1..5b0ffc1 100644
--- a/arch/arm/boot/dts/usb_a9g20-dab-mmx.dtsi
+++ b/arch/arm/boot/dts/usb_a9g20-dab-mmx.dtsi
@@ -28,39 +28,39 @@
 
 		user_led1 {
 			label = "user_led1";
-			gpios = <&pioB 20 1>;
+			gpios = <&pioB 20 GPIO_ACTIVE_LOW>;
 		};
 
 /*
 * led already used by mother board but active as high
 *		user_led2 {
 *			label = "user_led2";
-*			gpios = <&pioB 21 1>;
+*			gpios = <&pioB 21 GPIO_ACTIVE_LOW>;
 *		};
 */
 		user_led3 {
 			label = "user_led3";
-			gpios = <&pioB 22 1>;
+			gpios = <&pioB 22 GPIO_ACTIVE_LOW>;
 		};
 
 		user_led4 {
 			label = "user_led4";
-			gpios = <&pioB 23 1>;
+			gpios = <&pioB 23 GPIO_ACTIVE_LOW>;
 		};
 
 		red {
 			label = "red";
-			gpios = <&pioB 24 1>;
+			gpios = <&pioB 24 GPIO_ACTIVE_LOW>;
 		};
 
 		orange {
 			label = "orange";
-			gpios = <&pioB 30 1>;
+			gpios = <&pioB 30 GPIO_ACTIVE_LOW>;
 		};
 
 		green {
 			label = "green";
-			gpios = <&pioB 31 1>;
+			gpios = <&pioB 31 GPIO_ACTIVE_LOW>;
 		};
 	};
 
@@ -71,25 +71,25 @@
 
 		user_pb1 {
 			label = "user_pb1";
-			gpios = <&pioB 25 1>;
+			gpios = <&pioB 25 GPIO_ACTIVE_LOW>;
 			linux,code = <0x100>;
 		};
 
 		user_pb2 {
 			label = "user_pb2";
-			gpios = <&pioB 13 1>;
+			gpios = <&pioB 13 GPIO_ACTIVE_LOW>;
 			linux,code = <0x101>;
 		};
 
 		user_pb3 {
 			label = "user_pb3";
-			gpios = <&pioA 26 1>;
+			gpios = <&pioA 26 GPIO_ACTIVE_LOW>;
 			linux,code = <0x102>;
 		};
 
 		user_pb4 {
 			label = "user_pb4";
-			gpios = <&pioC 9 1>;
+			gpios = <&pioC 9 GPIO_ACTIVE_LOW>;
 			linux,code = <0x103>;
 		};
 	};
-- 
1.7.10.4
