From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  5 Oct 2017 12:49:43 +0200
Subject: [PATCH 08/20] ARM: dts: sun4i: Change LRADC node names to avoid
 warnings
In-Reply-To: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <14fb41e6a5648f99643629b1dc9df9ef04c01fbd.1507198895.git-series.maxime.ripard@free-electrons.com>
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
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts  |  6 +++---
 arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts |  4 ++--
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts         |  6 +++---
 arch/arm/boot/dts/sun4i-a10-inet1.dts            |  6 +++---
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts        | 10 +++++-----
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts     | 10 +++++-----
 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts |  4 ++--
 7 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts b/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
index 4978e46ca620..b2dbdac19c0f 100644
--- a/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
+++ b/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
@@ -98,21 +98,21 @@
 	vref-supply = <&reg_vcc3v0>;
 	status = "okay";
 
-	button at 800 {
+	button-800 {
 		label = "Volume Up";
 		linux,code = <KEY_VOLUMEUP>;
 		channel = <0>;
 		voltage = <800000>;
 	};
 
-	button at 1000 {
+	button-1000 {
 		label = "Volume Down";
 		linux,code = <KEY_VOLUMEDOWN>;
 		channel = <0>;
 		voltage = <1000000>;
 	};
 
-	button at 1200 {
+	button-1200 {
 		label = "Back";
 		linux,code = <KEY_BACK>;
 		channel = <0>;
diff --git a/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts b/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
index 92e5a772a93f..96b595d4c064 100644
--- a/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
+++ b/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
@@ -140,14 +140,14 @@
 	vref-supply = <&reg_ldo2>;
 	status = "okay";
 
-	button at 400 {
+	button-400 {
 		label = "Volume Down";
 		linux,code = <KEY_VOLUMEDOWN>;
 		channel = <0>;
 		voltage = <400000>;
 	};
 
-	button at 800 {
+	button-800 {
 		label = "Volume Up";
 		linux,code = <KEY_VOLUMEUP>;
 		channel = <0>;
diff --git a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
index e92074c6d894..4d85262f6292 100644
--- a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
@@ -118,21 +118,21 @@
 
 	status = "okay";
 
-	button at 158 {
+	button-158 {
 		label = "Volume Down";
 		linux,code = <KEY_VOLUMEDOWN>;
 		channel = <0>;
 		voltage = <158730>;
 	};
 
-	button at 349 {
+	button-349 {
 		label = "Volume Up";
 		linux,code = <KEY_VOLUMEUP>;
 		channel = <0>;
 		voltage = <349206>;
 	};
 
-	button at 1142 {
+	button-1142 {
 		label = "Esc";
 		linux,code = <KEY_ESC>;
 		channel = <0>;
diff --git a/arch/arm/boot/dts/sun4i-a10-inet1.dts b/arch/arm/boot/dts/sun4i-a10-inet1.dts
index 016ec3e1889f..d96e149e7909 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet1.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet1.dts
@@ -131,21 +131,21 @@
 	vref-supply = <&reg_ldo2>;
 	status = "okay";
 
-	button at 200 {
+	button-200 {
 		label = "Volume Up";
 		linux,code = <KEY_VOLUMEUP>;
 		channel = <0>;
 		voltage = <200000>;
 	};
 
-	button at 1000 {
+	button-1000 {
 		label = "Volume Down";
 		linux,code = <KEY_VOLUMEDOWN>;
 		channel = <0>;
 		voltage = <1000000>;
 	};
 
-	button at 1200 {
+	button-1200 {
 		label = "Home";
 		linux,code = <KEY_HOMEPAGE>;
 		channel = <0>;
diff --git a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
index 8250c720883e..c76f2538e3a2 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
@@ -103,35 +103,35 @@
 	vref-supply = <&reg_ldo2>;
 	status = "okay";
 
-	button at 200 {
+	button-200 {
 		label = "Menu";
 		linux,code = <KEY_MENU>;
 		channel = <0>;
 		voltage = <200000>;
 	};
 
-	button at 600 {
+	button-600 {
 		label = "Volume Up";
 		linux,code = <KEY_VOLUMEUP>;
 		channel = <0>;
 		voltage = <600000>;
 	};
 
-	button at 800 {
+	button-800 {
 		label = "Volume Down";
 		linux,code = <KEY_VOLUMEDOWN>;
 		channel = <0>;
 		voltage = <800000>;
 	};
 
-	button at 1000 {
+	button-1000 {
 		label = "Home";
 		linux,code = <KEY_HOMEPAGE>;
 		channel = <0>;
 		voltage = <1000000>;
 	};
 
-	button at 1200 {
+	button-1200 {
 		label = "Esc";
 		linux,code = <KEY_ESC>;
 		channel = <0>;
diff --git a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
index 98e13cba1714..1ed0d56dd2b4 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
@@ -261,35 +261,35 @@
 	vref-supply = <&reg_ldo2>;
 	status = "okay";
 
-	button at 200 {
+	button-200 {
 		label = "Menu";
 		linux,code = <KEY_MENU>;
 		channel = <0>;
 		voltage = <200000>;
 	};
 
-	button at 600 {
+	button-600 {
 		label = "Volume Up";
 		linux,code = <KEY_VOLUMEUP>;
 		channel = <0>;
 		voltage = <600000>;
 	};
 
-	button at 800 {
+	button-800 {
 		label = "Volume Down";
 		linux,code = <KEY_VOLUMEDOWN>;
 		channel = <0>;
 		voltage = <800000>;
 	};
 
-	button at 1000 {
+	button-1000 {
 		label = "Home";
 		linux,code = <KEY_HOMEPAGE>;
 		channel = <0>;
 		voltage = <1000000>;
 	};
 
-	button at 1200 {
+	button-1200 {
 		label = "Esc";
 		linux,code = <KEY_ESC>;
 		channel = <0>;
diff --git a/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts b/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
index 654a2de3414b..96d100828ab4 100644
--- a/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
@@ -126,14 +126,14 @@
 	vref-supply = <&reg_ldo2>;
 	status = "okay";
 
-	button at 400 {
+	button-400 {
 		label = "Volume Up";
 		linux,code = <KEY_VOLUMEUP>;
 		channel = <0>;
 		voltage = <400000>;
 	};
 
-	button at 800 {
+	button-800 {
 		label = "Volume Down";
 		linux,code = <KEY_VOLUMEDOWN>;
 		channel = <0>;
-- 
git-series 0.9.1
