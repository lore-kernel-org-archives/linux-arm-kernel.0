From: eric@anholt.net (Eric Anholt)
Date: Thu, 25 Feb 2016 10:41:01 -0800
Subject: [PATCH 5/5] ARM: bcm2835: Move most RPi default pin groups to their
 devices.
In-Reply-To: <1456425661-26123-1-git-send-email-eric@anholt.net>
References: <1456425661-26123-1-git-send-email-eric@anholt.net>
Message-ID: <1456425661-26123-6-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This way we can get the duplicated pin group definitions out of each
RPi board file, and just leave the i2s variations in them.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts | 14 +++-----------
 arch/arm/boot/dts/bcm2835-rpi-a.dts      | 14 +++-----------
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts | 14 +++-----------
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts | 14 +++-----------
 arch/arm/boot/dts/bcm2835-rpi-b.dts      | 12 ------------
 arch/arm/boot/dts/bcm2835-rpi.dtsi       | 20 ++++++++++++++++++++
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts    | 14 +++-----------
 7 files changed, 35 insertions(+), 67 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
index 1db6835..a00cbbe 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
@@ -20,15 +20,7 @@
 	};
 };
 
-&gpio {
-	pinctrl-0 = <&i2c0_gpio0
-		     &i2c1_gpio2
-		     &gpclk0_gpio4
-		     &gpclk1_gpio5
-		     &spi0_gpio7
-		     &pcm_gpio18
-		     &pwm0_gpio40
-		     &pwm1_gpio45
-		     &emmc_gpio48
-		     &gpioout>;
+&i2s {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcm_gpio18>;
 };
diff --git a/arch/arm/boot/dts/bcm2835-rpi-a.dts b/arch/arm/boot/dts/bcm2835-rpi-a.dts
index 25d2114..23e6b6f 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a.dts
@@ -13,15 +13,7 @@
 	};
 };
 
-&gpio {
-	pinctrl-0 = <&i2c0_gpio0
-		     &i2c1_gpio2
-		     &gpclk0_gpio4
-		     &gpclk1_gpio5
-		     &spi0_gpio7
-		     &pcm_gpio28
-		     &pwm0_gpio40
-		     &pwm1_gpio45
-		     &emmc_gpio48
-		     &gpioout>;
+&i2s {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcm_gpio28>;
 };
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
index d8057b8..029b589 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
@@ -20,15 +20,7 @@
 	};
 };
 
-&gpio {
-	pinctrl-0 = <&i2c0_gpio0
-		     &i2c1_gpio2
-		     &gpclk0_gpio4
-		     &gpclk1_gpio5
-		     &spi0_gpio7
-		     &pcm_gpio18
-		     &pwm0_gpio40
-		     &pwm1_gpio45
-		     &emmc_gpio48
-		     &gpioout>;
+&i2s {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcm_gpio18>;
 };
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
index e7dbff4..da1bc27 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
@@ -13,15 +13,7 @@
 	};
 };
 
-&gpio {
-	pinctrl-0 = <&i2c0_gpio0
-		     &i2c1_gpio2
-		     &gpclk0_gpio4
-		     &gpclk1_gpio5
-		     &spi0_gpio7
-		     &pcm_gpio28
-		     &pwm0_gpio40
-		     &pwm1_gpio45
-		     &emmc_gpio48
-		     &gpioout>;
+&i2s {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcm_gpio28>;
 };
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/bcm2835-rpi-b.dts
index d154049..df275d4 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -12,15 +12,3 @@
 		};
 	};
 };
-
-&gpio {
-	pinctrl-0 = <&i2c0_gpio0
-		     &i2c1_gpio2
-		     &gpclk0_gpio4
-		     &gpclk1_gpio5
-		     &spi0_gpio7
-		     &pwm0_gpio40
-		     &pwm1_gpio45
-		     &emmc_gpio48
-		     &gpioout>;
-};
diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index eff27b0..b8efd41 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -31,6 +31,9 @@
 
 &gpio {
 	pinctrl-names = "default";
+	pinctrl-0 = <&gpclk0_gpio4
+		     &gpclk1_gpio5
+		     &gpioout>;
 
 	gpioout: gpioout {
 		brcm,pins = <6>;
@@ -39,11 +42,17 @@
 };
 
 &i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_gpio0>;
+
 	status = "okay";
 	clock-frequency = <100000>;
 };
 
 &i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_gpio2>;
+
 	status = "okay";
 	clock-frequency = <100000>;
 };
@@ -53,14 +62,25 @@
 };
 
 &sdhci {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_gpio48>;
+
 	status = "okay";
 	bus-width = <4>;
 };
 
 &pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_gpio40 &pwm1_gpio45>;
+
 	status = "okay";
 };
 
 &usb {
 	power-domains = <&power RPI_POWER_DOMAIN_USB>;
 };
+
+&spi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_gpio7>;
+};
diff --git a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
index 3e9226f..ae2bc91 100644
--- a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
+++ b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
@@ -24,15 +24,7 @@
 	};
 };
 
-&gpio {
-	pinctrl-0 = <&i2c0_gpio0
-		     &i2c1_gpio2
-		     &gpclk0_gpio4
-		     &gpclk1_gpio5
-		     &spi0_gpio7
-		     &pcm_gpio18
-		     &pwm0_gpio40
-		     &pwm1_gpio45
-		     &emmc_gpio48
-		     &gpioout>;
+&i2s {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcm_gpio18>;
 };
-- 
2.7.0
