From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 17 Nov 2017 14:24:47 +0900
Subject: [PATCH 3/4] arm64: dts: uniphier: use macros in dt-bindings header
In-Reply-To: <1510896288-31212-1-git-send-email-yamada.masahiro@socionext.com>
References: <1510896288-31212-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1510896288-31212-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dt-bindings header was applied to the driver subsystem.  I had to
wait for a merge window to use it from DT.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi    | 3 ++-
 arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi    | 3 ++-
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi    | 3 ++-
 5 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
index 6bdefb2..54c5317 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
@@ -50,7 +50,7 @@
 &gpio {
 	xirq0 {
 		gpio-hog;
-		gpios = <120 0>;
+		gpios = <UNIPHIER_GPIO_IRQ(0) 0>;
 		input;
 	};
 };
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index 1c63d0a..ce40eb5 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -8,6 +8,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/uniphier-gpio.h>
 
 /memreserve/ 0x80000000 0x02000000;
 
@@ -100,7 +101,7 @@
 
 	emmc_pwrseq: emmc-pwrseq {
 		compatible = "mmc-pwrseq-emmc";
-		reset-gpios = <&gpio 26 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio UNIPHIER_GPIO_PORT(3, 2) GPIO_ACTIVE_LOW>;
 	};
 
 	timer {
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
index 254d679..6933710 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
@@ -50,7 +50,7 @@
 &gpio {
 	xirq0 {
 		gpio-hog;
-		gpios = <120 0>;
+		gpios = <UNIPHIER_GPIO_IRQ(0) 0>;
 		input;
 	};
 };
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 5c81070..8a3276b 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -8,6 +8,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/uniphier-gpio.h>
 #include <dt-bindings/thermal/thermal.h>
 
 /memreserve/ 0x80000000 0x02000000;
@@ -172,7 +173,7 @@
 
 	emmc_pwrseq: emmc-pwrseq {
 		compatible = "mmc-pwrseq-emmc";
-		reset-gpios = <&gpio 26 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio UNIPHIER_GPIO_PORT(3, 2) GPIO_ACTIVE_LOW>;
 	};
 
 	timer {
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index 48e7331..d2beadd 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -8,6 +8,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/uniphier-gpio.h>
 
 /memreserve/ 0x80000000 0x02000000;
 
@@ -128,7 +129,7 @@
 
 	emmc_pwrseq: emmc-pwrseq {
 		compatible = "mmc-pwrseq-emmc";
-		reset-gpios = <&gpio 47 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio UNIPHIER_GPIO_PORT(5, 7) GPIO_ACTIVE_LOW>;
 	};
 
 	timer {
-- 
2.7.4
