From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Thu, 28 Mar 2013 12:12:41 +0530
Subject: [PATCH-V2 4/6] ARM: dts: AM33XX: Add pinctrl binding to gpio-leds node
In-Reply-To: <1364452963-22083-1-git-send-email-hvaibhav@ti.com>
References: <1364452963-22083-1-git-send-email-hvaibhav@ti.com>
Message-ID: <1364452963-22083-5-git-send-email-hvaibhav@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now gpio-leds driver is using devm_pinctrl_get_select_default()
api to set default pinmux configuration required for the
functionality of the driver, so this patch moves respective
pinctrl binding inside leds node.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts  |    5 ++++-
 arch/arm/boot/dts/am335x-evmsk.dts |    5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 860630b..1d623e4 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -26,7 +26,7 @@

 	am33xx_pinmux: pinmux at 44e10800 {
 		pinctrl-names = "default";
-		pinctrl-0 = <&user_leds_s0>;
+		pinctrl-0 = <>;

 		user_leds_s0: user_leds_s0 {
 			pinctrl-single,pins = <
@@ -65,6 +65,9 @@
 	};

 	leds {
+		pinctrl-names = "default";
+		pinctrl-0 = <&user_leds_s0>;
+
 		compatible = "gpio-leds";

 		led at 2 {
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 15a3052..21d5a08 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -32,7 +32,7 @@

 	am33xx_pinmux: pinmux at 44e10800 {
 		pinctrl-names = "default";
-		pinctrl-0 = <&user_leds_s0 &gpio_keys_s0>;
+		pinctrl-0 = <&gpio_keys_s0>;

 		user_leds_s0: user_leds_s0 {
 			pinctrl-single,pins = <
@@ -121,6 +121,9 @@
 	};

 	leds {
+		pinctrl-names = "default";
+		pinctrl-0 = <&user_leds_s0>;
+
 		compatible = "gpio-leds";

 		led at 1 {
--
1.7.0.4
