From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:10 +0100
Subject: [PATCH 09/77] ARM: dts: sun5i: Change LRADC node names to avoid
 warnings
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <8fa5b2c6c2eb9105ea8e388f2f952ecffbdf1f02.1543321707.git-series.maxime.ripard@bootlin.com>
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
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts       | 10 ++++----
 arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts |  4 +--
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts               |  4 +--
 arch/arm/boot/dts/sun5i-a13-licheepi-one.dts           |  2 +-
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts              | 10 ++++----
 arch/arm/boot/dts/sun5i-gr8-evb.dts                    | 14 +++++------
 6 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index 2c902ed2c87a..243319e98cf7 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -152,35 +152,35 @@
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
 		label = "Enter";
 		linux,code = <KEY_ENTER>;
 		channel = <0>;
 		voltage = <795090>;
 	};
 
-	button at 987 {
+	button-987 {
 		label = "Home";
 		linux,code = <KEY_HOMEPAGE>;
 		channel = <0>;
diff --git a/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts b/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
index 378214d8316e..30a86cadf5a5 100644
--- a/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
+++ b/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
@@ -105,14 +105,14 @@
 	vref-supply = <&reg_ldo2>;
 	status = "okay";
 
-	button at 200 {
+	button-200 {
 		label = "Volume Up";
 		linux,code = <KEY_VOLUMEUP>;
 		channel = <0>;
 		voltage = <200000>;
 	};
 
-	button at 400 {
+	button-400 {
 		label = "Volume Down";
 		linux,code = <KEY_VOLUMEDOWN>;
 		channel = <0>;
diff --git a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
index 7ee0c3f6d7a1..24ac6f167426 100644
--- a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
+++ b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
@@ -100,14 +100,14 @@
 	vref-supply = <&reg_ldo2>;
 	status = "okay";
 
-	button at 200 {
+	button-200 {
 		label = "Volume Up";
 		linux,code = <KEY_VOLUMEUP>;
 		channel = <0>;
 		voltage = <200000>;
 	};
 
-	button at 400 {
+	button-400 {
 		label = "Volume Down";
 		linux,code = <KEY_VOLUMEDOWN>;
 		channel = <0>;
diff --git a/arch/arm/boot/dts/sun5i-a13-licheepi-one.dts b/arch/arm/boot/dts/sun5i-a13-licheepi-one.dts
index bc883893f4a4..93a080e7ba2d 100644
--- a/arch/arm/boot/dts/sun5i-a13-licheepi-one.dts
+++ b/arch/arm/boot/dts/sun5i-a13-licheepi-one.dts
@@ -124,7 +124,7 @@
 	vref-supply = <&reg_ldo2>;
 	status = "okay";
 
-	button at 984 {
+	button-984 {
 		label = "Home";
 		linux,code = <KEY_HOMEPAGE>;
 		channel = <0>;
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index 437ad913a373..49dcef1090d2 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -153,35 +153,35 @@
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
 		label = "Enter";
 		linux,code = <KEY_ENTER>;
 		channel = <0>;
 		voltage = <795090>;
 	};
 
-	button at 987 {
+	button-987 {
 		label = "Home";
 		linux,code = <KEY_HOMEPAGE>;
 		channel = <0>;
diff --git a/arch/arm/boot/dts/sun5i-gr8-evb.dts b/arch/arm/boot/dts/sun5i-gr8-evb.dts
index 5f0adc0f7bb4..e914915e73d7 100644
--- a/arch/arm/boot/dts/sun5i-gr8-evb.dts
+++ b/arch/arm/boot/dts/sun5i-gr8-evb.dts
@@ -181,49 +181,49 @@
 	vref-supply = <&reg_ldo2>;
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
-- 
git-series 0.9.1
