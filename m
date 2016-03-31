From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 31 Mar 2016 22:54:09 +0200
Subject: [PATCH 3/5] ARM: dts: rockchip: clean up gpio-keys nodes
In-Reply-To: <1459457651-4727-1-git-send-email-heiko@sntech.de>
References: <1459457651-4727-1-git-send-email-heiko@sntech.de>
Message-ID: <1459457651-4727-4-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop superfluous #address-cells and #size-cells, rename
key-nodes to individual names and also use the key constants
intead of numbers.

Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a-bqcurie2.dts | 11 +++++------
 arch/arm/boot/dts/rk3066a-rayeager.dts |  7 +++----
 arch/arm/boot/dts/rk3188-radxarock.dts |  7 +++----
 arch/arm/boot/dts/rk3288-evb.dtsi      |  7 +++----
 arch/arm/boot/dts/rk3288-firefly.dtsi  |  7 +++----
 arch/arm/boot/dts/rk3288-popmetal.dts  |  8 +++-----
 arch/arm/boot/dts/rk3288-r89.dts       |  7 +++----
 7 files changed, 23 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
index 6d2a5b3..bc674ee 100644
--- a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
+++ b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
@@ -42,6 +42,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/input/input.h>
 #include "rk3066a.dtsi"
 
 / {
@@ -77,21 +78,19 @@
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		autorepeat;
 
-		button at 0 {
+		power {
 			gpios = <&gpio6 2 GPIO_ACTIVE_LOW>; /* GPIO6_A2 */
-			linux,code = <116>;
+			linux,code = <KEY_POWER>;
 			label = "GPIO Key Power";
 			linux,input-type = <1>;
 			wakeup-source;
 			debounce-interval = <100>;
 		};
-		button at 1 {
+		volume-down {
 			gpios = <&gpio4 21 GPIO_ACTIVE_LOW>; /* GPIO4_C5 */
-			linux,code = <104>;
+			linux,code = <KEY_VOLUMEDOWN>;
 			label = "GPIO Key Vol-";
 			linux,input-type = <1>;
 			debounce-interval = <100>;
diff --git a/arch/arm/boot/dts/rk3066a-rayeager.dts b/arch/arm/boot/dts/rk3066a-rayeager.dts
index 3a5989b..6e7f218 100644
--- a/arch/arm/boot/dts/rk3066a-rayeager.dts
+++ b/arch/arm/boot/dts/rk3066a-rayeager.dts
@@ -41,6 +41,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/input/input.h>
 #include "rk3066a.dtsi"
 
 / {
@@ -61,14 +62,12 @@
 
 	keys: gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
-		button at 0 {
+		power {
 			wakeup-source;
 			gpios = <&gpio6 2 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
-			linux,code = <116>;
+			linux,code = <KEY_POWER>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pwr_key>;
 		};
diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index 0b6924c..1da46d1 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -41,6 +41,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/input/input.h>
 #include "rk3188.dtsi"
 
 / {
@@ -54,13 +55,11 @@
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		autorepeat;
 
-		button at 0 {
+		power {
 			gpios = <&gpio0 4 GPIO_ACTIVE_LOW>;
-			linux,code = <116>;
+			linux,code = <KEY_POWER>;
 			label = "GPIO Key Power";
 			linux,input-type = <1>;
 			wakeup-source;
diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 3ccd8f3..963365d 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -38,6 +38,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/pwm/pwm.h>
 #include "rk3288.dtsi"
 
@@ -98,16 +99,14 @@
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		autorepeat;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwrbtn>;
 
-		button at 0 {
+		power {
 			gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
-			linux,code = <116>;
+			linux,code = <KEY_POWER>;
 			label = "GPIO Key Power";
 			linux,input-type = <1>;
 			wakeup-source;
diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index 5f06d8c..d6cf9ad 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -40,6 +40,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <dt-bindings/input/input.h>
 #include "rk3288.dtsi"
 
 / {
@@ -87,14 +88,12 @@
 
 	keys: gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
-		button at 0 {
+		power {
 			wakeup-source;
 			gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
-			linux,code = <116>;
+			linux,code = <KEY_POWER>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pwr_key>;
 		};
diff --git a/arch/arm/boot/dts/rk3288-popmetal.dts b/arch/arm/boot/dts/rk3288-popmetal.dts
index eb77276..720717b 100644
--- a/arch/arm/boot/dts/rk3288-popmetal.dts
+++ b/arch/arm/boot/dts/rk3288-popmetal.dts
@@ -41,7 +41,7 @@
  */
 
 /dts-v1/;
-
+#include <dt-bindings/input/input.h>
 #include "rk3288.dtsi"
 
 / {
@@ -62,16 +62,14 @@
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		autorepeat;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwrbtn>;
 
-		button at 0 {
+		power {
 			gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
-			linux,code = <116>;
+			linux,code = <KEY_POWER>;
 			label = "GPIO Key Power";
 			linux,input-type = <1>;
 			wakeup-source;
diff --git a/arch/arm/boot/dts/rk3288-r89.dts b/arch/arm/boot/dts/rk3288-r89.dts
index 510a1d0..4b8a8ad 100644
--- a/arch/arm/boot/dts/rk3288-r89.dts
+++ b/arch/arm/boot/dts/rk3288-r89.dts
@@ -41,6 +41,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/pwm/pwm.h>
 #include "rk3288.dtsi"
 
@@ -61,16 +62,14 @@
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		autorepeat;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwrbtn>;
 
-		button at 0 {
+		power {
 			gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
-			linux,code = <116>;
+			linux,code = <KEY_POWER>;
 			label = "GPIO Key Power";
 			linux,input-type = <1>;
 			wakeup-source;
-- 
2.6.4
