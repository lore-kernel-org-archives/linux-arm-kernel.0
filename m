From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Wed, 21 Sep 2016 22:58:33 +0200
Subject: [PATCH 2/3] ARM: BCM5301X: Enable UART on Netgear R8000
In-Reply-To: <20160921205838.15627-1-zajec5@gmail.com>
References: <20160921205838.15627-1-zajec5@gmail.com>
Message-ID: <20160921205838.15627-2-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

It was tested by LEDE users, all we need is to adjust clock frequency.
While we're at it create a separated DTS include file to share code with
other BCM4709 devices easier.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts       |  2 +-
 arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts |  2 +-
 arch/arm/boot/dts/bcm4709-netgear-r7000.dts       |  2 +-
 arch/arm/boot/dts/bcm4709-netgear-r8000.dts       |  6 +++++-
 arch/arm/boot/dts/bcm4709.dtsi                    | 11 +++++++++++
 5 files changed, 19 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm4709.dtsi

diff --git a/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts b/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
index 8ade7de..eac0f52 100644
--- a/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
+++ b/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
@@ -9,7 +9,7 @@
 
 /dts-v1/;
 
-#include "bcm4708.dtsi"
+#include "bcm4709.dtsi"
 #include "bcm5301x-nand-cs0-bch8.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts b/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
index 0653e7e..aab39c9 100644
--- a/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
+++ b/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
@@ -9,7 +9,7 @@
 
 /dts-v1/;
 
-#include "bcm4708.dtsi"
+#include "bcm4709.dtsi"
 #include "bcm5301x-nand-cs0-bch8.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/bcm4709-netgear-r7000.dts b/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
index a22ed14..fd38d2a 100644
--- a/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
+++ b/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
@@ -9,7 +9,7 @@
 
 /dts-v1/;
 
-#include "bcm4708.dtsi"
+#include "bcm4709.dtsi"
 #include "bcm5301x-nand-cs0-bch8.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
index ca18151..92f8a72 100644
--- a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
+++ b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
@@ -9,7 +9,7 @@
 
 /dts-v1/;
 
-#include "bcm4708.dtsi"
+#include "bcm4709.dtsi"
 #include "bcm5301x-nand-cs0-bch8.dtsi"
 
 / {
@@ -107,6 +107,10 @@
 	};
 };
 
+&uart0 {
+	status = "okay";
+};
+
 &usb2 {
 	vcc-gpio = <&chipcommon 0 GPIO_ACTIVE_HIGH>;
 };
diff --git a/arch/arm/boot/dts/bcm4709.dtsi b/arch/arm/boot/dts/bcm4709.dtsi
new file mode 100644
index 0000000..f039765
--- /dev/null
+++ b/arch/arm/boot/dts/bcm4709.dtsi
@@ -0,0 +1,11 @@
+/*
+ * Copyright (C) 2016 Rafa? Mi?ecki <rafal@milecki.pl>
+ *
+ * Licensed under the ISC license.
+ */
+
+#include "bcm4708.dtsi"
+
+&uart0 {
+	clock-frequency = <125000000>;
+};
-- 
2.9.3
