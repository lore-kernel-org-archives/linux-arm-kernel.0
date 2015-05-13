From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Wed, 13 May 2015 09:10:51 +0200
Subject: [PATCH 1/3] ARM: BCM5301X: Add USB LED for Buffalo WZR-1750DHP
Message-ID: <1431501053-1517-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felix Fietkau <nbd@openwrt.org>

Signed-off-by: Felix Fietkau <nbd@openwrt.org>
---
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
index b359c1e..78e95c0 100644
--- a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
+++ b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
@@ -47,6 +47,12 @@
 	leds {
 		compatible = "gpio-leds";
 
+		usb {
+			label = "bcm53xx:blue:usb";
+			gpios = <&hc595 0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-off";
+		};
+
 		power0 {
 			label = "bcm53xx:red:power";
 			gpios = <&hc595 1 GPIO_ACTIVE_HIGH>;
-- 
1.8.4.5
