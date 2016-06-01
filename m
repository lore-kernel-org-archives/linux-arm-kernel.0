From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed,  1 Jun 2016 23:43:24 +0200
Subject: [PATCH 15/32] ARM: bcm2835: Move the emmc pin group to bcm283x.dtsi.
In-Reply-To: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
Message-ID: <1464817421-8519-16-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Anholt <eric@anholt.net>

While it's not documented in the public PDF, it is internally.  This
is a standard pin group for the 283x, not rpi-specific.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts | 4 ++--
 arch/arm/boot/dts/bcm2835-rpi-a.dts      | 4 ++--
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts | 4 ++--
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts | 4 ++--
 arch/arm/boot/dts/bcm2835-rpi-b.dts      | 4 ++--
 arch/arm/boot/dts/bcm2835-rpi.dtsi       | 5 -----
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts    | 4 ++--
 arch/arm/boot/dts/bcm283x.dtsi           | 4 ++++
 8 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
index e90f870..5bd0bfe 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
@@ -29,8 +29,8 @@
 		     &pcm_gpio18
 		     &pwm0_gpio40
 		     &pwm1_gpio45
-		     &gpioout
-		     &alt3>;
+		     &emmc_gpio48
+		     &gpioout>;
 };
 
 &hdmi {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-a.dts b/arch/arm/boot/dts/bcm2835-rpi-a.dts
index 2de38c3..ba1b0ac 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a.dts
@@ -22,8 +22,8 @@
 		     &pcm_gpio28
 		     &pwm0_gpio40
 		     &pwm1_gpio45
-		     &gpioout
-		     &alt3>;
+		     &emmc_gpio48
+		     &gpioout>;
 };
 
 &hdmi {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
index 9ad3125..609a5e8 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
@@ -30,8 +30,8 @@
 		     &pcm_gpio18
 		     &pwm0_gpio40
 		     &pwm1_gpio45
-		     &gpioout
-		     &alt3>;
+		     &emmc_gpio48
+		     &gpioout>;
 };
 
 &hdmi {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
index 1bec67f..97de2d5 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
@@ -23,8 +23,8 @@
 		     &pcm_gpio28
 		     &pwm0_gpio40
 		     &pwm1_gpio45
-		     &gpioout
-		     &alt3>;
+		     &emmc_gpio48
+		     &gpioout>;
 };
 
 &hdmi {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/bcm2835-rpi-b.dts
index 0e9f566..bc59f7e 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -22,8 +22,8 @@
 		     &spi0_gpio7
 		     &pwm0_gpio40
 		     &pwm1_gpio45
-		     &gpioout
-		     &alt3>;
+		     &emmc_gpio48
+		     &gpioout>;
 };
 
 &hdmi {
diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index e9ab80a..7e65d16 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -36,11 +36,6 @@
 		brcm,pins = <6>;
 		brcm,function = <BCM2835_FSEL_GPIO_OUT>;
 	};
-
-	alt3: alt3 {
-		brcm,pins = <48 49 50 51 52 53>;
-		brcm,function = <BCM2835_FSEL_ALT3>;
-	};
 };
 
 &i2c0 {
diff --git a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
index 348e3e1..b4cbffe 100644
--- a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
+++ b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
@@ -34,8 +34,8 @@
 		     &pcm_gpio18
 		     &pwm0_gpio40
 		     &pwm1_gpio45
-		     &gpioout
-		     &alt3>;
+		     &emmc_gpio48
+		     &gpioout>;
 };
 
 &hdmi {
diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 9aefb65..28ed77f 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -253,6 +253,10 @@
 				brcm,pins = <32 33>;
 				brcm,function = <BCM2835_FSEL_ALT3>;
 			};
+			emmc_gpio48: emmc_gpio48 {
+				brcm,pins = <48 49 50 51 52 53>;
+				brcm,function = <BCM2835_FSEL_ALT3>;
+			};
 			spi1_gpio16: spi1_gpio16 {
 				brcm,pins = <16 17 18 19 20 21>;
 				brcm,function = <BCM2835_FSEL_ALT4>;
-- 
1.8.3.1
