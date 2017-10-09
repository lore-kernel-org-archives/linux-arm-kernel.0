From: riproute@gmail.com (Dan Haab)
Date: Mon,  9 Oct 2017 09:47:00 -0600
Subject: [PATCH 2/2] ARM: dts: BCM53573: Add DT for Luxul XAP-1440
In-Reply-To: <1507564020-7394-1-git-send-email-riproute@gmail.com>
References: <1507564020-7394-1-git-send-email-riproute@gmail.com>
Message-ID: <1507564020-7394-2-git-send-email-riproute@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dan Haab <dhaab@luxul.com>

This is BCM53573 WiSoC based outdoor access point with an extra BCM43217
chipset used for 2.4 GHz.

Signed-off-by: Dan Haab <dhaab@luxul.com>
---
 arch/arm/boot/dts/Makefile                    |  1 +
 arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts | 50 +++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5cac283..1e1ad2f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -110,6 +110,7 @@ dtb-$(CONFIG_ARCH_BCM_5301X) += \
 	bcm953012hr.dtb \
 	bcm953012k.dtb
 dtb-$(CONFIG_ARCH_BCM_53573) += \
+	bcm47189-luxul-xap-1440.dtb \
 	bcm47189-luxul-xap-810.dtb \
 	bcm47189-tenda-ac9.dtb \
 	bcm947189acdbmr.dtb
diff --git a/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts b/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
new file mode 100644
index 0000000..74c83b0
--- /dev/null
+++ b/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
@@ -0,0 +1,50 @@
+/*
+ * Copyright 2017 Luxul Inc.
+ *
+ * Licensed under the ISC license.
+ */
+
+/dts-v1/;
+
+#include "bcm53573.dtsi"
+
+/ {
+	compatible = "luxul,xap-1440-v1", "brcm,bcm47189", "brcm,bcm53573";
+	model = "Luxul XAP-1440 V1";
+
+	chosen {
+		bootargs = "earlycon";
+	};
+
+	memory {
+		reg = <0x00000000 0x08000000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		wlan {
+			label = "bcm53xx:blue:wlan";
+			gpios = <&chipcommon 10 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+
+		system {
+			label = "bcm53xx:green:system";
+			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "timer";
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		restart {
+			label = "Reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&chipcommon 7 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
-- 
1.9.1
