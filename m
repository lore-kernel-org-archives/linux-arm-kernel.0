From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 31 Aug 2016 14:13:29 +0200
Subject: [PATCH 5/9] ARM: dts: exynos: Use macros for GPIO configuration on
 exynos4x12
In-Reply-To: <1472645613-5362-1-git-send-email-k.kozlowski@samsung.com>
References: <1472645613-5362-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1472645613-5362-6-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Usage of DTS macros instead of hard-coded numbers makes code easier to
read.  One does not have to remember which value means pull-up/down or
specific driver strength.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |  14 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts        |   2 +-
 arch/arm/boot/dts/exynos4412-origen.dts         |  12 +-
 arch/arm/boot/dts/exynos4412-smdk4412.dts       |  12 +-
 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi       | 504 ++++++++++++------------
 5 files changed, 272 insertions(+), 272 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index be644fe6a0fd..5adbeb485a97 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -163,26 +163,26 @@
 
 /* RSTN signal for eMMC */
 &sd1_cd {
-	samsung,pin-pud = <0>;
-	samsung,pin-drv = <0>;
+	samsung,pin-pud = <PIN_PULL_NONE>;
+	samsung,pin-drv = <PIN_DRV_LV1>;
 };
 
 &pinctrl_1 {
 	gpio_power_key: power_key {
 		samsung,pins = "gpx1-3";
-		samsung,pin-pud = <0>;
+		samsung,pin-pud = <PIN_PULL_NONE>;
 	};
 
 	max77686_irq: max77686-irq {
 		samsung,pins = "gpx3-2";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <PIN_FUNC_INPUT>;
+		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-drv = <PIN_DRV_LV1>;
 	};
 
 	hdmi_hpd: hdmi-hpd {
 		samsung,pins = "gpx3-7";
-		samsung,pin-pud = <1>;
+		samsung,pin-pud = <PIN_PULL_DOWN>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index 2af235151301..647a3e97d942 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -83,7 +83,7 @@
 &pinctrl_1 {
 	gpio_home_key: home_key {
 		samsung,pins = "gpx2-2";
-		samsung,pin-pud = <0>;
+		samsung,pin-pud = <PIN_PULL_NONE>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index 26a36fed9652..0a490e0e7eac 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -500,16 +500,16 @@
 &pinctrl_1 {
 	keypad_rows: keypad-rows {
 		samsung,pins = "gpx2-0", "gpx2-1", "gpx2-2";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <PIN_FUNC_SPC_3>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-drv = <PIN_DRV_LV1>;
 	};
 
 	keypad_cols: keypad-cols {
 		samsung,pins = "gpx1-0", "gpx1-1";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <PIN_FUNC_SPC_3>;
+		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-drv = <PIN_DRV_LV1>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/exynos4412-smdk4412.dts b/arch/arm/boot/dts/exynos4412-smdk4412.dts
index 231ffbdbf9d0..d9ce24416bed 100644
--- a/arch/arm/boot/dts/exynos4412-smdk4412.dts
+++ b/arch/arm/boot/dts/exynos4412-smdk4412.dts
@@ -115,17 +115,17 @@
 &pinctrl_1 {
 	keypad_rows: keypad-rows {
 		samsung,pins = "gpx2-0", "gpx2-1", "gpx2-2";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <PIN_FUNC_SPC_3>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-drv = <PIN_DRV_LV1>;
 	};
 
 	keypad_cols: keypad-cols {
 		samsung,pins = "gpx1-0", "gpx1-1", "gpx1-2", "gpx1-3",
 			       "gpx1-4", "gpx1-5", "gpx1-6", "gpx1-7";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <PIN_FUNC_SPC_3>;
+		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-drv = <PIN_DRV_LV1>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi b/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
index ba5865208d3e..dc5e9a932357 100644
--- a/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
@@ -149,245 +149,245 @@
 
 		uart0_data: uart0-data {
 			samsung,pins = "gpa0-0", "gpa0-1";
-			samsung,pin-function = <0x2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		uart0_fctl: uart0-fctl {
 			samsung,pins = "gpa0-2", "gpa0-3";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		uart1_data: uart1-data {
 			samsung,pins = "gpa0-4", "gpa0-5";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		uart1_fctl: uart1-fctl {
 			samsung,pins = "gpa0-6", "gpa0-7";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		i2c2_bus: i2c2-bus {
 			samsung,pins = "gpa0-6", "gpa0-7";
-			samsung,pin-function = <3>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_3>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		uart2_data: uart2-data {
 			samsung,pins = "gpa1-0", "gpa1-1";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		uart2_fctl: uart2-fctl {
 			samsung,pins = "gpa1-2", "gpa1-3";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		uart_audio_a: uart-audio-a {
 			samsung,pins = "gpa1-0", "gpa1-1";
-			samsung,pin-function = <4>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_4>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		i2c3_bus: i2c3-bus {
 			samsung,pins = "gpa1-2", "gpa1-3";
-			samsung,pin-function = <3>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_3>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		uart3_data: uart3-data {
 			samsung,pins = "gpa1-4", "gpa1-5";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		uart_audio_b: uart-audio-b {
 			samsung,pins = "gpa1-4", "gpa1-5";
-			samsung,pin-function = <4>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_4>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		spi0_bus: spi0-bus {
 			samsung,pins = "gpb-0", "gpb-2", "gpb-3";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		i2c4_bus: i2c4-bus {
 			samsung,pins = "gpb-0", "gpb-1";
-			samsung,pin-function = <3>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_3>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		spi1_bus: spi1-bus {
 			samsung,pins = "gpb-4", "gpb-6", "gpb-7";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		i2c5_bus: i2c5-bus {
 			samsung,pins = "gpb-2", "gpb-3";
-			samsung,pin-function = <3>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_3>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		i2s1_bus: i2s1-bus {
 			samsung,pins = "gpc0-0", "gpc0-1", "gpc0-2", "gpc0-3",
 					"gpc0-4";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		pcm1_bus: pcm1-bus {
 			samsung,pins = "gpc0-0", "gpc0-1", "gpc0-2", "gpc0-3",
 					"gpc0-4";
-			samsung,pin-function = <3>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_3>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		ac97_bus: ac97-bus {
 			samsung,pins = "gpc0-0", "gpc0-1", "gpc0-2", "gpc0-3",
 					"gpc0-4";
-			samsung,pin-function = <4>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_4>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		i2s2_bus: i2s2-bus {
 			samsung,pins = "gpc1-0", "gpc1-1", "gpc1-2", "gpc1-3",
 					"gpc1-4";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		pcm2_bus: pcm2-bus {
 			samsung,pins = "gpc1-0", "gpc1-1", "gpc1-2", "gpc1-3",
 					"gpc1-4";
-			samsung,pin-function = <3>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_3>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		spdif_bus: spdif-bus {
 			samsung,pins = "gpc1-0", "gpc1-1";
-			samsung,pin-function = <4>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_4>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		i2c6_bus: i2c6-bus {
 			samsung,pins = "gpc1-3", "gpc1-4";
-			samsung,pin-function = <4>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_4>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		spi2_bus: spi2-bus {
 			samsung,pins = "gpc1-1", "gpc1-3", "gpc1-4";
-			samsung,pin-function = <5>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_5>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		pwm0_out: pwm0-out {
 			samsung,pins = "gpd0-0";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		pwm1_out: pwm1-out {
 			samsung,pins = "gpd0-1";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		lcd_ctrl: lcd-ctrl {
 			samsung,pins = "gpd0-0", "gpd0-1";
-			samsung,pin-function = <3>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_3>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		i2c7_bus: i2c7-bus {
 			samsung,pins = "gpd0-2", "gpd0-3";
-			samsung,pin-function = <3>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_3>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		pwm2_out: pwm2-out {
 			samsung,pins = "gpd0-2";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		pwm3_out: pwm3-out {
 			samsung,pins = "gpd0-3";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		i2c0_bus: i2c0-bus {
 			samsung,pins = "gpd1-0", "gpd1-1";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		mipi0_clk: mipi0-clk {
 			samsung,pins = "gpd1-0", "gpd1-1";
-			samsung,pin-function = <3>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_3>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		i2c1_bus: i2c1-bus {
 			samsung,pins = "gpd1-2", "gpd1-3";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		mipi1_clk: mipi1-clk {
 			samsung,pins = "gpd1-2", "gpd1-3";
-			samsung,pin-function = <3>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_3>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		lcd_clk: lcd-clk {
 			samsung,pins = "gpf0-0", "gpf0-1", "gpf0-2", "gpf0-3";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		lcd_data16: lcd-data-width16 {
@@ -395,9 +395,9 @@
 					"gpf1-3", "gpf1-6", "gpf1-7", "gpf2-0",
 					"gpf2-1", "gpf2-2", "gpf2-3", "gpf2-7",
 					"gpf3-0", "gpf3-1", "gpf3-2", "gpf3-3";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		lcd_data18: lcd-data-width18 {
@@ -406,9 +406,9 @@
 					"gpf2-0", "gpf2-1", "gpf2-2", "gpf2-3",
 					"gpf2-6", "gpf2-7", "gpf3-0", "gpf3-1",
 					"gpf3-2", "gpf3-3";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		lcd_data24: lcd-data-width24 {
@@ -418,39 +418,39 @@
 					"gpf2-0", "gpf2-1", "gpf2-2", "gpf2-3",
 					"gpf2-4", "gpf2-5", "gpf2-6", "gpf2-7",
 					"gpf3-0", "gpf3-1", "gpf3-2", "gpf3-3";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		lcd_ldi: lcd-ldi {
 			samsung,pins = "gpf3-4";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		cam_port_a_io: cam-port-a-io {
 			samsung,pins = "gpj0-0", "gpj0-1", "gpj0-2", "gpj0-3",
 					"gpj0-4", "gpj0-5", "gpj0-6", "gpj0-7",
 					"gpj1-0", "gpj1-1", "gpj1-2", "gpj1-4";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		cam_port_a_clk_active: cam-port-a-clk-active {
 			samsung,pins = "gpj1-3";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		cam_port_a_clk_idle: cam-port-a-clk-idle {
 			samsung,pins = "gpj1-3";
-			samsung,pin-function = <0>;
-			samsung,pin-pud = <1>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_INPUT>;
+			samsung,pin-pud = <PIN_PULL_DOWN>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 	};
 
@@ -626,284 +626,284 @@
 
 		sd0_clk: sd0-clk {
 			samsung,pins = "gpk0-0";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		sd0_cmd: sd0-cmd {
 			samsung,pins = "gpk0-1";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		sd0_cd: sd0-cd {
 			samsung,pins = "gpk0-2";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		sd0_bus1: sd0-bus-width1 {
 			samsung,pins = "gpk0-3";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		sd0_bus4: sd0-bus-width4 {
 			samsung,pins = "gpk0-3", "gpk0-4", "gpk0-5", "gpk0-6";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		sd0_bus8: sd0-bus-width8 {
 			samsung,pins = "gpk1-3", "gpk1-4", "gpk1-5", "gpk1-6";
-			samsung,pin-function = <3>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_3>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		sd4_clk: sd4-clk {
 			samsung,pins = "gpk0-0";
-			samsung,pin-function = <3>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_3>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		sd4_cmd: sd4-cmd {
 			samsung,pins = "gpk0-1";
-			samsung,pin-function = <3>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_3>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		sd4_cd: sd4-cd {
 			samsung,pins = "gpk0-2";
-			samsung,pin-function = <3>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_3>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		sd4_bus1: sd4-bus-width1 {
 			samsung,pins = "gpk0-3";
-			samsung,pin-function = <3>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_3>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		sd4_bus4: sd4-bus-width4 {
 			samsung,pins = "gpk0-3", "gpk0-4", "gpk0-5", "gpk0-6";
-			samsung,pin-function = <3>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_3>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		sd4_bus8: sd4-bus-width8 {
 			samsung,pins = "gpk1-3", "gpk1-4", "gpk1-5", "gpk1-6";
-			samsung,pin-function = <4>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_4>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		sd1_clk: sd1-clk {
 			samsung,pins = "gpk1-0";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		sd1_cmd: sd1-cmd {
 			samsung,pins = "gpk1-1";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		sd1_cd: sd1-cd {
 			samsung,pins = "gpk1-2";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		sd1_bus1: sd1-bus-width1 {
 			samsung,pins = "gpk1-3";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		sd1_bus4: sd1-bus-width4 {
 			samsung,pins = "gpk1-3", "gpk1-4", "gpk1-5", "gpk1-6";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		sd2_clk: sd2-clk {
 			samsung,pins = "gpk2-0";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		sd2_cmd: sd2-cmd {
 			samsung,pins = "gpk2-1";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		sd2_cd: sd2-cd {
 			samsung,pins = "gpk2-2";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		sd2_bus1: sd2-bus-width1 {
 			samsung,pins = "gpk2-3";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		sd2_bus4: sd2-bus-width4 {
 			samsung,pins = "gpk2-3", "gpk2-4", "gpk2-5", "gpk2-6";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		sd2_bus8: sd2-bus-width8 {
 			samsung,pins = "gpk3-3", "gpk3-4", "gpk3-5", "gpk3-6";
-			samsung,pin-function = <3>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_3>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		sd3_clk: sd3-clk {
 			samsung,pins = "gpk3-0";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		sd3_cmd: sd3-cmd {
 			samsung,pins = "gpk3-1";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		sd3_cd: sd3-cd {
 			samsung,pins = "gpk3-2";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		sd3_bus1: sd3-bus-width1 {
 			samsung,pins = "gpk3-3";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		sd3_bus4: sd3-bus-width4 {
 			samsung,pins = "gpk3-3", "gpk3-4", "gpk3-5", "gpk3-6";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		cam_port_b_io: cam-port-b-io {
 			samsung,pins = "gpm0-0", "gpm0-1", "gpm0-2", "gpm0-3",
 					"gpm0-4", "gpm0-5", "gpm0-6", "gpm0-7",
 					"gpm1-0", "gpm1-1", "gpm2-0", "gpm2-1";
-			samsung,pin-function = <3>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_3>;
+			samsung,pin-pud = <PIN_PULL_UP>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		cam_port_b_clk_active: cam-port-b-clk-active {
 			samsung,pins = "gpm2-2";
-			samsung,pin-function = <3>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <3>;
+			samsung,pin-function = <PIN_FUNC_SPC_3>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV4>;
 		};
 
 		cam_port_b_clk_idle: cam-port-b-clk-idle {
 			samsung,pins = "gpm2-2";
-			samsung,pin-function = <0>;
-			samsung,pin-pud = <1>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_INPUT>;
+			samsung,pin-pud = <PIN_PULL_DOWN>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		eint0: ext-int0 {
 			samsung,pins = "gpx0-0";
-			samsung,pin-function = <0xf>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_F>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		eint8: ext-int8 {
 			samsung,pins = "gpx1-0";
-			samsung,pin-function = <0xf>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_F>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		eint15: ext-int15 {
 			samsung,pins = "gpx1-7";
-			samsung,pin-function = <0xf>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_F>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		eint16: ext-int16 {
 			samsung,pins = "gpx2-0";
-			samsung,pin-function = <0xf>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_F>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		eint31: ext-int31 {
 			samsung,pins = "gpx3-7";
-			samsung,pin-function = <0xf>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_F>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		fimc_is_i2c0: fimc-is-i2c0 {
 			samsung,pins = "gpm4-0", "gpm4-1";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		fimc_is_i2c1: fimc-is-i2c1 {
 			samsung,pins = "gpm4-2", "gpm4-3";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		fimc_is_uart: fimc-is-uart {
 			samsung,pins = "gpm3-5", "gpm3-7";
-			samsung,pin-function = <3>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_3>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		hdmi_cec: hdmi-cec {
 			samsung,pins = "gpx3-6";
-			samsung,pin-function = <3>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_3>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 	};
 
@@ -919,17 +919,17 @@
 		i2s0_bus: i2s0-bus {
 			samsung,pins = "gpz-0", "gpz-1", "gpz-2", "gpz-3",
 					"gpz-4", "gpz-5", "gpz-6";
-			samsung,pin-function = <0x2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 
 		pcm0_bus: pcm0-bus {
 			samsung,pins = "gpz-0", "gpz-1", "gpz-2", "gpz-3",
 					"gpz-4";
-			samsung,pin-function = <0x3>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_3>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 	};
 
@@ -984,9 +984,9 @@
 					"gpv3-0", "gpv3-1", "gpv3-2", "gpv3-3",
 					"gpv3-4", "gpv3-5", "gpv3-6", "gpv3-7",
 					"gpv4-0", "gpv4-1";
-			samsung,pin-function = <0x2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <PIN_FUNC_SPC_2>;
+			samsung,pin-pud = <PIN_PULL_NONE>;
+			samsung,pin-drv = <PIN_DRV_LV1>;
 		};
 	};
 };
-- 
1.9.1
