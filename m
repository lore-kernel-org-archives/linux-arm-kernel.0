From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:53 +0100
Subject: [PATCH 52/77] ARM: dts: sun8i: a23/a33: Remove SoC node unit-name to
 avoid warnings
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <3a0cc04630352b3a666b8e1fefa0bec1b613da45.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our main node for all the in-SoC controllers used to have a unit name. The
unit-name, in addition to being actually false, would not match any reg
property, which generates a warning.

Remove it in order to remove those warnings.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 2 +-
 arch/arm/boot/dts/sun8i-a23.dtsi     | 2 +-
 arch/arm/boot/dts/sun8i-a33.dtsi     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index a198894a33fd..bd8d9e7afcdf 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -118,7 +118,7 @@
 		};
 	};
 
-	soc at 1c00000 {
+	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 7751c43fc806..d00055e9eef5 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -45,7 +45,7 @@
 #include "sun8i-a23-a33.dtsi"
 
 / {
-	soc at 1c00000 {
+	soc {
 		codec: codec at 1c22c00 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun8i-a23-codec";
diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 163c3ff7f670..17d725bd6654 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -223,7 +223,7 @@
 		};
 	};
 
-	soc at 1c00000 {
+	soc {
 		tcon0: lcd-controller at 1c0c000 {
 			compatible = "allwinner,sun8i-a33-tcon";
 			reg = <0x01c0c000 0x1000>;
-- 
git-series 0.9.1
