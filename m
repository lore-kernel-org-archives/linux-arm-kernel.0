From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed,  1 Jun 2016 23:43:21 +0200
Subject: [PATCH 12/32] ARM: bcm2835: Replace alt0/i2s_alt[02] with standard
 groups.
In-Reply-To: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
Message-ID: <1464817421-8519-13-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Anholt <eric@anholt.net>

Since all of these pins were documented, we can use their names to
explain what's going on.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts | 17 ++++++++++-------
 arch/arm/boot/dts/bcm2835-rpi-a.dts      | 17 ++++++++++-------
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts | 17 ++++++++++-------
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts | 17 ++++++++++-------
 arch/arm/boot/dts/bcm2835-rpi-b.dts      | 10 +++++++++-
 arch/arm/boot/dts/bcm2835-rpi.dtsi       |  5 -----
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts    | 17 ++++++++++-------
 7 files changed, 59 insertions(+), 41 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
index 35ff4e7a..e90f870 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
@@ -21,13 +21,16 @@
 };
 
 &gpio {
-	pinctrl-0 = <&gpioout &alt0 &i2s_alt0 &alt3>;
-
-	/* I2S interface */
-	i2s_alt0: i2s_alt0 {
-		brcm,pins = <18 19 20 21>;
-		brcm,function = <BCM2835_FSEL_ALT0>;
-	};
+	pinctrl-0 = <&i2c0_gpio0
+		     &i2c1_gpio2
+		     &gpclk0_gpio4
+		     &gpclk1_gpio5
+		     &spi0_gpio7
+		     &pcm_gpio18
+		     &pwm0_gpio40
+		     &pwm1_gpio45
+		     &gpioout
+		     &alt3>;
 };
 
 &hdmi {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-a.dts b/arch/arm/boot/dts/bcm2835-rpi-a.dts
index 306a84e..2de38c3 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a.dts
@@ -14,13 +14,16 @@
 };
 
 &gpio {
-	pinctrl-0 = <&gpioout &alt0 &i2s_alt2 &alt3>;
-
-	/* I2S interface */
-	i2s_alt2: i2s_alt2 {
-		brcm,pins = <28 29 30 31>;
-		brcm,function = <BCM2835_FSEL_ALT2>;
-	};
+	pinctrl-0 = <&i2c0_gpio0
+		     &i2c1_gpio2
+		     &gpclk0_gpio4
+		     &gpclk1_gpio5
+		     &spi0_gpio7
+		     &pcm_gpio28
+		     &pwm0_gpio40
+		     &pwm1_gpio45
+		     &gpioout
+		     &alt3>;
 };
 
 &hdmi {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
index d5fdb8e..9ad3125 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
@@ -22,13 +22,16 @@
 };
 
 &gpio {
-	pinctrl-0 = <&gpioout &alt0 &i2s_alt0 &alt3>;
-
-	/* I2S interface */
-	i2s_alt0: i2s_alt0 {
-		brcm,pins = <18 19 20 21>;
-		brcm,function = <BCM2835_FSEL_ALT0>;
-	};
+	pinctrl-0 = <&i2c0_gpio0
+		     &i2c1_gpio2
+		     &gpclk0_gpio4
+		     &gpclk1_gpio5
+		     &spi0_gpio7
+		     &pcm_gpio18
+		     &pwm0_gpio40
+		     &pwm1_gpio45
+		     &gpioout
+		     &alt3>;
 };
 
 &hdmi {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
index bfc4bd9..1bec67f 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
@@ -15,13 +15,16 @@
 };
 
 &gpio {
-	pinctrl-0 = <&gpioout &alt0 &i2s_alt2 &alt3>;
-
-	/* I2S interface */
-	i2s_alt2: i2s_alt2 {
-		brcm,pins = <28 29 30 31>;
-		brcm,function = <BCM2835_FSEL_ALT2>;
-	};
+	pinctrl-0 = <&i2c0_gpio0
+		     &i2c1_gpio2
+		     &gpclk0_gpio4
+		     &gpclk1_gpio5
+		     &spi0_gpio7
+		     &pcm_gpio28
+		     &pwm0_gpio40
+		     &pwm1_gpio45
+		     &gpioout
+		     &alt3>;
 };
 
 &hdmi {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/bcm2835-rpi-b.dts
index 0371bb7..0e9f566 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -15,7 +15,15 @@
 };
 
 &gpio {
-	pinctrl-0 = <&gpioout &alt0 &alt3>;
+	pinctrl-0 = <&i2c0_gpio0
+		     &i2c1_gpio2
+		     &gpclk0_gpio4
+		     &gpclk1_gpio5
+		     &spi0_gpio7
+		     &pwm0_gpio40
+		     &pwm1_gpio45
+		     &gpioout
+		     &alt3>;
 };
 
 &hdmi {
diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 88bcd0c..e9ab80a 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -37,11 +37,6 @@
 		brcm,function = <BCM2835_FSEL_GPIO_OUT>;
 	};
 
-	alt0: alt0 {
-		brcm,pins = <0 1 2 3 4 5 7 8 9 10 11 40 45>;
-		brcm,function = <BCM2835_FSEL_ALT0>;
-	};
-
 	alt3: alt3 {
 		brcm,pins = <48 49 50 51 52 53>;
 		brcm,function = <BCM2835_FSEL_ALT3>;
diff --git a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
index 29e1cfe..348e3e1 100644
--- a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
+++ b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
@@ -26,13 +26,16 @@
 };
 
 &gpio {
-	pinctrl-0 = <&gpioout &alt0 &i2s_alt0 &alt3>;
-
-	/* I2S interface */
-	i2s_alt0: i2s_alt0 {
-		brcm,pins = <18 19 20 21>;
-		brcm,function = <BCM2835_FSEL_ALT0>;
-	};
+	pinctrl-0 = <&i2c0_gpio0
+		     &i2c1_gpio2
+		     &gpclk0_gpio4
+		     &gpclk1_gpio5
+		     &spi0_gpio7
+		     &pcm_gpio18
+		     &pwm0_gpio40
+		     &pwm1_gpio45
+		     &gpioout
+		     &alt3>;
 };
 
 &hdmi {
-- 
1.8.3.1
