From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Sun, 30 Nov 2014 18:28:30 +0100
Subject: [PATCH 2/5] ARM: BCM5301X: Add DT for Netgear R6300 V2
In-Reply-To: <1417368513-13808-1-git-send-email-zajec5@gmail.com>
References: <1417368513-13808-1-git-send-email-zajec5@gmail.com>
Message-ID: <1417368513-13808-2-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 arch/arm/boot/dts/Makefile                     |  4 +-
 arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts | 84 ++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 35f3e12..22bb87f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -55,7 +55,9 @@ dtb-$(CONFIG_ARCH_ATLAS6) += atlas6-evb.dtb
 dtb-$(CONFIG_ARCH_AXXIA) += axm5516-amarillo.dtb
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b-plus.dtb
-dtb-$(CONFIG_ARCH_BCM_5301X) += bcm4708-netgear-r6250.dtb
+dtb-$(CONFIG_ARCH_BCM_5301X) += \
+	bcm4708-netgear-r6250.dtb \
+	bcm4708-netgear-r6300-v2.dtb
 dtb-$(CONFIG_ARCH_BCM_63XX) += bcm963138dvt.dtb
 dtb-$(CONFIG_ARCH_BCM_CYGNUS) += bcm911360_entphn.dtb \
 	bcm911360k.dtb \
diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
new file mode 100644
index 0000000..e18b636
--- /dev/null
+++ b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
@@ -0,0 +1,84 @@
+/*
+ * Broadcom BCM470X / BCM5301X ARM platform code.
+ * DTS for Netgear R6300 V2
+ *
+ * Copyright ? 2014 Rafa? Mi?ecki <zajec5@gmail.com>
+ *
+ * Licensed under the GNU/GPL. See COPYING for details.
+ */
+
+/dts-v1/;
+
+#include "bcm4708.dtsi"
+
+/ {
+	compatible = "netgear,r6300v2", "brcm,bcm4708";
+	model = "Netgear R6300 V2 (BCM4708)";
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
+};
-- 
1.8.4.5
