From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 13 Oct 2015 14:32:43 +0100
Subject: [PATCH 1/2] ARM: dts: fix gpio-keys wakeup-source property
Message-ID: <1444743164-17735-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The keyboard driver for GPIO buttons(gpio-keys) checks for one of the
two boolean properties to enable gpio buttons as wakeup source:
1. "wakeup-source" or
2. the legacy "gpio-key,wakeup"

However juno, ste-snowball and emev2-kzm9d dts file have a undetected
"wakeup" property to indictate the wakeup source.

This patch fixes it by making use of "wakeup-source" property.

Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/emev2-kzm9d.dts             |  8 ++++----
 arch/arm/boot/dts/ste-snowball.dts            | 10 +++++-----
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi | 12 ++++++------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
index 955c24ee4a8c..8c24975e8f9d 100644
--- a/arch/arm/boot/dts/emev2-kzm9d.dts
+++ b/arch/arm/boot/dts/emev2-kzm9d.dts
@@ -35,28 +35,28 @@
 
 		button at 1 {
 			debounce_interval = <50>;
-			wakeup = <1>;
+			wakeup-source;
 			label = "DSW2-1";
 			linux,code = <KEY_1>;
 			gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
 		};
 		button at 2 {
 			debounce_interval = <50>;
-			wakeup = <1>;
+			wakeup-source;
 			label = "DSW2-2";
 			linux,code = <KEY_2>;
 			gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
 		};
 		button at 3 {
 			debounce_interval = <50>;
-			wakeup = <1>;
+			wakeup-source;
 			label = "DSW2-3";
 			linux,code = <KEY_3>;
 			gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
 		};
 		button at 4 {
 			debounce_interval = <50>;
-			wakeup = <1>;
+			wakeup-source;
 			label = "DSW2-4";
 			linux,code = <KEY_4>;
 			gpios = <&gpio0 17 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index 32a5ccb14e7e..e80e42163883 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -47,35 +47,35 @@
 
 		button at 1 {
 			debounce_interval = <50>;
-			wakeup = <1>;
+			wakeup-source;
 			linux,code = <2>;
 			label = "userpb";
 			gpios = <&gpio1 0 0x4>;
 		};
 		button at 2 {
 			debounce_interval = <50>;
-			wakeup = <1>;
+			wakeup-source;
 			linux,code = <3>;
 			label = "extkb1";
 			gpios = <&gpio4 23 0x4>;
 		};
 		button at 3 {
 			debounce_interval = <50>;
-			wakeup = <1>;
+			wakeup-source;
 			linux,code = <4>;
 			label = "extkb2";
 			gpios = <&gpio4 24 0x4>;
 		};
 		button at 4 {
 			debounce_interval = <50>;
-			wakeup = <1>;
+			wakeup-source;
 			linux,code = <5>;
 			label = "extkb3";
 			gpios = <&gpio5 1 0x4>;
 		};
 		button at 5 {
 			debounce_interval = <50>;
-			wakeup = <1>;
+			wakeup-source;
 			linux,code = <6>;
 			label = "extkb4";
 			gpios = <&gpio5 2 0x4>;
diff --git a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
index 05e461dc6c1f..a15e1fb4d192 100644
--- a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
@@ -61,42 +61,42 @@
 
 				button at 1 {
 					debounce_interval = <50>;
-					wakeup = <1>;
+					wakeup-source;
 					linux,code = <116>;
 					label = "POWER";
 					gpios = <&iofpga_gpio0 0 0x4>;
 				};
 				button at 2 {
 					debounce_interval = <50>;
-					wakeup = <1>;
+					wakeup-source;
 					linux,code = <102>;
 					label = "HOME";
 					gpios = <&iofpga_gpio0 1 0x4>;
 				};
 				button at 3 {
 					debounce_interval = <50>;
-					wakeup = <1>;
+					wakeup-source;
 					linux,code = <152>;
 					label = "RLOCK";
 					gpios = <&iofpga_gpio0 2 0x4>;
 				};
 				button at 4 {
 					debounce_interval = <50>;
-					wakeup = <1>;
+					wakeup-source;
 					linux,code = <115>;
 					label = "VOL+";
 					gpios = <&iofpga_gpio0 3 0x4>;
 				};
 				button at 5 {
 					debounce_interval = <50>;
-					wakeup = <1>;
+					wakeup-source;
 					linux,code = <114>;
 					label = "VOL-";
 					gpios = <&iofpga_gpio0 4 0x4>;
 				};
 				button at 6 {
 					debounce_interval = <50>;
-					wakeup = <1>;
+					wakeup-source;
 					linux,code = <99>;
 					label = "NMI";
 					gpios = <&iofpga_gpio0 5 0x4>;
-- 
1.9.1
