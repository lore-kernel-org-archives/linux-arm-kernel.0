From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Thu, 23 Jan 2014 16:57:10 +0100
Subject: [PATCH v3 06/15] at91: dt: at91sam9261ek: Adds DT entries for the 4
 user buttons
In-Reply-To: <1390492639-7299-1-git-send-email-jjhiblot@traphandler.com>
References: <1390492639-7299-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <1390492639-7299-7-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/arm/boot/dts/at91sam9261ek.dts | 39 +++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
index 8909217..5555e9f5 100644
--- a/arch/arm/boot/dts/at91sam9261ek.dts
+++ b/arch/arm/boot/dts/at91sam9261ek.dts
@@ -83,6 +83,15 @@
 						AT91_PIOA 23  AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
 					};
 				};
+
+				keys {
+					pinctrl_keys: keys-0 {
+						atmel,pins = <AT91_PIOA 27  AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+						AT91_PIOA 26  AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+						AT91_PIOA 25  AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+						AT91_PIOA 24  AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+					};
+				};
 			};
 
 			watchdog at fffffd40 {
@@ -109,4 +118,34 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&pinctrl_keys>;
+
+		button_0 {
+			label = "button_0";
+			gpios = <&pioA 27 GPIO_ACTIVE_LOW>;
+			linux,code = <256>;
+			gpio-key,wakeup;
+		};
+		button_1 {
+			label = "button_1";
+			gpios = <&pioA 26 GPIO_ACTIVE_LOW>;
+			linux,code = <257>;
+			gpio-key,wakeup;
+		};
+		button_2 {
+			label = "button_2";
+			gpios = <&pioA 25 GPIO_ACTIVE_LOW>;
+			linux,code = <258>;
+			gpio-key,wakeup;
+		};
+		button_3 {
+			label = "button_3";
+			gpios = <&pioA 24 GPIO_ACTIVE_LOW>;
+			linux,code = <259>;
+			gpio-key,wakeup;
+		};
+	};
 };
-- 
1.8.5.2
