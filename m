From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Thu, 17 Aug 2017 11:05:14 +0200
Subject: [PATCH] ARM: BCM53573: Specify ports for USB LED for Tenda AC9
Message-ID: <20170817090514.4503-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

This uses trigger-sources documented in commit 80dc6e1cd85fc ("dt-bindings:
leds: document new trigger-sources property") to specify USB ports. Such an
information can be used by operating system to setup LEDs behavior.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/bcm47189-tenda-ac9.dts | 2 ++
 arch/arm/boot/dts/bcm53573.dtsi          | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/bcm47189-tenda-ac9.dts b/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
index 34417dac1cd0..19e61b5b066c 100644
--- a/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
+++ b/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
@@ -26,6 +26,8 @@
 		usb {
 			label = "bcm53xx:blue:usb";
 			gpios = <&chipcommon 1 GPIO_ACTIVE_HIGH>;
+			trigger-sources = <&ohci_port1>, <&ehci_port1>;
+			linux,default-trigger = "usbport";
 		};
 
 		wps {
diff --git a/arch/arm/boot/dts/bcm53573.dtsi b/arch/arm/boot/dts/bcm53573.dtsi
index eae623f76401..c698a565b8ae 100644
--- a/arch/arm/boot/dts/bcm53573.dtsi
+++ b/arch/arm/boot/dts/bcm53573.dtsi
@@ -138,10 +138,12 @@
 
 				ehci_port1: port at 1 {
 					reg = <1>;
+					#trigger-source-cells = <0>;
 				};
 
 				ehci_port2: port at 2 {
 					reg = <2>;
+					#trigger-source-cells = <0>;
 				};
 			};
 
@@ -158,10 +160,12 @@
 
 				ohci_port1: port at 1 {
 					reg = <1>;
+					#trigger-source-cells = <0>;
 				};
 
 				ohci_port2: port at 2 {
 					reg = <2>;
+					#trigger-source-cells = <0>;
 				};
 			};
 		};
-- 
2.11.0
