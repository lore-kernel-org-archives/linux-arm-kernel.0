From: merker@debian.org (Karsten Merker)
Date: Thu, 10 Dec 2015 21:31:59 +0100
Subject: [PATCH 1/3] ARM: dts: sun7i: Olimex A20-SOM-EVB: Add LRADC keys
In-Reply-To: <1449779521-754-1-git-send-email-merker@debian.org>
References: <1449779521-754-1-git-send-email-merker@debian.org>
Message-ID: <1449779521-754-2-git-send-email-merker@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Olimex A20-SOM-EVB is an evaluation board for the Olimex
A20-SOM system-on-module.  It provides a set of android-style
buttons (labeled "VOL+", "VOL-", "MENU", "SEARCH", "HOME", "ESC"
and "ENTER") which are connected to a low-resolution ADC via a
resistor network.

This patch adds appropriate button definitions to the board
dts. The voltages assigned to the keys are specified in the
board schematics published by the manufacturer.

Signed-off-by: Karsten Merker <merker@debian.org>
---
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts | 56 ++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
index b7fe102..6562a6bc 100644
--- a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
@@ -1,5 +1,6 @@
 /*
  * Copyright 2015 - Marcus Cooper <codekipper@gmail.com>
+ * Copyright 2015 - Karsten Merker <merker@debian.org>
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
@@ -45,6 +46,7 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
@@ -110,6 +112,60 @@
 	};
 };
 
+&lradc {
+	vref-supply = <&reg_vcc3v0>;
+	status = "okay";
+
+	button at 190 {
+		label = "Volume Up";
+		linux,code = <KEY_VOLUMEUP>;
+		channel = <0>;
+		voltage = <190000>;
+	};
+
+	button at 390 {
+		label = "Volume Down";
+		linux,code = <KEY_VOLUMEDOWN>;
+		channel = <0>;
+		voltage = <390000>;
+	};
+
+	button at 600 {
+		label = "Menu";
+		linux,code = <KEY_MENU>;
+		channel = <0>;
+		voltage = <600000>;
+	};
+
+	button at 800 {
+		label = "Search";
+		linux,code = <KEY_SEARCH>;
+		channel = <0>;
+		voltage = <800000>;
+	};
+
+	button at 980 {
+		label = "Home";
+		linux,code = <KEY_HOMEPAGE>;
+		channel = <0>;
+		voltage = <980000>;
+	};
+
+	button at 1180 {
+		label = "Esc";
+		linux,code = <KEY_ESC>;
+		channel = <0>;
+		voltage = <1180000>;
+	};
+
+	button at 1400 {
+		label = "Enter";
+		linux,code = <KEY_ENTER>;
+		channel = <0>;
+		voltage = <1400000>;
+	};
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
-- 
2.1.4
