From: joonas.kylmala@iki.fi (=?UTF-8?q?Joonas=20Kylm=C3=A4l=C3=A4?=)
Date: Thu,  8 Feb 2018 14:01:40 +0200
Subject: [PATCH v3 3/4] ARM: dts: sunxi: h3-h5: Move pinctrl of mmc1 from dts
 to dtsi
In-Reply-To: <20180208120141.15780-1-joonas.kylmala@iki.fi>
References: <20180208120141.15780-1-joonas.kylmala@iki.fi>
Message-ID: <20180208120141.15780-4-joonas.kylmala@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the boards use the mmc1 pins and their attributes defined in
mmc1_pins_a. Let's default to that by moving the pinctrl attributes to
the dtsi file. This makes it easier to modify device trees in the
future as there is only one place to change the pinctrl attributes.

Signed-off-by: Joonas Kylm?l? <joonas.kylmala@iki.fi>
---
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts            | 2 --
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts              | 2 --
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts                    | 2 --
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts                | 2 --
 arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts                | 2 --
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts                    | 2 --
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts                 | 2 --
 arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts              | 2 --
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                           | 2 ++
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts | 2 --
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts   | 2 --
 11 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
index f3b066ff63cb..73978853bb4c 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
@@ -119,8 +119,6 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
 	vmmc-supply = <&reg_vcc_wifi>;
 	mmc-pwrseq = <&wifi_pwrseq>;
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
index bea49ed89cc7..9c1bc472fb1c 100644
--- a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
@@ -143,8 +143,6 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	vqmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&wifi_pwrseq>;
diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
index 9fc07593e907..870aabcbb2d8 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -122,8 +122,6 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	non-removable;
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
index a6e61915d648..07b51a2f14c6 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
@@ -101,8 +101,6 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	vqmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&wifi_pwrseq>;
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
index 07e2e6180792..6246d3eff39d 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
@@ -87,8 +87,6 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	vqmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&wifi_pwrseq>;
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
index ac6f52f3fa62..7569bd05e249 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
@@ -139,8 +139,6 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&wifi_pwrseq>;
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
index 82ab5b6b730b..2e59fd296717 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
@@ -113,8 +113,6 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	non-removable;
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts
index a10281b455f5..71fb73208939 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts
@@ -59,8 +59,6 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	non-removable;
diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 3a0854a96a04..b4a4b3cb6c4e 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -154,6 +154,8 @@
 		mmc1: mmc at 1c10000 {
 			/* compatible and clocks are in per SoC .dtsi file */
 			reg = <0x01c10000 0x1000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc1_pins_a>;
 			resets = <&ccu RST_BUS_MMC1>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
index 2189cfd85ea5..3191f861acc3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
@@ -141,8 +141,6 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	vqmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&wifi_pwrseq>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
index 586ec67f4101..803566608ed8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
@@ -174,8 +174,6 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&wifi_pwrseq>;
 	bus-width = <4>;
-- 
2.11.0
