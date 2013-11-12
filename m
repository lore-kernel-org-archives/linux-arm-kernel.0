From: afzal@ti.com (Afzal Mohammed)
Date: Tue, 12 Nov 2013 16:54:26 +0530
Subject: [PATCH] ARM: dts: AM437x GP EVM support
Message-ID: <1384255468-2453-1-git-send-email-afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lokesh Vutla <lokeshvutla@ti.com>

AM437x GP EVM DTS with pinmux information to make I2C on EVM usable.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 .../devicetree/bindings/arm/omap/omap.txt          |  3 ++
 arch/arm/boot/dts/Makefile                         |  1 +
 arch/arm/boot/dts/am437x-gp-evm.dts                | 47 ++++++++++++++++++++++
 3 files changed, 51 insertions(+)
 create mode 100644 arch/arm/boot/dts/am437x-gp-evm.dts

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 808c154..be5f365 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -61,5 +61,8 @@ Boards:
 - AM43x EPOS EVM
   compatible = "ti,am43x-epos-evm", "ti,am4372", "ti,am43"
 
+- AM437x GP EVM
+  compatible = "ti,am437x-gp-evm", "ti,am4372", "ti,am43"
+
 - DRA7 EVM:  Software Developement Board for DRA7XX
   compatible = "ti,dra7-evm", "ti,dra7"
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d57c1a6..85626e4 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -203,6 +203,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	am3517-evm.dtb \
 	am3517_mt_ventoux.dtb \
 	am43x-epos-evm.dtb \
+	am437x-gp-evm.dtb \
 	dra7-evm.dtb
 dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-ethernet-disk-mini-v2.dtb
 dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
new file mode 100644
index 0000000..11d93ba
--- /dev/null
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -0,0 +1,47 @@
+/*
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/* AM437x GP EVM */
+
+/dts-v1/;
+
+#include "am4372.dtsi"
+#include <dt-bindings/pinctrl/am43xx.h>
+
+/ {
+	model = "TI AM437x GP EVM";
+	compatible = "ti,am437x-gp-evm","ti,am4372","ti,am43";
+};
+
+&am43xx_pinmux {
+	i2c0_pins: i2c0_pins {
+		pinctrl-single,pins = <
+			0x188 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)  /* i2c0_sda.i2c0_sda */
+			0x18c (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)  /* i2c0_scl.i2c0_scl */
+		>;
+	};
+
+	i2c1_pins: i2c1_pins {
+		pinctrl-single,pins = <
+			0x15c (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE2)  /* spi0_cs0.i2c1_scl */
+			0x158 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE2)  /* spi0_d1.i2c1_sda  */
+		>;
+	};
+};
+
+&i2c0 {
+        status = "okay";
+        pinctrl-names = "default";
+        pinctrl-0 = <&i2c0_pins>;
+};
+
+&i2c1 {
+        status = "okay";
+        pinctrl-names = "default";
+        pinctrl-0 = <&i2c1_pins>;
+};
-- 
1.8.3.4
