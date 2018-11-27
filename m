From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:28 +0100
Subject: [PATCH 27/77] ARM: dts: sun6i: Change LRADC node names to avoid
 warnings
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <c9ad49aa85447600fcd4d2885692a0b9f59b641e.1543321707.git-series.maxime.ripard@bootlin.com>
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
 arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts | 2 +-
 arch/arm/boot/dts/sun6i-a31s-inet-q972.dts        | 6 +++---
 arch/arm/boot/dts/sun6i-a31s-primo81.dts          | 4 ++--
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts          | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts b/arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts
index 882a4d89fa22..a2ef7846e2c8 100644
--- a/arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts
@@ -53,7 +53,7 @@
 	vref-supply = <&reg_aldo3>;
 	status = "okay";
 
-	button at 1000 {
+	button-1000 {
 		label = "Home";
 		linux,code = <KEY_HOMEPAGE>;
 		channel = <0>;
diff --git a/arch/arm/boot/dts/sun6i-a31s-inet-q972.dts b/arch/arm/boot/dts/sun6i-a31s-inet-q972.dts
index e584e6b186a7..85dab04be261 100644
--- a/arch/arm/boot/dts/sun6i-a31s-inet-q972.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-inet-q972.dts
@@ -73,21 +73,21 @@
 	vref-supply = <&reg_aldo3>;
 	status = "okay";
 
-	button at 200 {
+	button-200 {
 		label = "Volume Down";
 		linux,code = <KEY_VOLUMEDOWN>;
 		channel = <0>;
 		voltage = <200000>;
 	};
 
-	button at 900 {
+	button-900 {
 		label = "Volume Up";
 		linux,code = <KEY_VOLUMEUP>;
 		channel = <0>;
 		voltage = <900000>;
 	};
 
-	button at 1200 {
+	button-1200 {
 		label = "Back";
 		linux,code = <KEY_BACK>;
 		channel = <0>;
diff --git a/arch/arm/boot/dts/sun6i-a31s-primo81.dts b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
index 4cb9664cdb29..ca1c711ed450 100644
--- a/arch/arm/boot/dts/sun6i-a31s-primo81.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
@@ -131,14 +131,14 @@
 	vref-supply = <&reg_aldo3>;
 	status = "okay";
 
-	button at 158 {
+	button-158 {
 		label = "Volume Up";
 		linux,code = <KEY_VOLUMEUP>;
 		channel = <0>;
 		voltage = <158730>;
 	};
 
-	button at 349 {
+	button-349 {
 		label = "Volume Down";
 		linux,code = <KEY_VOLUMEDOWN>;
 		channel = <0>;
diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
index da0ccf5a2c44..3a7e68c46ba7 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
@@ -147,14 +147,14 @@
 	vref-supply = <&reg_aldo3>;
 	status = "okay";
 
-	button at 158 {
+	button-158 {
 		label = "Volume Up";
 		linux,code = <KEY_VOLUMEUP>;
 		channel = <0>;
 		voltage = <158730>;
 	};
 
-	button at 349 {
+	button-349 {
 		label = "Volume Down";
 		linux,code = <KEY_VOLUMEDOWN>;
 		channel = <0>;
-- 
git-series 0.9.1
