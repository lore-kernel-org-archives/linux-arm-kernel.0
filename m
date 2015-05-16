From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Sat, 16 May 2015 16:55:39 +0200
Subject: [PATCH] ARM: BCM5301X: Add DT for Asus RT-AC87U
Message-ID: <1431788139-21829-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
Signed-off-by: ?lvaro Fern?ndez Rojas <noltari@gmail.com>
---
 arch/arm/boot/dts/Makefile                  |  1 +
 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts | 65 +++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4802376..4e76f68 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -66,6 +66,7 @@ dtb-$(CONFIG_ARCH_BCM_5301X) += \
 	bcm47081-asus-rt-n18u.dtb \
 	bcm47081-buffalo-wzr-600dhp2.dtb \
 	bcm47081-buffalo-wzr-900dhp.dtb \
+	bcm4709-asus-rt-ac87u.dtb \
 	bcm4709-buffalo-wxr-1900dhp.dtb \
 	bcm4709-netgear-r8000.dtb
 dtb-$(CONFIG_ARCH_BCM_63XX) += \
diff --git a/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts b/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
new file mode 100644
index 0000000..aedf3c4
--- /dev/null
+++ b/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
@@ -0,0 +1,65 @@
+/*
+ * Broadcom BCM470X / BCM5301X ARM platform code.
+ * DTS for Asus RT-AC87U
+ *
+ * Copyright (C) 2015 Rafa? Mi?ecki <zajec5@gmail.com>
+ *
+ * Licensed under the GNU/GPL. See COPYING for details.
+ */
+
+/dts-v1/;
+
+#include "bcm4708.dtsi"
+
+/ {
+	compatible = "asus,rt-ac87u", "brcm,bcm4709", "brcm,bcm4708";
+	model = "Asus RT-AC87U";
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
+		wps {
+			label = "bcm53xx:blue:wps";
+			gpios = <&chipcommon 1 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+
+		power {
+			label = "bcm53xx:blue:power";
+			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-on";
+		};
+
+		wan {
+			label = "bcm53xx:red:wan";
+			gpios = <&chipcommon 5 GPIO_ACTIVE_LOW>;
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
+			gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
+		};
+
+		restart {
+			label = "Reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
-- 
1.8.4.5
