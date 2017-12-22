From: tuomas@tuxera.com (Tuomas Tynkkynen)
Date: Fri, 22 Dec 2017 22:57:38 +0200
Subject: [PATCH 2/2] arm64: dts: sunxi: Switch MMC nodes away from cd-inverted
 property
In-Reply-To: <20171222205738.2389-1-tuomas@tuxera.com>
References: <20171222205738.2389-1-tuomas@tuxera.com>
Message-ID: <20171222205738.2389-2-tuomas@tuxera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using the cd-inverted property is not useful when GPIOs are used as card
detects since the polarity can be specified with the usual
GPIO_ACTIVE_(HIGH|LOW) GPIO flags. It has also caused confusion for
U-Boot developers, so migrate all sunxi boards away from cd-inverted.

Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>
---
Compile-tested.

 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 3 +--
 arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts   | 3 +--
 arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts    | 3 +--
 arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 3 +--
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts       | 3 +--
 5 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index a6975670cd1c..2250dec9974c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -120,8 +120,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	bus-width = <4>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
index 2beef9e6cb88..e2dce48fa29a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
@@ -82,8 +82,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	bus-width = <4>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index 8807664f363a..3b3081b10ecb 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -68,8 +68,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	bus-width = <4>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index 240d35731d10..bf42690a3361 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -67,8 +67,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 604cdaedac38..3e9e7374e7eb 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -103,8 +103,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	bus-width = <4>;
 	status = "okay";
-- 
2.15.0
