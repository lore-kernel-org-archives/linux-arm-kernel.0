From: manabian@gmail.com (Joachim Eastwood)
Date: Thu,  1 Oct 2015 22:54:53 +0200
Subject: [PATCH 16/16] ARM: dts: lpc4350-hitex-eval: add joystick,
 buttons and leds
In-Reply-To: <1443732893-17145-1-git-send-email-manabian@gmail.com>
References: <1443732893-17145-1-git-send-email-manabian@gmail.com>
Message-ID: <1443732893-17145-17-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the joystick, buttons and LEDs connected to the I2C I/O expander.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc4350-hitex-eval.dts | 85 ++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm/boot/dts/lpc4350-hitex-eval.dts b/arch/arm/boot/dts/lpc4350-hitex-eval.dts
index 5c529f45947b..022d495432c1 100644
--- a/arch/arm/boot/dts/lpc4350-hitex-eval.dts
+++ b/arch/arm/boot/dts/lpc4350-hitex-eval.dts
@@ -15,6 +15,9 @@
 #include "lpc18xx.dtsi"
 #include "lpc4350.dtsi"
 
+#include "dt-bindings/input/input.h"
+#include "dt-bindings/gpio/gpio.h"
+
 / {
 	model = "Hitex LPC4350 Evaluation Board";
 	compatible = "hitex,lpc4350-eval-board", "nxp,lpc4350";
@@ -34,6 +37,88 @@
 		device_type = "memory";
 		reg = <0x28000000 0x800000>; /* 8 MB */
 	};
+
+	pca_buttons {
+		compatible = "gpio-keys-polled";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		poll-interval = <100>;
+		autorepeat;
+
+		button at 0 {
+			label = "joy:right";
+			linux,code = <KEY_RIGHT>;
+			gpios = <&pca_gpio 8 GPIO_ACTIVE_LOW>;
+		};
+
+		button at 1 {
+			label = "joy:up";
+			linux,code = <KEY_UP>;
+			gpios = <&pca_gpio 9 GPIO_ACTIVE_LOW>;
+		};
+
+
+		button at 2 {
+			label = "joy:enter";
+			linux,code = <KEY_ENTER>;
+			gpios = <&pca_gpio 10 GPIO_ACTIVE_LOW>;
+		};
+
+		button at 3 {
+			label = "joy:left";
+			linux,code = <KEY_LEFT>;
+			gpios = <&pca_gpio 11 GPIO_ACTIVE_LOW>;
+		};
+
+		button at 4 {
+			label = "joy:down";
+			linux,code = <KEY_DOWN>;
+			gpios = <&pca_gpio 12 GPIO_ACTIVE_LOW>;
+		};
+
+		button at 5 {
+			label = "user:sw3";
+			linux,code = <KEY_F1>;
+			gpios = <&pca_gpio 13 GPIO_ACTIVE_LOW>;
+		};
+
+		button at 6 {
+			label = "user:sw4";
+			linux,code = <KEY_F2>;
+			gpios = <&pca_gpio 14 GPIO_ACTIVE_LOW>;
+		};
+
+		button at 7 {
+			label = "user:sw5";
+			linux,code = <KEY_F3>;
+			gpios = <&pca_gpio 15 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	pca_leds {
+		compatible = "gpio-leds";
+
+		led0 {
+			label = "ext:led0";
+			gpios = <&pca_gpio 0 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led1 {
+			label = "ext:led1";
+			gpios = <&pca_gpio 1 GPIO_ACTIVE_LOW>;
+		};
+
+		led2 {
+			label = "ext:led2";
+			gpios = <&pca_gpio 2 GPIO_ACTIVE_LOW>;
+		};
+
+		led3 {
+			label = "ext:led3";
+			gpios = <&pca_gpio 3 GPIO_ACTIVE_LOW>;
+		};
+	};
 };
 
 &pinctrl {
-- 
1.8.0
