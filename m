From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:42 +0100
Subject: [PATCH 41/77] ARM: dts: sun7i: Change LRADC node names to avoid
 warnings
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <5132bc3d58d17790ef7b779fd0b9d1672ccf2996.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the usage of the LRADC is to implement buttons. The bindings define
that we should have one subnode per button, with their associated voltage
as a property.

However, there was no reg property but we still used the voltage associated
to the button as the unit-address, which eventually generated warnings in
DTC.

Rename the node names to avoid those warnings.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts  | 14 +++++++-------
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 14 +++++++-------
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts  |  4 ++--
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
index 892b84bbf357..2aa719338dac 100644
--- a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
@@ -158,49 +158,49 @@
 	vref-supply = <&reg_vcc3v0>;
 	status = "okay";
 
-	button at 190 {
+	button-190 {
 		label = "Volume Up";
 		linux,code = <KEY_VOLUMEUP>;
 		channel = <0>;
 		voltage = <190000>;
 	};
 
-	button at 390 {
+	button-390 {
 		label = "Volume Down";
 		linux,code = <KEY_VOLUMEDOWN>;
 		channel = <0>;
 		voltage = <390000>;
 	};
 
-	button at 600 {
+	button-600 {
 		label = "Menu";
 		linux,code = <KEY_MENU>;
 		channel = <0>;
 		voltage = <600000>;
 	};
 
-	button at 800 {
+	button-800 {
 		label = "Search";
 		linux,code = <KEY_SEARCH>;
 		channel = <0>;
 		voltage = <800000>;
 	};
 
-	button at 980 {
+	button-980 {
 		label = "Home";
 		linux,code = <KEY_HOMEPAGE>;
 		channel = <0>;
 		voltage = <980000>;
 	};
 
-	button at 1180 {
+	button-1180 {
 		label = "Esc";
 		linux,code = <KEY_ESC>;
 		channel = <0>;
 		voltage = <1180000>;
 	};
 
-	button at 1400 {
+	button-1400 {
 		label = "Enter";
 		linux,code = <KEY_ENTER>;
 		channel = <0>;
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 50e7229727a6..f78f18fd7c1c 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -171,49 +171,49 @@
 	vref-supply = <&reg_vcc3v0>;
 	status = "okay";
 
-	button at 191 {
+	button-191 {
 		label = "Volume Up";
 		linux,code = <KEY_VOLUMEUP>;
 		channel = <0>;
 		voltage = <191274>;
 	};
 
-	button at 392 {
+	button-392 {
 		label = "Volume Down";
 		linux,code = <KEY_VOLUMEDOWN>;
 		channel = <0>;
 		voltage = <392644>;
 	};
 
-	button at 601 {
+	button-601 {
 		label = "Menu";
 		linux,code = <KEY_MENU>;
 		channel = <0>;
 		voltage = <601151>;
 	};
 
-	button at 795 {
+	button-795 {
 		label = "Search";
 		linux,code = <KEY_SEARCH>;
 		channel = <0>;
 		voltage = <795090>;
 	};
 
-	button at 987 {
+	button-987 {
 		label = "Home";
 		linux,code = <KEY_HOMEPAGE>;
 		channel = <0>;
 		voltage = <987387>;
 	};
 
-	button at 1184 {
+	button-1184 {
 		label = "Esc";
 		linux,code = <KEY_ESC>;
 		channel = <0>;
 		voltage = <1184678>;
 	};
 
-	button at 1398 {
+	button-1398 {
 		label = "Enter";
 		linux,code = <KEY_ENTER>;
 		channel = <0>;
diff --git a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
index b526890a3203..8fd85c6597bf 100644
--- a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
+++ b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
@@ -128,14 +128,14 @@
 	vref-supply = <&reg_vcc3v0>;
 	status = "okay";
 
-	button at 571 {
+	button-571 {
 		label = "Volume Up";
 		linux,code = <KEY_VOLUMEUP>;
 		channel = <0>;
 		voltage = <571428>;
 	};
 
-	button at 761 {
+	button-761 {
 		label = "Volume Down";
 		linux,code = <KEY_VOLUMEDOWN>;
 		channel = <0>;
-- 
git-series 0.9.1
