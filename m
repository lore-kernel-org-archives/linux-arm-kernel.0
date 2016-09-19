From: kraxel@redhat.com (Gerd Hoffmann)
Date: Mon, 19 Sep 2016 10:43:23 +0200
Subject: [PATCH v4 7/7] ARM: dts: bcm283x: drop alt3 from &gpio
In-Reply-To: <1474274603-24215-1-git-send-email-kraxel@redhat.com>
References: <1474274603-24215-1-git-send-email-kraxel@redhat.com>
Message-ID: <1474274603-24215-8-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the alt3 group has no pins left drop it from &gpio.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts | 2 +-
 arch/arm/boot/dts/bcm2835-rpi-a.dts      | 2 +-
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts | 2 +-
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts | 2 +-
 arch/arm/boot/dts/bcm2835-rpi-b.dts      | 2 +-
 arch/arm/boot/dts/bcm2835-rpi-zero.dts   | 2 +-
 arch/arm/boot/dts/bcm2835-rpi.dtsi       | 5 -----
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts    | 2 +-
 8 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
index f7f9db3..21507c9 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
@@ -22,7 +22,7 @@
 };
 
 &gpio {
-	pinctrl-0 = <&gpioout &alt0 &i2s_alt0 &alt3>;
+	pinctrl-0 = <&gpioout &alt0 &i2s_alt0>;
 
 	/* I2S interface */
 	i2s_alt0: i2s_alt0 {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-a.dts b/arch/arm/boot/dts/bcm2835-rpi-a.dts
index 8be102f..5afba09 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a.dts
@@ -15,7 +15,7 @@
 };
 
 &gpio {
-	pinctrl-0 = <&gpioout &alt0 &i2s_alt2 &alt3>;
+	pinctrl-0 = <&gpioout &alt0 &i2s_alt2>;
 
 	/* I2S interface */
 	i2s_alt2: i2s_alt2 {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
index 35cde65..38f66aa 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
@@ -23,7 +23,7 @@
 };
 
 &gpio {
-	pinctrl-0 = <&gpioout &alt0 &i2s_alt0 &alt3>;
+	pinctrl-0 = <&gpioout &alt0 &i2s_alt0>;
 
 	/* I2S interface */
 	i2s_alt0: i2s_alt0 {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
index 84df85e..75e045a 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
@@ -16,7 +16,7 @@
 };
 
 &gpio {
-	pinctrl-0 = <&gpioout &alt0 &i2s_alt2 &alt3>;
+	pinctrl-0 = <&gpioout &alt0 &i2s_alt2>;
 
 	/* I2S interface */
 	i2s_alt2: i2s_alt2 {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/bcm2835-rpi-b.dts
index 8e626a8..76a254b 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -16,7 +16,7 @@
 };
 
 &gpio {
-	pinctrl-0 = <&gpioout &alt0 &alt3>;
+	pinctrl-0 = <&gpioout &alt0>;
 };
 
 &hdmi {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero.dts b/arch/arm/boot/dts/bcm2835-rpi-zero.dts
index 60e359f..7c1c180 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-zero.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-zero.dts
@@ -26,7 +26,7 @@
 };
 
 &gpio {
-	pinctrl-0 = <&gpioout &alt0 &i2s_alt0 &alt3>;
+	pinctrl-0 = <&gpioout &alt0 &i2s_alt0>;
 
 	/* I2S interface */
 	i2s_alt0: i2s_alt0 {
diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 3f0ce61..a46fa41 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -41,11 +41,6 @@
 		brcm,pins = <4 5 7 8 9 10 11>;
 		brcm,function = <BCM2835_FSEL_ALT0>;
 	};
-
-	alt3: alt3 {
-		brcm,pins = <>;
-		brcm,function = <BCM2835_FSEL_ALT3>;
-	};
 };
 
 &i2c0 {
diff --git a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
index 39dccf6..bf19e8c 100644
--- a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
+++ b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
@@ -27,7 +27,7 @@
 };
 
 &gpio {
-	pinctrl-0 = <&gpioout &alt0 &i2s_alt0 &alt3>;
+	pinctrl-0 = <&gpioout &alt0 &i2s_alt0>;
 
 	/* I2S interface */
 	i2s_alt0: i2s_alt0 {
-- 
1.8.3.1
