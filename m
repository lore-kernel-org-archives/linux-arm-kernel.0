From: joonas.kylmala@iki.fi (=?UTF-8?q?Joonas=20Kylm=C3=A4l=C3=A4?=)
Date: Sun, 22 Oct 2017 12:19:57 +0300
Subject: [PATCH 2/2] ARM: dts: sun8i: h3-h5: Move pinctrl of mmc1 from dts to
 dtsi
In-Reply-To: <20171022091957.24614-1-joonas.kylmala@iki.fi>
References: <20171022091957.24614-1-joonas.kylmala@iki.fi>
Message-ID: <20171022091957.24614-3-joonas.kylmala@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the boards use the mmc1 pins and their attributes defined in
mmc1_pins_a. Let's default to that by moving the pinctrl attributes to
the dtsi file. This makes it easier to modify device trees in the
future as there is only one place to change the pinctrl attributes.

Signed-off-by: Joonas Kylm?l? <joonas.kylmala@iki.fi>
---
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 2 --
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts   | 2 --
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts         | 2 --
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts         | 2 --
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts      | 2 --
 arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts   | 2 --
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                | 2 ++
 7 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
index 7e6a93b49ffe..49d18d5bc3e1 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
@@ -111,8 +111,6 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
 	vmmc-supply = <&reg_vcc_wifi>;
 	mmc-pwrseq = <&wifi_pwrseq>;
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
index a6a55c7acbf9..f0023995d14e 100644
--- a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
@@ -126,8 +126,6 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	vqmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&wifi_pwrseq>;
diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
index 37ca09154e56..de9e62bb46df 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -123,8 +123,6 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	non-removable;
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
index c0e99a83105d..e0c353fa4a1c 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
@@ -132,8 +132,6 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&wifi_pwrseq>;
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
index a492947c27ee..00394d263d5a 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
@@ -114,8 +114,6 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	non-removable;
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts
index 8b93f5c781a7..babf4cf1b2f6 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts
@@ -54,8 +54,6 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	non-removable;
diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 56e7975242c8..eee49a2615b3 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -116,6 +116,8 @@
 		mmc1: mmc at 1c10000 {
 			/* compatible and clocks are in per SoC .dtsi file */
 			reg = <0x01c10000 0x1000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc1_pins_a>;
 			resets = <&ccu RST_BUS_MMC1>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.11.0
