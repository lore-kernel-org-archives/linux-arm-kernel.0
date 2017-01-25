From: zajec5@gmail.com (Dan Haab)
Date: Wed, 25 Jan 2017 10:44:17 +0100
Subject: [PATCH] ARM: dts: BCM5301X: Add basic DT for Linksys EA6300 V1
Message-ID: <20170125094417.9775-1-dhaab@luxul.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

It's wireless home router based on BCM4708A0 with BCM4360 + BCM43217
wireless chipsets. LEDs will be hopefully added later to the DT.
According to some sources it may use the same board as EA6400 and just
differ by an original vendor firmware.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/Makefile                      |  1 +
 arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts | 41 +++++++++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 767608b9d806..52a05289c538 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -75,6 +75,7 @@ dtb-$(CONFIG_ARCH_BCM_5301X) += \
 	bcm4708-asus-rt-ac56u.dtb \
 	bcm4708-asus-rt-ac68u.dtb \
 	bcm4708-buffalo-wzr-1750dhp.dtb \
+	bcm4708-linksys-ea6300-v1.dtb \
 	bcm4708-luxul-xap-1510.dtb \
 	bcm4708-luxul-xwc-1000.dtb \
 	bcm4708-netgear-r6250.dtb \
diff --git a/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts b/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts
new file mode 100644
index 000000000000..126ab5867772
--- /dev/null
+++ b/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts
@@ -0,0 +1,41 @@
+/*
+ * Copyright (C) 2017 Rafa? Mi?ecki <rafal@milecki.pl>
+ *
+ * Licensed under the ISC license.
+ */
+
+/dts-v1/;
+
+#include "bcm4708.dtsi"
+#include "bcm5301x-nand-cs0-bch8.dtsi"
+
+/ {
+	compatible = "linksys,ea6300-v1", "brcm,bcm4708";
+	model = "Linksys EA6300 V1";
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
+
+		wps {
+			label = "WPS";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&chipcommon 7 GPIO_ACTIVE_LOW>;
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
2.11.0
