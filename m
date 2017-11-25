From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 25 Nov 2017 14:34:05 +0100
Subject: [PATCH] ARM: dts: bcm283x: Use GPIO polarity defines consequently
Message-ID: <1511616845-16298-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently most of the Raspberry Pi DTS have a mixture of magic
numbers and the proper GPIO polarity defines. So use the latter
one consequently.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts | 4 ++--
 arch/arm/boot/dts/bcm2835-rpi-a.dts      | 2 +-
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts | 4 ++--
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts | 2 +-
 arch/arm/boot/dts/bcm2835-rpi-b.dts      | 2 +-
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts    | 4 ++--
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts    | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
index f81ae0a..aa1fc7b 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
@@ -10,12 +10,12 @@
 
 	leds {
 		act {
-			gpios = <&gpio 47 0>;
+			gpios = <&gpio 47 GPIO_ACTIVE_HIGH>;
 		};
 
 		pwr {
 			label = "PWR";
-			gpios = <&gpio 35 0>;
+			gpios = <&gpio 35 GPIO_ACTIVE_HIGH>;
 			default-state = "keep";
 			linux,default-trigger = "default-on";
 		};
diff --git a/arch/arm/boot/dts/bcm2835-rpi-a.dts b/arch/arm/boot/dts/bcm2835-rpi-a.dts
index 7a960a0..425f6b0 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a.dts
@@ -10,7 +10,7 @@
 
 	leds {
 		act {
-			gpios = <&gpio 16 1>;
+			gpios = <&gpio 16 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
index 0161a84..effa195 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
@@ -11,12 +11,12 @@
 
 	leds {
 		act {
-			gpios = <&gpio 47 0>;
+			gpios = <&gpio 47 GPIO_ACTIVE_HIGH>;
 		};
 
 		pwr {
 			label = "PWR";
-			gpios = <&gpio 35 0>;
+			gpios = <&gpio 35 GPIO_ACTIVE_HIGH>;
 			default-state = "keep";
 			linux,default-trigger = "default-on";
 		};
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
index 4bc70ef..772ec3b 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
@@ -11,7 +11,7 @@
 
 	leds {
 		act {
-			gpios = <&gpio 16 1>;
+			gpios = <&gpio 16 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/bcm2835-rpi-b.dts
index cca4a75..434483d 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -11,7 +11,7 @@
 
 	leds {
 		act {
-			gpios = <&gpio 16 1>;
+			gpios = <&gpio 16 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
index 6669355..5c339ad 100644
--- a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
+++ b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
@@ -15,12 +15,12 @@
 
 	leds {
 		act {
-			gpios = <&gpio 47 0>;
+			gpios = <&gpio 47 GPIO_ACTIVE_HIGH>;
 		};
 
 		pwr {
 			label = "PWR";
-			gpios = <&gpio 35 0>;
+			gpios = <&gpio 35 GPIO_ACTIVE_HIGH>;
 			default-state = "keep";
 			linux,default-trigger = "default-on";
 		};
diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
index a8844d0..3e4ed7c 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
@@ -20,7 +20,7 @@
 
 	leds {
 		act {
-			gpios = <&gpio 47 0>;
+			gpios = <&gpio 47 GPIO_ACTIVE_HIGH>;
 		};
 	};
 };
-- 
2.7.4
