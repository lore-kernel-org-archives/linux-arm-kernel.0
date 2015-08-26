From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Wed, 26 Aug 2015 16:13:22 +0200
Subject: [PATCH] ARM: BCM5301X: Add DT for Netgear R7000
Message-ID: <1440598402-19106-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/bcm4709-netgear-r7000.dts | 106 ++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm4709-netgear-r7000.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 685b488..dd551bf 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -72,6 +72,7 @@ dtb-$(CONFIG_ARCH_BCM_5301X) += \
 	bcm47081-buffalo-wzr-900dhp.dtb \
 	bcm4709-asus-rt-ac87u.dtb \
 	bcm4709-buffalo-wxr-1900dhp.dtb \
+	bcm4709-netgear-r7000.dtb \
 	bcm4709-netgear-r8000.dtb
 dtb-$(CONFIG_ARCH_BCM_63XX) += \
 	bcm963138dvt.dtb
diff --git a/arch/arm/boot/dts/bcm4709-netgear-r7000.dts b/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
new file mode 100644
index 0000000..a22ed14
--- /dev/null
+++ b/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
@@ -0,0 +1,106 @@
+/*
+ * Broadcom BCM470X / BCM5301X ARM platform code.
+ * DTS for Netgear R7000
+ *
+ * Copyright (C) 2015 Rafa? Mi?ecki <zajec5@gmail.com>
+ *
+ * Licensed under the GNU/GPL. See COPYING for details.
+ */
+
+/dts-v1/;
+
+#include "bcm4708.dtsi"
+#include "bcm5301x-nand-cs0-bch8.dtsi"
+
+/ {
+	compatible = "netgear,r7000", "brcm,bcm4709", "brcm,bcm4708";
+	model = "Netgear R7000";
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+	};
+
+	memory {
+		reg = <0x00000000 0x08000000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		power-white {
+			label = "bcm53xx:white:power";
+			gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-on";
+		};
+
+		power-amber {
+			label = "bcm53xx:amber:power";
+			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+
+		5ghz {
+			label = "bcm53xx:white:5ghz";
+			gpios = <&chipcommon 12 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+
+		2ghz {
+			label = "bcm53xx:white:2ghz";
+			gpios = <&chipcommon 13 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+
+		wps {
+			label = "bcm53xx:white:wps";
+			gpios = <&chipcommon 14 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-off";
+		};
+
+		wireless {
+			label = "bcm53xx:white:wireless";
+			gpios = <&chipcommon 15 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-off";
+		};
+
+		usb3 {
+			label = "bcm53xx:white:usb3";
+			gpios = <&chipcommon 17 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+
+		usb2 {
+			label = "bcm53xx:white:usb2";
+			gpios = <&chipcommon 18 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
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
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
1.8.4.5
