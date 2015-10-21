From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 21 Oct 2015 11:10:11 +0100
Subject: [PATCH 14/19] ARM: dts: shmobile/r8a7xxx: replace gpio-key,
 wakeup with wakeup-source property
In-Reply-To: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1445422216-29375-15-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Though the keyboard driver for GPIO buttons(gpio-keys) will continue to
check for/support the legacy "gpio-key,wakeup" boolean property to
enable gpio buttons as wakeup source, "wakeup-source" is the new
standard binding.

This patch replaces the legacy "gpio-key,wakeup" with the unified
"wakeup-source" property in order to avoid any futher copy-paste
duplication.

Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh at vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
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
index 37dec5269491..8523c3d03de3 100644
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
index dc158845afdc..48cddfc25f72 100644
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
index 24b4cd24dceb..710ea035d0f4 100644
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
1.9.1
