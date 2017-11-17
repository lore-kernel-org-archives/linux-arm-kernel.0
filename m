From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 17 Nov 2017 14:24:45 +0900
Subject: [PATCH 1/4] ARM: dts: uniphier: use macros in dt-bindings header
Message-ID: <1510896288-31212-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dt-bindings header was applied to the driver subsystem.  I had to
wait for a merge window to use it from DT.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ld4-ref.dts  | 2 +-
 arch/arm/boot/dts/uniphier-ld4.dtsi     | 2 ++
 arch/arm/boot/dts/uniphier-ld6b-ref.dts | 2 +-
 arch/arm/boot/dts/uniphier-pro4-ref.dts | 2 +-
 arch/arm/boot/dts/uniphier-pro4.dtsi    | 2 ++
 arch/arm/boot/dts/uniphier-pxs2.dtsi    | 1 +
 arch/arm/boot/dts/uniphier-sld8-ref.dts | 2 +-
 arch/arm/boot/dts/uniphier-sld8.dtsi    | 2 ++
 8 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-ld4-ref.dts b/arch/arm/boot/dts/uniphier-ld4-ref.dts
index 0056852..a3afd0c 100644
--- a/arch/arm/boot/dts/uniphier-ld4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld4-ref.dts
@@ -56,7 +56,7 @@
 &gpio {
 	xirq1 {
 		gpio-hog;
-		gpios = <121 0>;
+		gpios = <UNIPHIER_GPIO_IRQ(1) 0>;
 		input;
 	};
 };
diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
index 01fc3e1..1b98778 100644
--- a/arch/arm/boot/dts/uniphier-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
@@ -7,6 +7,8 @@
  * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
+#include <dt-bindings/gpio/uniphier-gpio.h>
+
 / {
 	compatible = "socionext,uniphier-ld4";
 	#address-cells = <1>;
diff --git a/arch/arm/boot/dts/uniphier-ld6b-ref.dts b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
index 0e510a7..811b999 100644
--- a/arch/arm/boot/dts/uniphier-ld6b-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
@@ -58,7 +58,7 @@
 &gpio {
 	xirq4 {
 		gpio-hog;
-		gpios = <124 0>;
+		gpios = <UNIPHIER_GPIO_IRQ(4) 0>;
 		input;
 	};
 };
diff --git a/arch/arm/boot/dts/uniphier-pro4-ref.dts b/arch/arm/boot/dts/uniphier-pro4-ref.dts
index be99467..6a004e5 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ref.dts
@@ -58,7 +58,7 @@
 &gpio {
 	xirq2 {
 		gpio-hog;
-		gpios = <122 0>;
+		gpios = <UNIPHIER_GPIO_IRQ(2) 0>;
 		input;
 	};
 };
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index 7955c3a..b682a42 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -7,6 +7,8 @@
  * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
+#include <dt-bindings/gpio/uniphier-gpio.h>
+
 / {
 	compatible = "socionext,uniphier-pro4";
 	#address-cells = <1>;
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index d82d6d8..eafe4dd 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -7,6 +7,7 @@
  * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
+#include <dt-bindings/gpio/uniphier-gpio.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
diff --git a/arch/arm/boot/dts/uniphier-sld8-ref.dts b/arch/arm/boot/dts/uniphier-sld8-ref.dts
index 1c0e707..e052ea3 100644
--- a/arch/arm/boot/dts/uniphier-sld8-ref.dts
+++ b/arch/arm/boot/dts/uniphier-sld8-ref.dts
@@ -56,7 +56,7 @@
 &gpio {
 	xirq0 {
 		gpio-hog;
-		gpios = <120 0>;
+		gpios = <UNIPHIER_GPIO_IRQ(0) 0>;
 		input;
 	};
 };
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index 7188536..89c01cc 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -7,6 +7,8 @@
  * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
+#include <dt-bindings/gpio/uniphier-gpio.h>
+
 / {
 	compatible = "socionext,uniphier-sld8";
 	#address-cells = <1>;
-- 
2.7.4
