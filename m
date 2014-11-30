From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Sun, 30 Nov 2014 18:28:31 +0100
Subject: [PATCH 3/5] ARM: BCM5301X: Add DT for Buffalo WZR-1750DHP
In-Reply-To: <1417368513-13808-1-git-send-email-zajec5@gmail.com>
References: <1417368513-13808-1-git-send-email-zajec5@gmail.com>
Message-ID: <1417368513-13808-3-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 arch/arm/boot/dts/Makefile                        |  1 +
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts | 64 +++++++++++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 22bb87f..18a21d9 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -56,6 +56,7 @@ dtb-$(CONFIG_ARCH_AXXIA) += axm5516-amarillo.dtb
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b-plus.dtb
 dtb-$(CONFIG_ARCH_BCM_5301X) += \
+	bcm4708-buffalo-wzr-1750dhp.dtb \
 	bcm4708-netgear-r6250.dtb \
 	bcm4708-netgear-r6300-v2.dtb
 dtb-$(CONFIG_ARCH_BCM_63XX) += bcm963138dvt.dtb
diff --git a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
new file mode 100644
index 0000000..6ad8779
--- /dev/null
+++ b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
@@ -0,0 +1,64 @@
+/*
+ * Broadcom BCM470X / BCM5301X ARM platform code.
+ * DTS for Buffalo WZR-1750DHP
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
+	compatible = "buffalo,wzr-1750dhp", "brcm,bcm4708";
+	model = "Buffalo WZR-1750DHP (BCM4708)";
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+	};
+
+	memory {
+		reg = <0x00000000 0x08000000>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		poll-interval = <200>;
+
+		restart {
+			label = "Reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
+		};
+
+		aoss {
+			label = "AOSS";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&chipcommon 12 GPIO_ACTIVE_LOW>;
+		};
+
+		/* Commit mode set by switch? */
+		mode {
+			label = "Mode";
+			linux,code = <KEY_SETUP>;
+			gpios = <&chipcommon 13 GPIO_ACTIVE_LOW>;
+		};
+
+		/* Switch: AP mode */
+		sw_ap {
+			label = "AP";
+			linux,code = <BTN_0>;
+			gpios = <&chipcommon 14 GPIO_ACTIVE_LOW>;
+		};
+
+		eject {
+			label = "USB eject";
+			linux,code = <KEY_EJECTCD>;
+			gpios = <&chipcommon 15 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
-- 
1.8.4.5
