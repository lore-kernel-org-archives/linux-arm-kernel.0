From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Thu,  9 Jan 2014 17:48:07 +0100
Subject: [PATCH 13/18] ARM: dts: Add support for the Overo Palo43
In-Reply-To: <1389286092-27087-1-git-send-email-florian.vaussard@epfl.ch>
References: <1389286092-27087-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <1389286092-27087-14-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Palo43 is an expansion board for Gumstix Overo products.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/Makefile               |  1 +
 arch/arm/boot/dts/omap3-overo-palo43.dts | 52 ++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3-overo-palo43.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7b028e4..98f9bc5 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -189,6 +189,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap3-n900.dtb \
 	omap3-n9.dtb \
 	omap3-n950.dtb \
+	omap3-overo-palo43.dtb \
 	omap3-overo-tobi.dtb \
 	omap3-gta04.dtb \
 	omap3-igep0020.dtb \
diff --git a/arch/arm/boot/dts/omap3-overo-palo43.dts b/arch/arm/boot/dts/omap3-overo-palo43.dts
new file mode 100644
index 0000000..2d5791b
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-overo-palo43.dts
@@ -0,0 +1,52 @@
+/*
+ * Copyright (C) 2014 Florian Vaussard, EPFL Mobots group
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Palo43 expansion board is manufactured by Gumstix Inc.
+ */
+
+#include "omap3-overo-common.dtsi"
+
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "TI OMAP3 Gumstix Overo on Palo43";
+	compatible = "gumstix,omap3-overo-palo43", "gumstix,omap3-overo", "ti,omap3";
+
+	leds {
+		compatible = "gpio-leds";
+		heartbeat {
+			label = "overo:red:gpio21";
+			gpios = <&gpio1 21 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+		gpio22 {
+			label = "overo:blue:gpio22";
+			gpios = <&gpio1 22 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		button0 at 23 {
+			label = "button0";
+			linux,code = <BTN_0>;
+			gpios = <&gpio1 23 GPIO_ACTIVE_LOW>;
+			gpio-key,wakeup;
+		};
+		button1 at 14 {
+			label = "button1";
+			linux,code = <BTN_1>;
+			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
+			gpio-key,wakeup;
+		};
+	};
+};
+
-- 
1.8.1.2
