From: zajec5@gmail.com (Dan Haab)
Date: Wed, 25 Jan 2017 08:09:16 +0100
Subject: [PATCH] ARM: dts: BCM5301X: Add basic DT for Linksys EA9200
Message-ID: <20170125070916.21107-1-dhaab@luxul.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

It's tri-band wireless home router based on BCM4709A0 with 3 x BCM43602
chipsets. LEDs will be hopefully added later to the DT.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/Makefile                   |  1 +
 arch/arm/boot/dts/bcm4709-linksys-ea9200.dts | 42 ++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm4709-linksys-ea9200.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 8a403a26ae42..767608b9d806 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -87,6 +87,7 @@ dtb-$(CONFIG_ARCH_BCM_5301X) += \
 	bcm47081-luxul-xwr-1200.dtb \
 	bcm4709-asus-rt-ac87u.dtb \
 	bcm4709-buffalo-wxr-1900dhp.dtb \
+	bcm4709-linksys-ea9200.dtb \
 	bcm4709-netgear-r7000.dtb \
 	bcm4709-netgear-r8000.dtb \
 	bcm4709-tplink-archer-c9-v1.dtb \
diff --git a/arch/arm/boot/dts/bcm4709-linksys-ea9200.dts b/arch/arm/boot/dts/bcm4709-linksys-ea9200.dts
new file mode 100644
index 000000000000..3d1d9c2c4efc
--- /dev/null
+++ b/arch/arm/boot/dts/bcm4709-linksys-ea9200.dts
@@ -0,0 +1,42 @@
+/*
+ * Copyright (C) 2017 Rafa? Mi?ecki <rafal@milecki.pl>
+ *
+ * Licensed under the ISC license.
+ */
+
+/dts-v1/;
+
+#include "bcm4709.dtsi"
+#include "bcm5301x-nand-cs0-bch8.dtsi"
+
+/ {
+	compatible = "linksys,ea9200", "brcm,bcm4709", "brcm,bcm4708";
+	model = "Linksys EA9200";
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+	};
+
+	memory {
+		reg = <0x00000000 0x08000000
+		       0x88000000 0x08000000>;
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
+			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
+		};
+
+		restart {
+			label = "Reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&chipcommon 17 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
-- 
2.11.0
