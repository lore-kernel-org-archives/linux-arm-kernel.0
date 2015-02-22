From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Sun, 22 Feb 2015 16:59:56 +0000
Subject: [PATCH] ARM: bcm2835: Add header file for pinctrl constants
Message-ID: <1424624396-812-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a header file for the constants used in pincontrol
configuration for the bcm2835.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts      |    4 +-
 arch/arm/boot/dts/bcm2835-rpi-b.dts           |    4 +-
 arch/arm/boot/dts/bcm2835-rpi.dtsi            |    8 ++--
 arch/arm/boot/dts/bcm2835.dtsi                |    4 ++-
 include/dt-bindings/pinctrl/pinctrl-bcm2835.h |   39 +++++++++++++++++++++++++
 5 files changed, 50 insertions(+), 9 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/pinctrl-bcm2835.h

diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
index e479515..e3418c2 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
@@ -1,5 +1,5 @@
 /dts-v1/;
-/include/ "bcm2835-rpi.dtsi"
+#include "bcm2835-rpi.dtsi"
 
 / {
 	compatible = "raspberrypi,model-b-plus", "brcm,bcm2835";
@@ -25,6 +25,6 @@
 	/* I2S interface */
 	i2s_alt0: i2s_alt0 {
 		brcm,pins = <18 19 20 21>;
-		brcm,function = <4>; /* alt0 */
+		brcm,function = <BCM2835_PIN_FUNC_ALT0>;
 	};
 };
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/bcm2835-rpi-b.dts
index bafa46f..541788a 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -1,5 +1,5 @@
 /dts-v1/;
-/include/ "bcm2835-rpi.dtsi"
+#include "bcm2835-rpi.dtsi"
 
 / {
 	compatible = "raspberrypi,model-b", "brcm,bcm2835";
@@ -18,6 +18,6 @@
 	/* I2S interface */
 	i2s_alt2: i2s_alt2 {
 		brcm,pins = <28 29 30 31>;
-		brcm,function = <6>; /* alt2 */
+		brcm,function = <BCM2835_PIN_FUNC_ALT2>;
 	};
 };
diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index c706448..76b0a40 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -1,4 +1,4 @@
-/include/ "bcm2835.dtsi"
+#include "bcm2835.dtsi"
 
 / {
 	memory {
@@ -21,17 +21,17 @@
 
 	gpioout: gpioout {
 		brcm,pins = <6>;
-		brcm,function = <1>; /* GPIO out */
+		brcm,function = <BCM2835_PIN_FUNC_GPIO_OUT>;
 	};
 
 	alt0: alt0 {
 		brcm,pins = <0 1 2 3 4 5 7 8 9 10 11 14 15 40 45>;
-		brcm,function = <4>; /* alt0 */
+		brcm,function = <BCM2835_PIN_FUNC_ALT0>;
 	};
 
 	alt3: alt3 {
 		brcm,pins = <48 49 50 51 52 53>;
-		brcm,function = <7>; /* alt3 */
+		brcm,function = <BCM2835_PIN_FUNC_ALT3>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 3342cb1..31f6586 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -1,4 +1,6 @@
-/include/ "skeleton.dtsi"
+#include <dt-bindings/pinctrl/pinctrl-bcm2835.h>
+
+#include "skeleton.dtsi"
 
 / {
 	compatible = "brcm,bcm2835";
diff --git a/include/dt-bindings/pinctrl/pinctrl-bcm2835.h b/include/dt-bindings/pinctrl/pinctrl-bcm2835.h
new file mode 100644
index 0000000..c74532e
--- /dev/null
+++ b/include/dt-bindings/pinctrl/pinctrl-bcm2835.h
@@ -0,0 +1,39 @@
+/*
+ * This header provides constants for BCM2835 pinctrl bindings.
+ *
+ * Copyright 2015, Cirrus Logic Inc.
+ *
+ * Author: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _DT_BINDINGS_PINCTRL_BCM2835_H
+#define _DT_BINDINGS_PINCTRL_BCM2835_H
+
+/* IRQ Flags */
+#define BCM2835_PIN_IRQ_RISING				1
+#define BCM2835_PIN_IRQ_FALLING				2
+#define BCM2835_PIN_IRQ_EDGE	(BCM2835_PIN_IRQ_RISING | \
+				 BCM2835_PIN_IRQ_FALLING)
+#define BCM2835_PIN_IRQ_LOW				4
+#define BCM2835_PIN_IRQ_HIGH				8
+
+/* Pin Function Settings */
+#define BCM2835_PIN_FUNC_GPIO_IN			0
+#define BCM2835_PIN_FUNC_GPIO_OUT			1
+#define BCM2835_PIN_FUNC_ALT5				2
+#define BCM2835_PIN_FUNC_ALT4				3
+#define BCM2835_PIN_FUNC_ALT0				4
+#define BCM2835_PIN_FUNC_ALT1				5
+#define BCM2835_PIN_FUNC_ALT2				6
+#define BCM2835_PIN_FUNC_ALT3				7
+
+/* Pin Pull Settings */
+#define BCM2835_PIN_PULL_NONE				0
+#define BCM2835_PIN_PULL_DOWN				1
+#define BCM2835_PIN_PULL_UP				2
+
+#endif
-- 
1.7.2.5
