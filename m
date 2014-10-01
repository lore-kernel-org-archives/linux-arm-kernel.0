From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Wed,  1 Oct 2014 15:45:29 +0200
Subject: [PATCH 2/2] ARM: BCM5301X: Add LEDs for Netgear R6250 V1
In-Reply-To: <1412171129-31482-1-git-send-email-zajec5@gmail.com>
References: <1412171129-31482-1-git-send-email-zajec5@gmail.com>
Message-ID: <1412171129-31482-2-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts | 34 +++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
index 3b5259d..58d999d 100644
--- a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
+++ b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
@@ -32,4 +32,38 @@
 			status = "okay";
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		logo {
+			label = "bcm53xx:white:logo";
+			gpios = <&chipcommon 1 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+		};
+
+		power0 {
+			label = "bcm53xx:green:power";
+			gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+
+		power1 {
+			label = "bcm53xx:amber:power";
+			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-on";
+		};
+
+		usb {
+			label = "bcm53xx:blue:usb";
+			gpios = <&chipcommon 8 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+
+		wireless {
+			label = "bcm53xx:blue:wireless";
+			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+	};
 };
-- 
1.8.4.5
