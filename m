From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 28 Jan 2016 15:59:58 +0000
Subject: [UPDATE] [PATCH 12/19] ARM: dts: exynos: replace legacy *,
 wakeup property with wakeup-source
In-Reply-To: <56A9CD1A.8010800@samsung.com>
References: <56A9CD1A.8010800@samsung.com>
Message-ID: <1453996798-10711-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Though the keyboard and other driver will continue to support the legacy
"gpio-key,wakeup", "linux-keypad,wakeup" boolean property to enable the
wakeup source, "wakeup-source" is the new standard binding.

This patch replaces all the legacy wakeup properties with the unified
"wakeup-source" property in order to avoid any further copy-paste
duplication.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: linux-samsung-soc at vger.kernel.org
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/exynos3250-monk.dts           |  6 +++---
 arch/arm/boot/dts/exynos3250-rinato.dts         |  6 +++---
 arch/arm/boot/dts/exynos4210-origen.dts         | 10 +++++-----
 arch/arm/boot/dts/exynos4210-smdkv310.dts       |  2 +-
 arch/arm/boot/dts/exynos4210-trats.dts          |  2 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts |  4 ++--
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |  2 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts        |  2 +-
 arch/arm/boot/dts/exynos4412-origen.dts         |  2 +-
 arch/arm/boot/dts/exynos4412-smdk4412.dts       |  2 +-
 arch/arm/boot/dts/exynos4412-trats2.dts         |  4 ++--
 arch/arm/boot/dts/exynos5250-arndale.dts        | 12 ++++++------
 arch/arm/boot/dts/exynos5250-snow-common.dtsi   |  4 ++--
 arch/arm/boot/dts/exynos5250-spring.dts         |  4 ++--
 arch/arm/boot/dts/exynos5420-arndale-octa.dts   |  2 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts      |  4 ++--
 arch/arm/boot/dts/exynos5800-peach-pi.dts       |  4 ++--
 17 files changed, 36 insertions(+), 36 deletions(-)

Hi Krzysztof,

Thanks for picking up on this. I have rebased on:
git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git next/dt

Regards,
Sudeep

diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
index 443a35085846..9e2840b59ae8 100644
--- a/arch/arm/boot/dts/exynos3250-monk.dts
+++ b/arch/arm/boot/dts/exynos3250-monk.dts
@@ -43,7 +43,7 @@
 			linux,code = <KEY_POWER>;
 			label = "power key";
 			debounce-interval = <10>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
@@ -67,7 +67,7 @@
 			interrupt-parent = <&gpx1>;
 			interrupts = <5 0>;
 			reg = <0x25>;
