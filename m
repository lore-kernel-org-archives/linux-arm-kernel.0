From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Thu,  4 Dec 2014 10:24:02 +0100
Subject: [PATCH V2 5/5] ARM: BCM5301X: Add DT for Buffalo WZR-600DHP2
In-Reply-To: <1417368513-13808-5-git-send-email-zajec5@gmail.com>
References: <1417368513-13808-5-git-send-email-zajec5@gmail.com>
Message-ID: <1417685042-1367-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
V2: Use (C) instad of UTF ?
    Use "brcm,bcm4708" compatibility after "brcm,bcm47081"
---
 arch/arm/boot/dts/Makefile                         |  3 +-
 arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts | 57 ++++++++++++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index db51a31..9400e94 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -59,7 +59,8 @@ dtb-$(CONFIG_ARCH_BCM_5301X) += \
 	bcm4708-buffalo-wzr-1750dhp.dtb \
 	bcm4708-netgear-r6250.dtb \
 	bcm4708-netgear-r6300-v2.dtb \
-	bcm47081-asus-rt-n18u.dtb
+	bcm47081-asus-rt-n18u.dtb \
+	bcm47081-buffalo-wzr-600dhp2.dtb
 dtb-$(CONFIG_ARCH_BCM_63XX) += bcm963138dvt.dtb
 dtb-$(CONFIG_ARCH_BCM_CYGNUS) += bcm911360_entphn.dtb \
 	bcm911360k.dtb \
diff --git a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
new file mode 100644
index 0000000..bbb414f
--- /dev/null
+++ b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
@@ -0,0 +1,57 @@
+/*
+ * Broadcom BCM470X / BCM5301X ARM platform code.
+ * DTS for Buffalo WZR-600DHP2
+ *
+ * Copyright (C) 2014 Rafa? Mi?ecki <zajec5@gmail.com>
+ *
+ * Licensed under the GNU/GPL. See COPYING for details.
+ */
+
+/dts-v1/;
+
+#include "bcm47081.dtsi"
+
+/ {
+	compatible = "buffalo,wzr-600dhp2", "brcm,bcm47081", "brcm,bcm4708";
+	model = "Buffalo WZR-600DHP2 (BCM47081)";
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
+		aoss {
+			label = "AOSS";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&chipcommon 9 GPIO_ACTIVE_LOW>;
+		};
+
+		restart {
+			label = "Reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
+		};
+
+		/* Switch device mode? */
+		mode {
+			label = "Mode";
+			linux,code = <KEY_SETUP>;
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
