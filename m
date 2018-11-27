From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:08 +0100
Subject: [PATCH 07/77] ARM: dts: sun5i: Remove SoC node unit-name to avoid
 warnings
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <003a6d6316bb1f6238556674ed162fd0b7e57456.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our main node for all the in-SoC controllers used to have a unit name. The
unit-name, in addition to being actually false, would not match any reg
property, which generates a warning.

Remove it in order to remove those warnings.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 2 +-
 arch/arm/boot/dts/sun5i-a13.dtsi  | 2 +-
 arch/arm/boot/dts/sun5i-gr8.dtsi  | 2 +-
 arch/arm/boot/dts/sun5i.dtsi      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 0c0c5e08520f..a2d0ceacf00e 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -74,7 +74,7 @@
 		allwinner,pipelines = <&fe0>;
 	};
 
-	soc at 1c00000 {
+	soc {
 		hdmi: hdmi at 1c16000 {
 			compatible = "allwinner,sun5i-a10s-hdmi";
 			reg = <0x01c16000 0x1000>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index a75ca4504a75..ee99f6f23f17 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -86,7 +86,7 @@
 		allwinner,pipelines = <&fe0>;
 	};
 
-	soc at 1c00000 {
+	soc {
 		pwm: pwm at 1c20e00 {
 			compatible = "allwinner,sun5i-a13-pwm";
 			reg = <0x01c20e00 0xc>;
diff --git a/arch/arm/boot/dts/sun5i-gr8.dtsi b/arch/arm/boot/dts/sun5i-gr8.dtsi
index ef0b7446a99d..d3eea4cfe442 100644
--- a/arch/arm/boot/dts/sun5i-gr8.dtsi
+++ b/arch/arm/boot/dts/sun5i-gr8.dtsi
@@ -54,7 +54,7 @@
 		allwinner,pipelines = <&fe0>;
 	};
 
-	soc at 1c00000 {
+	soc {
 		pwm: pwm at 1c20e00 {
 			compatible = "allwinner,sun5i-a10s-pwm";
 			reg = <0x01c20e00 0xc>;
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 07b60462356e..4ea6e1867186 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -123,7 +123,7 @@
 		};
 	};
 
-	soc at 1c00000 {
+	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
git-series 0.9.1
