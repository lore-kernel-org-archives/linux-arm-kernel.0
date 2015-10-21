From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 21 Oct 2015 11:10:09 +0100
Subject: [PATCH 12/19] ARM: dts: exynos: replace legacy *,
 wakeup property with wakeup-source
In-Reply-To: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1445422216-29375-13-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Though the keyboard and other driver will continue to support the legacy
"gpio-key,wakeup", "linux-keypad,wakeup" boolean property to enable the
wakeup source, "wakeup-source" is the new standard binding.

This patch replaces all the legacy wakeup properties with the unified
"wakeup-source" property in order to avoid any futher copy-paste
duplication.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-samsung-soc at vger.kernel.org
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
 arch/arm/boot/dts/exynos5250-snow.dts           |  4 ++--
 arch/arm/boot/dts/exynos5250-spring.dts         |  4 ++--
 arch/arm/boot/dts/exynos5420-arndale-octa.dts   |  2 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts      |  4 ++--
 arch/arm/boot/dts/exynos5800-peach-pi.dts       |  4 ++--
 17 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
index 540a0adf2be6..b77ea2163a0a 100644
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
@@ -184,7 +184,7 @@
 		interrupt-parent = <&gpx0>;
 		interrupts = <7 0>;
 		reg = <0x66>;
-		wakeup;
+		wakeup-source;
 
 		s2mps14_osc: clocks {
 			compatible = "samsung,s2mps14-clk";
diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 41a5fafb9aa9..7acd11d2d957 100644
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
@@ -245,7 +245,7 @@
 		interrupt-parent = <&gpx0>;
 		interrupts = <7 0>;
 		reg = <0x66>;
-		wakeup;
+		wakeup-source;
 
 		s2mps14_osc: clocks {
 			compatible = "samsung,s2mps14-clk";
diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index e050d85cdacd..9e97f6065493 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -59,35 +59,35 @@
 			label = "Up";
 			gpios = <&gpx2 0 1>;
 			linux,code = <KEY_UP>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		down {
 			label = "Down";
 			gpios = <&gpx2 1 1>;
 			linux,code = <KEY_DOWN>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		back {
 			label = "Back";
 			gpios = <&gpx1 7 1>;
 			linux,code = <KEY_BACK>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		home {
 			label = "Home";
 			gpios = <&gpx1 6 1>;
 			linux,code = <KEY_HOME>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		menu {
 			label = "Menu";
 			gpios = <&gpx1 5 1>;
 			linux,code = <KEY_MENU>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
index 043b03caff8f..82babe064576 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -69,7 +69,7 @@
 	samsung,keypad-num-rows = <2>;
 	samsung,keypad-num-columns = <8>;
 	linux,keypad-no-autorepeat;
-	linux,keypad-wakeup;
+	wakeup-source;
 	pinctrl-names = "default";
 	pinctrl-0 = <&keypad_rows &keypad_cols>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index ba34886f8b65..1317c0fc7005 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -111,7 +111,7 @@
 			linux,code = <116>;
 			label = "power";
 			debounce-interval = <10>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		ok-key {
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index eb379526e234..0eed67bef4b7 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -91,7 +91,7 @@
 			linux,code = <171>;
 			label = "config";
 			debounce-interval = <1>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		camera-key {
@@ -106,7 +106,7 @@
 			linux,code = <116>;
 			label = "power";
 			debounce-interval = <1>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		ok-key {
diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index db52841297a5..079f2d373c4c 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -34,7 +34,7 @@
 			linux,code = <KEY_POWER>;
 			label = "power key";
 			debounce-interval = <10>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index 679ac103ebf6..9491449c01e8 100644
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
index 9d528af68c1a..107e77dc8060 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -426,7 +426,7 @@
 	samsung,keypad-num-rows = <3>;
 	samsung,keypad-num-columns = <2>;
 	linux,keypad-no-autorepeat;
-	linux,keypad-wakeup;
+	wakeup-source;
 	pinctrl-0 = <&keypad_rows &keypad_cols>;
 	pinctrl-names = "default";
 	status = "okay";
diff --git a/arch/arm/boot/dts/exynos4412-smdk4412.dts b/arch/arm/boot/dts/exynos4412-smdk4412.dts
index c2421df1fa43..210a6b2e51d4 100644
--- a/arch/arm/boot/dts/exynos4412-smdk4412.dts
+++ b/arch/arm/boot/dts/exynos4412-smdk4412.dts
@@ -49,7 +49,7 @@
 	samsung,keypad-num-rows = <3>;
 	samsung,keypad-num-columns = <8>;
 	linux,keypad-no-autorepeat;
-	linux,keypad-wakeup;
+	wakeup-source;
 	pinctrl-0 = <&keypad_rows &keypad_cols>;
 	pinctrl-names = "default";
 	status = "okay";
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 2a1ebb76ebe0..cdb2e81d9d04 100644
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
index db3f65f3eb45..866934e948fc 100644
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
 
diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 0720caab5511..cb13c94e6089 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -41,7 +41,7 @@
 			label = "Power";
 			gpios = <&gpx1 3 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		lid-switch {
@@ -50,7 +50,7 @@
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
index eeb4ac22cfce..797c05dec637 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -46,7 +46,7 @@
 			label = "SW-TACT1";
 			gpios = <&gpx2 7 1>;
 			linux,code = <KEY_WAKEUP>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 8f4d76c5e11c..d8ab9b6f4999 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
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
 
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 7d5b386b5ae6..68b7e8bcc5bd 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -63,7 +63,7 @@
 			label = "Power";
 			gpios = <&gpx1 2 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		lid-switch {
@@ -72,7 +72,7 @@
 			linux,input-type = <5>; /* EV_SW */
 			linux,code = <0>; /* SW_LID */
 			debounce-interval = <1>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 	};
-- 
1.9.1
