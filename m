From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Wed,  8 Mar 2017 07:41:05 +0100
Subject: [PATCH 2/2] ARM: dts: BCM5301X: Don't use nonexistent "default-off"
 LED trigger
In-Reply-To: <20170308064105.26619-1-zajec5@gmail.com>
References: <20170308064105.26619-1-zajec5@gmail.com>
Message-ID: <20170308064105.26619-2-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

Such a trigger doesn't exist in Linux and is not needed as LED is being
turned off by default. This could cause errors in LEDs core code when
trying to set default trigger.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts        |  5 -----
 arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts        |  2 --
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  |  5 -----
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts        |  3 ---
 arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts     |  3 ---
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts      | 10 ----------
 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts        |  2 --
 arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts |  4 ----
 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts        |  2 --
 arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts  |  8 --------
 arch/arm/boot/dts/bcm4709-netgear-r7000.dts        |  7 -------
 arch/arm/boot/dts/bcm4709-netgear-r8000.dts        |  9 ---------
 arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts  |  8 --------
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts      |  6 ------
 arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts      |  8 --------
 arch/arm/boot/dts/bcm47094-netgear-r8500.dts       |  6 ------
 16 files changed, 88 deletions(-)

diff --git a/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts b/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts
index 3bf8db4d103f..4175174e589a 100644
--- a/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts
+++ b/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts
@@ -41,19 +41,16 @@
 		usb3 {
 			label = "bcm53xx:blue:usb3";
 			gpios = <&chipcommon 0 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		wan {
 			label = "bcm53xx:blue:wan";
 			gpios = <&chipcommon 1 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		lan {
 			label = "bcm53xx:blue:lan";
 			gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		power {
@@ -71,14 +68,12 @@
 		2ghz {
 			label = "bcm53xx:blue:2ghz";
 			gpios = <&chipcommon 6 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 
 		usb2 {
 			label = "bcm53xx:blue:usb2";
 			gpios = <&chipcommon 14 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts b/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
index 33b0ae6290cb..8fa033fea959 100644
--- a/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
+++ b/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
@@ -41,7 +41,6 @@
 		usb2 {
 			label = "bcm53xx:blue:usb2";
 			gpios = <&chipcommon 0 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		power {
@@ -59,7 +58,6 @@
 		usb3 {
 			label = "bcm53xx:blue:usb3";
 			gpios = <&chipcommon 14 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
index c9ba6b964b38..62e1427b3f10 100644
--- a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
+++ b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
@@ -52,13 +52,11 @@
 		usb {
 			label = "bcm53xx:blue:usb";
 			gpios = <&hc595 0 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		power0 {
 			label = "bcm53xx:red:power";
 			gpios = <&hc595 1 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		power1 {
@@ -76,7 +74,6 @@
 		router1 {
 			label = "bcm53xx:amber:router";
 			gpios = <&hc595 4 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		wan {
@@ -88,13 +85,11 @@
 		wireless0 {
 			label = "bcm53xx:blue:wireless";
 			gpios = <&hc595 6 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		wireless1 {
 			label = "bcm53xx:amber:wireless";
 			gpios = <&hc595 7 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
index b9f66c0fae27..a5647efe4118 100644
--- a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
+++ b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
@@ -43,19 +43,16 @@
 		power1 {
 			label = "bcm53xx:amber:power";
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		usb {
 			label = "bcm53xx:blue:usb";
 			gpios = <&chipcommon 8 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		wireless {
 			label = "bcm53xx:blue:wireless";
 			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
index 5dae6a7ee134..bb66cebe0bd8 100644
--- a/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
+++ b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
@@ -47,7 +47,6 @@
 		power0 {
 			label = "bcm53xx:green:power";
 			gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		power1 {
@@ -59,13 +58,11 @@
 		usb {
 			label = "bcm53xx:blue:usb";
 			gpios = <&chipcommon 8 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		wireless {
 			label = "bcm53xx:blue:wireless";
 			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
index 36b628b190d7..19ee924d7d53 100644
--- a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
+++ b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
@@ -37,61 +37,51 @@
 		power-amber {
 			label = "bcm53xx:amber:power";
 			gpios = <&chipcommon 2 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		usb2 {
 			label = "bcm53xx:white:usb2";
 			gpios = <&chipcommon 3 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		usb3-white {
 			label = "bcm53xx:white:usb3";
 			gpios = <&chipcommon 4 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		usb3-green {
 			label = "bcm53xx:green:usb3";
 			gpios = <&chipcommon 5 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		wps {
 			label = "bcm53xx:white:wps";
 			gpios = <&chipcommon 6 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		status-red {
 			label = "bcm53xx:red:status";
 			gpios = <&chipcommon 8 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		status-green {
 			label = "bcm53xx:green:status";
 			gpios = <&chipcommon 9 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		status-blue {
 			label = "bcm53xx:blue:status";
 			gpios = <&chipcommon 10 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		wan-white {
 			label = "bcm53xx:white:wan";
 			gpios = <&chipcommon 12 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		wan-red {
 			label = "bcm53xx:red:wan";
 			gpios = <&chipcommon 13 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
index 7a95c67d3962..0800a964f2fe 100644
--- a/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
+++ b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
@@ -47,7 +47,6 @@
 		usb2 {
 			label = "bcm53xx:blue:usb2";
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		wan {
@@ -65,7 +64,6 @@
 		usb3 {
 			label = "bcm53xx:blue:usb3";
 			gpios = <&chipcommon 14 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
index a6d15cce0545..c2af33eb47de 100644
--- a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
+++ b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
@@ -68,7 +68,6 @@
 		power1 {
 			label = "bcm53xx:red:power";
 			gpios = <&hc595 2 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		router0 {
@@ -80,7 +79,6 @@
 		router1 {
 			label = "bcm53xx:amber:router";
 			gpios = <&hc595 4 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		wan {
@@ -92,13 +90,11 @@
 		wireless0 {
 			label = "bcm53xx:green:wireless";
 			gpios = <&hc595 6 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		wireless1 {
 			label = "bcm53xx:amber:wireless";
 			gpios = <&hc595 7 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts b/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
index 70421f916f15..df473cc41572 100644
--- a/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
+++ b/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
@@ -41,7 +41,6 @@
 		wps {
 			label = "bcm53xx:blue:wps";
 			gpios = <&chipcommon 1 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		power {
@@ -53,7 +52,6 @@
 		wan {
 			label = "bcm53xx:red:wan";
 			gpios = <&chipcommon 5 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts b/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
index b32957ca9443..92058c73ee59 100644
--- a/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
+++ b/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
@@ -31,13 +31,11 @@
 		usb {
 			label = "bcm53xx:green:usb";
 			gpios = <&chipcommon 4 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		power-amber {
 			label = "bcm53xx:amber:power";
 			gpios = <&chipcommon 5 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		power-white {
@@ -49,37 +47,31 @@
 		router-amber {
 			label = "bcm53xx:amber:router";
 			gpios = <&chipcommon 7 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		router-white {
 			label = "bcm53xx:white:router";
 			gpios = <&chipcommon 8 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		wan-amber {
 			label = "bcm53xx:amber:wan";
 			gpios = <&chipcommon 9 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		wan-white {
 			label = "bcm53xx:white:wan";
 			gpios = <&chipcommon 10 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		wireless-amber {
 			label = "bcm53xx:amber:wireless";
 			gpios = <&chipcommon 11 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		wireless-white {
 			label = "bcm53xx:white:wireless";
 			gpios = <&chipcommon 12 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm4709-netgear-r7000.dts b/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
index 84b3f36b0b25..f43ab4721456 100644
--- a/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
+++ b/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
@@ -47,43 +47,36 @@
 		power-amber {
 			label = "bcm53xx:amber:power";
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		5ghz {
 			label = "bcm53xx:white:5ghz";
 			gpios = <&chipcommon 12 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		2ghz {
 			label = "bcm53xx:white:2ghz";
 			gpios = <&chipcommon 13 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		wps {
 			label = "bcm53xx:white:wps";
 			gpios = <&chipcommon 14 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		wireless {
 			label = "bcm53xx:white:wireless";
 			gpios = <&chipcommon 15 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		usb3 {
 			label = "bcm53xx:white:usb3";
 			gpios = <&chipcommon 17 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		usb2 {
 			label = "bcm53xx:white:usb2";
 			gpios = <&chipcommon 18 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
index 5581c6fc23d5..d266131652ad 100644
--- a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
+++ b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
@@ -47,7 +47,6 @@
 		power-amber {
 			label = "bcm53xx:amber:power";
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		wan-white {
@@ -59,49 +58,41 @@
 		wan-amber {
 			label = "bcm53xx:amber:wan";
 			gpios = <&chipcommon 9 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		5ghz-1 {
 			label = "bcm53xx:white:5ghz-1";
 			gpios = <&chipcommon 12 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		2ghz {
 			label = "bcm53xx:white:2ghz";
 			gpios = <&chipcommon 13 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		wireless {
 			label = "bcm53xx:white:wireless";
 			gpios = <&chipcommon 14 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		wps {
 			label = "bcm53xx:white:wps";
 			gpios = <&chipcommon 15 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		5ghz-2 {
 			label = "bcm53xx:white:5ghz-2";
 			gpios = <&chipcommon 16 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		usb3 {
 			label = "bcm53xx:white:usb3";
 			gpios = <&chipcommon 17 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		usb2 {
 			label = "bcm53xx:white:usb2";
 			gpios = <&chipcommon 18 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts b/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
index c67bfaa0c8e8..97aa5d59a1d8 100644
--- a/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
+++ b/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
@@ -26,49 +26,41 @@
 		lan {
 			label = "bcm53xx:blue:lan";
 			gpios = <&chipcommon 1 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		wps {
 			label = "bcm53xx:blue:wps";
 			gpios = <&chipcommon 2 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		2ghz {
 			label = "bcm53xx:blue:2ghz";
 			gpios = <&chipcommon 4 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		5ghz {
 			label = "bcm53xx:blue:5ghz";
 			gpios = <&chipcommon 5 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		usb3 {
 			label = "bcm53xx:blue:usb3";
 			gpios = <&chipcommon 6 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		usb2 {
 			label = "bcm53xx:blue:usb2";
 			gpios = <&chipcommon 7 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		wan-blue {
 			label = "bcm53xx:blue:wan";
 			gpios = <&chipcommon 14 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		wan-amber {
 			label = "bcm53xx:amber:wan";
 			gpios = <&chipcommon 15 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		power {
diff --git a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
index 5263b3368f1f..51b0641b5f79 100644
--- a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
+++ b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
@@ -56,37 +56,31 @@
 		wan-white {
 			label = "bcm53xx:white:wan";
 			gpios = <&chipcommon 1 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		power-amber {
 			label = "bcm53xx:amber:power";
 			gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		wan-amber {
 			label = "bcm53xx:amber:wan";
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		usb3-white {
 			label = "bcm53xx:white:usb3";
 			gpios = <&chipcommon 8 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		2ghz {
 			label = "bcm53xx:white:2ghz";
 			gpios = <&chipcommon 13 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		5ghz {
 			label = "bcm53xx:white:5ghz";
 			gpios = <&chipcommon 14 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts b/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
index 5cf4ab1ebe85..5f8621d00c50 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
@@ -34,37 +34,31 @@
 		lan3	{
 			label = "bcm53xx:green:lan3";
 			gpios = <&chipcommon 1 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		lan4	{
 			label = "bcm53xx:green:lan4";
 			gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		wan	{
 			label = "bcm53xx:green:wan";
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		lan1	{
 			label = "bcm53xx:green:lan1";
 			gpios = <&chipcommon 4 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		lan2	{
 			label = "bcm53xx:green:lan2";
 			gpios = <&chipcommon 6 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		usb3	{
 			label = "bcm53xx:green:usb3";
 			gpios = <&chipcommon 8 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		status	{
@@ -76,13 +70,11 @@
 		2ghz {
 			label = "bcm53xx:green:2ghz";
 			gpios = <&chipcommon 13 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		5ghz {
 			label = "bcm53xx:green:5ghz";
 			gpios = <&chipcommon 14 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm47094-netgear-r8500.dts b/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
index 600795ee1aed..859929973158 100644
--- a/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
+++ b/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
@@ -34,37 +34,31 @@
 		power1 {
 			label = "bcm53xx:amber:power";
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		5ghz-1 {
 			label = "bcm53xx:white:5ghz-1";
 			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		5ghz-2 {
 			label = "bcm53xx:white:5ghz-2";
 			gpios = <&chipcommon 12 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		2ghz {
 			label = "bcm53xx:white:2ghz";
 			gpios = <&chipcommon 13 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		usb2 {
 			label = "bcm53xx:white:usb2";
 			gpios = <&chipcommon 17 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		usb3 {
 			label = "bcm53xx:white:usb3";
 			gpios = <&chipcommon 18 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 	};
 
-- 
2.11.0
