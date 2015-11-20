From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 19 Nov 2015 17:05:12 -0800
Subject: [PATCH 05/29] ARM: dts: shmobile/r8a7xxx: replace gpio-key,
 wakeup with wakeup-source property
In-Reply-To: <cover.1447981420.git.horms+renesas@verge.net.au>
References: <cover.1447981420.git.horms+renesas@verge.net.au>
Message-ID: <0cc16889e77a95568806b1e45af104f75547eac9.1447981420.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep Holla <Sudeep.Holla@arm.com>

Though the keyboard driver for GPIO buttons(gpio-keys) will continue to
check for/support the legacy "gpio-key,wakeup" boolean property to
enable gpio buttons as wakeup source, "wakeup-source" is the new
standard binding.

This patch replaces the legacy "gpio-key,wakeup" with the unified
"wakeup-source" property in order to avoid any futher copy-paste
duplication.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts         |  2 +-
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts |  2 +-
 arch/arm/boot/dts/r8a7790-lager.dts           |  8 ++++----
 arch/arm/boot/dts/r8a7791-koelsch.dts         | 22 +++++++++++-----------
 arch/arm/boot/dts/sh73a0-kzm9g.dts            |  2 +-
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index a4c425923c05..9b7eabd3eba3 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -110,7 +110,7 @@
 			gpios = <&pfc 324 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_0>;
 			label = "S16";
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		menu-key {
diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index 105d9c95de4a..78a21f2828df 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -85,7 +85,7 @@
 			gpios = <&pfc 99 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			label = "SW3";
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		back-key {
diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index c553abd711ee..e2174d816e78 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -77,28 +77,28 @@
 		button at 1 {
 			linux,code = <KEY_1>;
 			label = "SW2-1";
-			gpio-key,wakeup;
+			wakeup-source;
 			debounce-interval = <20>;
 			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
 		};
 		button at 2 {
 			linux,code = <KEY_2>;
 			label = "SW2-2";
-			gpio-key,wakeup;
+			wakeup-source;
 			debounce-interval = <20>;
 			gpios = <&gpio1 24 GPIO_ACTIVE_LOW>;
 		};
 		button at 3 {
 			linux,code = <KEY_3>;
 			label = "SW2-3";
-			gpio-key,wakeup;
+			wakeup-source;
 			debounce-interval = <20>;
 			gpios = <&gpio1 26 GPIO_ACTIVE_LOW>;
 		};
 		button at 4 {
 			linux,code = <KEY_4>;
 			label = "SW2-4";
-			gpio-key,wakeup;
+			wakeup-source;
 			debounce-interval = <20>;
 			gpios = <&gpio1 28 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index fc44ea361a4b..98da99d1b7dc 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -79,77 +79,77 @@
 			gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_1>;
 			label = "SW2-1";
-			gpio-key,wakeup;
+			wakeup-source;
 			debounce-interval = <20>;
 		};
 		key-2 {
 			gpios = <&gpio5 1 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_2>;
 			label = "SW2-2";
-			gpio-key,wakeup;
+			wakeup-source;
 			debounce-interval = <20>;
 		};
 		key-3 {
 			gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_3>;
 			label = "SW2-3";
-			gpio-key,wakeup;
+			wakeup-source;
 			debounce-interval = <20>;
 		};
 		key-4 {
 			gpios = <&gpio5 3 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_4>;
 			label = "SW2-4";
-			gpio-key,wakeup;
+			wakeup-source;
 			debounce-interval = <20>;
 		};
 		key-a {
 			gpios = <&gpio7 0 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_A>;
 			label = "SW30";
-			gpio-key,wakeup;
+			wakeup-source;
 			debounce-interval = <20>;
 		};
 		key-b {
 			gpios = <&gpio7 1 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_B>;
 			label = "SW31";
-			gpio-key,wakeup;
+			wakeup-source;
 			debounce-interval = <20>;
 		};
 		key-c {
 			gpios = <&gpio7 2 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_C>;
 			label = "SW32";
-			gpio-key,wakeup;
+			wakeup-source;
 			debounce-interval = <20>;
 		};
 		key-d {
 			gpios = <&gpio7 3 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_D>;
 			label = "SW33";
-			gpio-key,wakeup;
+			wakeup-source;
 			debounce-interval = <20>;
 		};
 		key-e {
 			gpios = <&gpio7 4 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_E>;
 			label = "SW34";
-			gpio-key,wakeup;
+			wakeup-source;
 			debounce-interval = <20>;
 		};
 		key-f {
 			gpios = <&gpio7 5 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_F>;
 			label = "SW35";
-			gpio-key,wakeup;
+			wakeup-source;
 			debounce-interval = <20>;
 		};
 		key-g {
 			gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_G>;
 			label = "SW36";
-			gpio-key,wakeup;
+			wakeup-source;
 			debounce-interval = <20>;
 		};
 	};
diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts b/arch/arm/boot/dts/sh73a0-kzm9g.dts
index 7fc5602810ad..aa8bae3b8fcf 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
@@ -147,7 +147,7 @@
 			gpios = <&pcf8575 14 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_HOME>;
 			label = "SW1";
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
-- 
2.1.4
