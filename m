From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Wed, 21 Sep 2016 22:58:32 +0200
Subject: [PATCH 1/3] ARM: BCM5301X: Add separated DTS include file for BCM47094
Message-ID: <20160921205838.15627-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

Use it to store BCM47094 specific properties/values and avoid repeating
them in device DTS files.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts |  3 +--
 arch/arm/boot/dts/bcm47094-netgear-r8500.dts  |  3 +--
 arch/arm/boot/dts/bcm47094.dtsi               | 11 +++++++++++
 3 files changed, 13 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm47094.dtsi

diff --git a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
index c8c0b36..661348d 100644
--- a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
+++ b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
@@ -9,7 +9,7 @@
 
 /dts-v1/;
 
-#include "bcm4708.dtsi"
+#include "bcm47094.dtsi"
 #include "bcm5301x-nand-cs0-bch1.dtsi"
 
 / {
@@ -107,7 +107,6 @@
 
 &uart0 {
 	status = "okay";
-	clock-frequency = <125000000>;
 };
 
 &usb3 {
diff --git a/arch/arm/boot/dts/bcm47094-netgear-r8500.dts b/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
index 10db4f8..521b415 100644
--- a/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
+++ b/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
@@ -6,7 +6,7 @@
 
 /dts-v1/;
 
-#include "bcm4708.dtsi"
+#include "bcm47094.dtsi"
 #include "bcm5301x-nand-cs0-bch8.dtsi"
 
 / {
@@ -100,5 +100,4 @@
 
 &uart0 {
 	status = "okay";
-	clock-frequency = <125000000>;
 };
diff --git a/arch/arm/boot/dts/bcm47094.dtsi b/arch/arm/boot/dts/bcm47094.dtsi
new file mode 100644
index 0000000..f039765
--- /dev/null
+++ b/arch/arm/boot/dts/bcm47094.dtsi
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