-			wakeup;
+			wakeup-source;
 
 			muic: max77836-muic {
 				compatible = "maxim,max77836-muic";
@@ -185,7 +185,7 @@
 		interrupt-parent = <&gpx0>;
 		interrupts = <7 0>;
 		reg = <0x66>;
-		wakeup;
+		wakeup-source;
 
 		s2mps14_osc: clocks {
 			compatible = "samsung,s2mps14-clk";
diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 3e64d5dcdd60..1f102f3a1ab1 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -43,7 +43,7 @@
 			linux,code = <KEY_POWER>;
 			label = "power key";
 			debounce-interval = <10>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
@@ -58,7 +58,7 @@
 			interrupt-parent = <&gpx1>;
 			interrupts = <5 0>;
 			reg = <0x25>;
-			wakeup;
+			wakeup-source;
 
 			muic: max77836-muic {
 				compatible = "maxim,max77836-muic";
@@ -246,7 +246,7 @@
 		interrupt-parent = <&gpx0>;
 		interrupts = <7 0>;
 		reg = <0x66>;
-		wakeup;
+		wakeup-source;
 
 		s2mps14_osc: clocks {
 			compatible = "samsung,s2mps14-clk";
diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index 5821ad87e32c..ad7394c1d67a 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -60,35 +60,35 @@
 			label = "Up";
 			gpios = <&gpx2 0 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_UP>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		down {
 			label = "Down";
 			gpios = <&gpx2 1 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_DOWN>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		back {
 			label = "Back";
 			gpios = <&gpx1 7 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_BACK>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		home {
 			label = "Home";
 			gpios = <&gpx1 6 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_HOME>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		menu {
 			label = "Menu";
 			gpios = <&gpx1 5 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_MENU>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
index 104cbb33d2bb..94ca7d36ab37 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -66,7 +66,7 @@
 	samsung,keypad-num-rows = <2>;
 	samsung,keypad-num-columns = <8>;
 	linux,keypad-no-autorepeat;
-	linux,keypad-wakeup;
+	wakeup-source;
 	pinctrl-names = "default";
 	pinctrl-0 = <&keypad_rows &keypad_cols>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index a50be640f1b0..1df2f0bc1d76 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -112,7 +112,7 @@
 			linux,code = <116>;
 			label = "power";
 			debounce-interval = <10>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		ok-key {
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index 4f5d37920c8d..9a75e3effbc9 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -92,7 +92,7 @@
 			linux,code = <171>;
 			label = "config";
 			debounce-interval = <1>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		camera-key {
@@ -107,7 +107,7 @@
 			linux,code = <116>;
 			label = "power";
 			debounce-interval = <1>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		ok-key {
diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 395c3ca9601e..5e5d3fecb04c 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -35,7 +35,7 @@
 			linux,code = <KEY_POWER>;
 			label = "power key";
 			debounce-interval = <10>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index b44bb682e976..bf7b21b817e4 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -48,7 +48,7 @@
 			linux,code = <KEY_HOME>;
 			label = "home key";
 			debounce-interval = <10>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index 9e2e24c6177a..8bca699b7f20 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -423,7 +423,7 @@
 	samsung,keypad-num-rows = <3>;
 	samsung,keypad-num-columns = <2>;
 	linux,keypad-no-autorepeat;
-	linux,keypad-wakeup;
+	wakeup-source;
 	pinctrl-0 = <&keypad_rows &keypad_cols>;
 	pinctrl-names = "default";
 	status = "okay";
diff --git a/arch/arm/boot/dts/exynos4412-smdk4412.dts b/arch/arm/boot/dts/exynos4412-smdk4412.dts
index a130ab39fa77..a51069f3c03b 100644
--- a/arch/arm/boot/dts/exynos4412-smdk4412.dts
+++ b/arch/arm/boot/dts/exynos4412-smdk4412.dts
@@ -45,7 +45,7 @@
 	samsung,keypad-num-rows = <3>;
 	samsung,keypad-num-columns = <8>;
 	linux,keypad-no-autorepeat;
-	linux,keypad-wakeup;
+	wakeup-source;
 	pinctrl-0 = <&keypad_rows &keypad_cols>;
 	pinctrl-names = "default";
 	status = "okay";
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index a6f78c3da935..ed017cc7b14f 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -119,7 +119,7 @@
 			linux,code = <116>;
 			label = "power";
 			debounce-interval = <10>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		key-ok {
@@ -127,7 +127,7 @@
 			linux,code = <139>;
 			label = "ok";
 			debounce-inteval = <10>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index c000532c1444..8b2acc74aa76 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -34,42 +34,42 @@
 			label = "SW-TACT2";
 			gpios = <&gpx1 4 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_MENU>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		home {
 			label = "SW-TACT3";
 			gpios = <&gpx1 5 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_HOME>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		up {
 			label = "SW-TACT4";
 			gpios = <&gpx1 6 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_UP>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		down {
 			label = "SW-TACT5";
 			gpios = <&gpx1 7 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_DOWN>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		back {
 			label = "SW-TACT6";
 			gpios = <&gpx2 0 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_BACK>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		wakeup {
 			label = "SW-TACT7";
 			gpios = <&gpx2 1 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_WAKEUP>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
index 5cb33ba5e296..95210ef6a6b5 100644
--- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
@@ -37,7 +37,7 @@
 			label = "Power";
 			gpios = <&gpx1 3 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		lid-switch {
@@ -46,7 +46,7 @@
 			linux,input-type = <5>; /* EV_SW */
 			linux,code = <0>; /* SW_LID */
 			debounce-interval = <1>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
index c1edd6d038a9..0f500cb1eb2d 100644
--- a/arch/arm/boot/dts/exynos5250-spring.dts
+++ b/arch/arm/boot/dts/exynos5250-spring.dts
@@ -37,7 +37,7 @@
 			label = "Power";
 			gpios = <&gpx1 3 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		lid-switch {
@@ -46,7 +46,7 @@
 			linux,input-type = <5>; /* EV_SW */
 			linux,code = <0>; /* SW_LID */
 			debounce-interval = <1>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 762f6ffece0c..a103ce8c3985 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -48,7 +48,7 @@
 			label = "SW-TACT1";
 			gpios = <&gpx2 7 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_WAKEUP>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index f7b31e16d07f..3981ddb25036 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -65,7 +65,7 @@
 			label = "Power";
 			gpios = <&gpx1 2 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		lid-switch {
@@ -74,7 +74,7 @@
 			linux,input-type = <5>; /* EV_SW */
 			linux,code = <0>; /* SW_LID */
 			debounce-interval = <1>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 4731dbb5b450..6e9edc1610c4 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -64,7 +64,7 @@
 			label = "Power";
 			gpios = <&gpx1 2 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		lid-switch {
@@ -73,7 +73,7 @@
 			linux,input-type = <5>; /* EV_SW */
 			linux,code = <0>; /* SW_LID */
 			debounce-interval = <1>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 	};
-- 
1.9.1
