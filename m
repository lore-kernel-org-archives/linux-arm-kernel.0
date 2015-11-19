From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 19 Nov 2015 16:06:13 +0000
Subject: [PATCH RFC 1/4] ARM: bcm2835: remove sdhci pins from GPIO pinctrl
In-Reply-To: <1447949176-21926-1-git-send-email-stefan.wahren@i2se.com>
References: <1447949176-21926-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1447949176-21926-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the pins alt3 (sdhci) are assigned to GPIO pinctrl.
This is bad because a user could export it to sysfs and break
sdhci. In order to avoid that remove those pins from GPIO pintrl.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts |    2 +-
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts |    2 +-
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts |    2 +-
 arch/arm/boot/dts/bcm2835-rpi-b.dts      |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
index b2bff43..50be11d 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
@@ -20,7 +20,7 @@
 };
 
 &gpio {
-	pinctrl-0 = <&gpioout &alt0 &i2s_alt0 &alt3>;
+	pinctrl-0 = <&gpioout &alt0 &i2s_alt0>;
 
 	/* I2S interface */
 	i2s_alt0: i2s_alt0 {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
index 668442b..43dd5ef 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
@@ -20,7 +20,7 @@
 };
 
 &gpio {
-	pinctrl-0 = <&gpioout &alt0 &i2s_alt0 &alt3>;
+	pinctrl-0 = <&gpioout &alt0 &i2s_alt0>;
 
 	/* I2S interface */
 	i2s_alt0: i2s_alt0 {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
index eab8b591..e5a65a8 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
@@ -13,7 +13,7 @@
 };
 
 &gpio {
-	pinctrl-0 = <&gpioout &alt0 &i2s_alt2 &alt3>;
+	pinctrl-0 = <&gpioout &alt0 &i2s_alt2>;
 
 	/* I2S interface */
 	i2s_alt2: i2s_alt2 {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/bcm2835-rpi-b.dts
index ff6b2d1..e6cd93b 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -13,5 +13,5 @@
 };
 
 &gpio {
-	pinctrl-0 = <&gpioout &alt0 &alt3>;
+	pinctrl-0 = <&gpioout &alt0>;
 };
-- 
1.7.9.5
