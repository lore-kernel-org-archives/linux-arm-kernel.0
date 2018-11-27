From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:46:01 +0100
Subject: [PATCH 60/77] ARM: dts: sun8i: a23/a33: Change LRADC node names to
 avoid warnings
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <77b7fe2fc4bcee6d7156171421cd6e1dc56a3fe8.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the usage of the LRADC is to implement buttons. The bindings define
that we should have one subnode per button, with their associated voltage
as a property.

However, there was no reg property but we still used the voltage associated
to the button as the unit-address, which eventually generated warnings in
DTC.

Rename the node names to avoid those warnings.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a23-evb.dts            | 6 +++---
 arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts       | 2 +-
 arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts     | 2 +-
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts | 6 +++---
 arch/arm/boot/dts/sun8i-r16-parrot.dts         | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a23-evb.dts b/arch/arm/boot/dts/sun8i-a23-evb.dts
index 8a93697df3a5..b6aeb23b6ee9 100644
--- a/arch/arm/boot/dts/sun8i-a23-evb.dts
+++ b/arch/arm/boot/dts/sun8i-a23-evb.dts
@@ -80,21 +80,21 @@
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
 		label = "Home";
 		linux,code = <KEY_HOME>;
 		channel = <0>;
diff --git a/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts b/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
index e3c7a25ca37d..bcbc9b0758f9 100644
--- a/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
+++ b/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
@@ -63,7 +63,7 @@
 };
 
 &lradc {
-	button at 600 {
+	button-600 {
 		label = "Back";
 		linux,code = <KEY_BACK>;
 		channel = <0>;
diff --git a/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts b/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts
index f71159987cac..9ead5e1b7b65 100644
--- a/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts
+++ b/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts
@@ -69,7 +69,7 @@
 };
 
 &lradc {
-	button at 600 {
+	button-600 {
 		label = "Back";
 		linux,code = <KEY_BACK>;
 		channel = <0>;
diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
index 7e006d0fbf27..a2b8948393fc 100644
--- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
+++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
@@ -110,21 +110,21 @@
 	vref-supply = <&reg_dcdc1>;
 	status = "okay";
 
-	button at 200 {
+	button-200 {
 		label = "Volume Up";
 		linux,code = <KEY_VOLUMEUP>;
 		channel = <0>;
 		voltage = <191011>;
 	};
 
-	button at 400 {
+	button-400 {
 		label = "Volume Down";
 		linux,code = <KEY_VOLUMEDOWN>;
 		channel = <0>;
 		voltage = <391304>;
 	};
 
-	button at 600 {
+	button-600 {
 		label = "Home";
 		linux,code = <KEY_HOME>;
 		channel = <0>;
diff --git a/arch/arm/boot/dts/sun8i-r16-parrot.dts b/arch/arm/boot/dts/sun8i-r16-parrot.dts
index 16b38bd7a779..ffb3a5b6b043 100644
--- a/arch/arm/boot/dts/sun8i-r16-parrot.dts
+++ b/arch/arm/boot/dts/sun8i-r16-parrot.dts
@@ -109,14 +109,14 @@
 	vref-supply = <&reg_aldo3>;
 	status = "okay";
 
-	button at 0 {
+	button-190 {
 		label = "V+";
 		linux,code = <KEY_VOLUMEUP>;
 		channel = <0>;
 		voltage = <190000>;
 	};
 
-	button at 1 {
+	button-390 {
 		label = "V-";
 		linux,code = <KEY_VOLUMEDOWN>;
 		channel = <0>;
-- 
git-series 0.9.1
