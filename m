From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Wed,  6 Apr 2016 18:49:55 +0200
Subject: [PATCH] ARM: BCM5301X: Enable earlycon on tested devices
Message-ID: <1459961395-22702-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows reporting & debugging problems occurring early in the boot
process.

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  | 2 +-
 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts       | 2 +-
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts        | 2 +-
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts      | 2 +-
 arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts | 2 +-
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts      | 2 +-
 arch/arm/boot/dts/bcm5301x.dtsi                    | 4 ++++
 7 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
index fb62ed6..5087aa8 100644
--- a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
+++ b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
@@ -17,7 +17,7 @@
 	model = "Buffalo WZR-1750DHP (BCM4708)";
 
 	chosen {
-		bootargs = "console=ttyS0,115200";
+		bootargs = "console=ttyS0,115200 earlycon";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts b/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
index f18e80e..c973f768 100644
--- a/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
+++ b/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
@@ -17,7 +17,7 @@
 	model = "Luxul XWC-1000 (BCM4708)";
 
 	chosen {
-		bootargs = "console=ttyS0,115200";
+		bootargs = "console=ttyS0,115200 earlycon";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
index 6bebfa6..1049ab1 100644
--- a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
+++ b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
@@ -17,7 +17,7 @@
 	model = "Netgear R6250 V1 (BCM4708)";
 
 	chosen {
-		bootargs = "console=ttyS0,115200";
+		bootargs = "console=ttyS0,115200 earlycon";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
index 64a5e8a..4d610ff 100644
--- a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
+++ b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
@@ -17,7 +17,7 @@
 	model = "SmartRG SR400ac";
 
 	chosen {
-		bootargs = "console=ttyS0,115200";
+		bootargs = "console=ttyS0,115200 earlycon";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
index 38f0c00..a9c8def 100644
--- a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
+++ b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
@@ -17,7 +17,7 @@
 	model = "Buffalo WZR-600DHP2 (BCM47081)";
 
 	chosen {
-		bootargs = "console=ttyS0,115200";
+		bootargs = "console=ttyS0,115200 earlycon";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
index 9205c03..ace38ef 100644
--- a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
+++ b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
@@ -17,7 +17,7 @@
 	model = "D-Link DIR-885L";
 
 	chosen {
-		bootargs = "console=ttyS0,115200";
+		bootargs = "console=ttyS0,115200 earlycon";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index b3e9d28..9c06d91 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -18,6 +18,10 @@
 / {
 	interrupt-parent = <&gic>;
 
+	chosen {
+		stdout-path = &uart0;
+	};
+
 	chipcommonA {
 		compatible = "simple-bus";
 		ranges = <0x00000000 0x18000000 0x00001000>;
-- 
1.8.4.5
