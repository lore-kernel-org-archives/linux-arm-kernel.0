From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Sun, 30 Nov 2014 18:28:29 +0100
Subject: [PATCH 1/5] ARM: BCM5301X: Add buttons for Netgear R6250
Message-ID: <1417368513-13808-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts | 25 +++++++++++++++++++++++++
 arch/arm/boot/dts/bcm5301x.dtsi             |  1 +
 2 files changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
index 58d999d..4ed7de1 100644
--- a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
+++ b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
@@ -66,4 +66,29 @@
 			linux,default-trigger = "default-off";
 		};
 	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		poll-interval = <200>;
+
+		wps {
+			label = "WPS";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&chipcommon 4 GPIO_ACTIVE_LOW>;
+		};
+
+		rfkill {
+			label = "WiFi";
+			linux,code = <KEY_RFKILL>;
+			gpios = <&chipcommon 5 GPIO_ACTIVE_LOW>;
+		};
+
+		restart {
+			label = "Reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&chipcommon 6 GPIO_ACTIVE_LOW>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 6d80922..08e200a 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -9,6 +9,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include "skeleton.dtsi"
-- 
1.8.4.5
