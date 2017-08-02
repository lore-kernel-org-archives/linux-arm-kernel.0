From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Wed,  2 Aug 2017 06:40:41 +0200
Subject: [PATCH] ARM: dts: BCM5301X: Specify USB ports for USB LEDs of few
 devices
Message-ID: <20170802044041.3626-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

This uses trigger-sources documented in commit 80dc6e1cd85fc ("dt-bindings:
leds: document new trigger-sources property") to specify USB ports. Such an
information can be used by operating system to setup LEDs behavior.

I updated dts files for 7 devices I own and I was able to test.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  | 4 ++++
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts        | 3 +++
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts      | 6 ++++++
 arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts | 4 ++++
 arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts  | 5 +++++
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts      | 3 +++
 arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts      | 3 +++
 7 files changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
index 62e1427b3f10..8b64caabaad8 100644
--- a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
+++ b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
@@ -52,6 +52,10 @@
 		usb {
 			label = "bcm53xx:blue:usb";
 			gpios = <&hc595 0 GPIO_ACTIVE_HIGH>;
+			trigger-sources = <&ohci_port1>, <&ehci_port1>,
+					  <&xhci_port1>, <&ohci_port2>,
+					  <&ehci_port2>;
+			linux,default-trigger = "usbport";
 		};
 
 		power0 {
diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
index a5647efe4118..d7c34fa72b4b 100644
--- a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
+++ b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
@@ -48,6 +48,9 @@
 		usb {
 			label = "bcm53xx:blue:usb";
 			gpios = <&chipcommon 8 GPIO_ACTIVE_LOW>;
+			trigger-sources = <&ohci_port1>, <&ehci_port1>,
+					  <&xhci_port1>;
+			linux,default-trigger = "usbport";
 		};
 
 		wireless {
diff --git a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
index 19ee924d7d53..83a4c60bb431 100644
--- a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
+++ b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
@@ -42,16 +42,22 @@
 		usb2 {
 			label = "bcm53xx:white:usb2";
 			gpios = <&chipcommon 3 GPIO_ACTIVE_HIGH>;
+			trigger-sources = <&ohci_port2>, <&ehci_port2>;
+			linux,default-trigger = "usbport";
 		};
 
 		usb3-white {
 			label = "bcm53xx:white:usb3";
 			gpios = <&chipcommon 4 GPIO_ACTIVE_HIGH>;
+			trigger-sources = <&xhci_port1>;
+			linux,default-trigger = "usbport";
 		};
 
 		usb3-green {
 			label = "bcm53xx:green:usb3";
 			gpios = <&chipcommon 5 GPIO_ACTIVE_HIGH>;
+			trigger-sources = <&ohci_port1>, <&ehci_port1>;
+			linux,default-trigger = "usbport";
 		};
 
 		wps {
diff --git a/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts b/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts
index a854a5174b7f..3ed8de42cb48 100644
--- a/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts
+++ b/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts
@@ -36,6 +36,8 @@
 		usb2-port1 {
 			label = "bcm53xx:green:usb2-port1";
 			gpios = <&chipcommon 2 GPIO_ACTIVE_HIGH>;
+			trigger-sources = <&ohci_port1>, <&ehci_port1>;
+			linux,default-trigger = "usbport";
 		};
 
 		power {
@@ -67,6 +69,8 @@
 		usb2-port2 {
 			label = "bcm53xx:green:usb2-port2";
 			gpios = <&chipcommon 13 GPIO_ACTIVE_HIGH>;
+			trigger-sources = <&ohci_port2>, <&ehci_port2>;
+			linux,default-trigger = "usbport";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts b/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
index 97aa5d59a1d8..ec4a50e440f6 100644
--- a/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
+++ b/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
@@ -46,11 +46,16 @@
 		usb3 {
 			label = "bcm53xx:blue:usb3";
 			gpios = <&chipcommon 6 GPIO_ACTIVE_HIGH>;
+			trigger-sources = <&ohci_port1>, <&ehci_port1>,
+					  <&xhci_port1>;
+			linux,default-trigger = "usbport";
 		};
 
 		usb2 {
 			label = "bcm53xx:blue:usb2";
 			gpios = <&chipcommon 7 GPIO_ACTIVE_HIGH>;
+			trigger-sources = <&ohci_port2>, <&ehci_port2>;
+			linux,default-trigger = "usbport";
 		};
 
 		wan-blue {
diff --git a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
index 51b0641b5f79..7cc7d344fe5b 100644
--- a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
+++ b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
@@ -71,6 +71,9 @@
 		usb3-white {
 			label = "bcm53xx:white:usb3";
 			gpios = <&chipcommon 8 GPIO_ACTIVE_LOW>;
+			trigger-sources = <&ohci_port1>, <&ehci_port1>,
+					  <&xhci_port1>;
+			linux,default-trigger = "usbport";
 		};
 
 		2ghz {
diff --git a/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts b/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
index 5f8621d00c50..bc1d1e10d4ac 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
@@ -59,6 +59,9 @@
 		usb3	{
 			label = "bcm53xx:green:usb3";
 			gpios = <&chipcommon 8 GPIO_ACTIVE_LOW>;
+			trigger-sources = <&ohci_port1>, <&ehci_port1>,
+					  <&xhci_port1>;
+			linux,default-trigger = "usbport";
 		};
 
 		status	{
-- 
2.11.0
