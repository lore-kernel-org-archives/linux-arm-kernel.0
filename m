From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:24 +0900
Subject: [PATCH 50/69] ARM: shmobile: Enable DSW2 with gpio-keys on KZM9D
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <cef20af093fc018009ed7f7fde38f9fb8b445e6b.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Use the gpio-keys driver to support the 4 pins on the
dip switch DSW2 which is mounted on the KZM9D board.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2-kzm9d.dts | 39 ++++++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/emev2.dtsi      |  2 +-
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
index 861aa7d..baaa66c 100644
--- a/arch/arm/boot/dts/emev2-kzm9d.dts
+++ b/arch/arm/boot/dts/emev2-kzm9d.dts
@@ -9,7 +9,9 @@
  */
 /dts-v1/;
 
-/include/ "emev2.dtsi"
+#include "emev2.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "EMEV2 KZM9D Board";
@@ -54,4 +56,39 @@
 		vddvario-supply = <&reg_1p8v>;
 		vdd33a-supply = <&reg_3p3v>;
 	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		button at 1 {
+			debounce_interval = <50>;
+			wakeup = <1>;
+			label = "DSW2-1";
+			linux,code = <KEY_1>;
+			gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
+		};
+		button at 2 {
+			debounce_interval = <50>;
+			wakeup = <1>;
+			label = "DSW2-2";
+			linux,code = <KEY_2>;
+			gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
+		};
+		button at 3 {
+			debounce_interval = <50>;
+			wakeup = <1>;
+			label = "DSW2-3";
+			linux,code = <KEY_3>;
+			gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
+		};
+		button at 4 {
+			debounce_interval = <50>;
+			wakeup = <1>;
+			label = "DSW2-4";
+			linux,code = <KEY_4>;
+			gpios = <&gpio0 17 GPIO_ACTIVE_HIGH>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/emev2.dtsi
index df1d4cd..256c2f8 100644
--- a/arch/arm/boot/dts/emev2.dtsi
+++ b/arch/arm/boot/dts/emev2.dtsi
@@ -8,7 +8,7 @@
  * kind, whether express or implied.
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	compatible = "renesas,emev2";
-- 
1.8.4
