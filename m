From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 20 Feb 2014 12:11:31 +0100
Subject: [PATCH 3/3] ARM: mvebu: use macros for interrupt flags on Armada
 375/38x
In-Reply-To: <1392894691-26837-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392894691-26837-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1392894691-26837-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of hardcoding the values of the interrupt flags, use the
macros provided by <include/dt-bindings/interrupt-controller/irq.h>
and <include/dt-bindings/interrupt-controller/arm-gic.h> for the
Armada 375 and Armada 38x Device Tree files.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 57 +++++++++++++++++++++------------------
 arch/arm/boot/dts/armada-380.dtsi |  6 ++---
 arch/arm/boot/dts/armada-385.dtsi |  8 +++---
 arch/arm/boot/dts/armada-38x.dtsi | 45 +++++++++++++++++--------------
 4 files changed, 63 insertions(+), 53 deletions(-)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 23d497f..3877693 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -13,6 +13,7 @@
 
 #include "skeleton.dtsi"
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 #define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
 
@@ -130,7 +131,7 @@
 			timer@c600 {
 				compatible = "arm,cortex-a9-twd-timer";
 				reg = <0xc600 0x20>;
-				interrupts = <GIC_PPI 13 0x301>;
+				interrupts = <GIC_PPI 13 (IRQ_TYPE_EDGE_RISING | GIC_CPU_MASK_SIMPLE(2))>;
 				clocks = <&coreclk 2>;
 			};
 
@@ -149,7 +150,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				cell-index = <0>;
-				interrupts = <GIC_SPI 1 0x4>;
+				interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&coreclk 0>;
 				status = "disabled";
 			};
@@ -160,7 +161,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				cell-index = <1>;
-				interrupts = <GIC_SPI 63 0x4>;
+				interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&coreclk 0>;
 				status = "disabled";
 			};
@@ -170,7 +171,7 @@
 				reg = <0x11000 0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interrupts = <GIC_SPI 2 0x4>;
+				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 				timeout-ms = <1000>;
 				clocks = <&coreclk 0>;
 				status = "disabled";
@@ -181,7 +182,7 @@
 				reg = <0x11100 0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interrupts = <GIC_SPI 3 0x4>;
+				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 				timeout-ms = <1000>;
 				clocks = <&coreclk 0>;
 				status = "disabled";
@@ -191,7 +192,7 @@
 				compatible = "snps,dw-apb-uart";
 				reg = <0x12000 0x100>;
 				reg-shift = <2>;
-				interrupts = <GIC_SPI 12 4>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 				reg-io-width = <1>;
 				status = "disabled";
 			};
@@ -200,7 +201,7 @@
 				compatible = "snps,dw-apb-uart";
 				reg = <0x12100 0x100>;
 				reg-shift = <2>;
-				interrupts = <GIC_SPI 13 4>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
 				reg-io-width = <1>;
 				status = "disabled";
 			};
@@ -249,8 +250,10 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
-				interrupts = <GIC_SPI 53 0x4>, <GIC_SPI 54 0x4>,
-					     <GIC_SPI 55 0x4>, <GIC_SPI 56 0x4>;
+				interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			gpio1: gpio at 18140 {
@@ -261,8 +264,10 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
-				interrupts = <GIC_SPI 58 0x4>, <GIC_SPI 59 0x4>,
-					     <GIC_SPI 60 0x4>, <GIC_SPI 61 0x4>;
+				interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			gpio2: gpio at 18180 {
@@ -273,7 +278,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
-				interrupts = <GIC_SPI 62 0x4>;
+				interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			system-controller at 18200 {
@@ -300,16 +305,16 @@
 				#size-cells = <1>;
 				interrupt-controller;
 				msi-controller;
-				interrupts = <GIC_PPI 15 0x4>;
+				interrupts = <GIC_PPI 15 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			timer at 20300 {
 				compatible = "marvell,armada-375-timer", "marvell,armada-370-timer";
 				reg = <0x20300 0x30>, <0x21040 0x30>;
-				interrupts-extended = <&gic  GIC_SPI  8 4>,
-						      <&gic  GIC_SPI  9 4>,
-						      <&gic  GIC_SPI 10 4>,
-						      <&gic  GIC_SPI 11 4>,
+				interrupts-extended = <&gic  GIC_SPI  8 IRQ_TYPE_LEVEL_HIGH>,
+						      <&gic  GIC_SPI  9 IRQ_TYPE_LEVEL_HIGH>,
+						      <&gic  GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+						      <&gic  GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
 						      <&mpic 5>,
 						      <&mpic 6>;
 				clocks = <&coreclk 0>;
@@ -323,12 +328,12 @@
 				status = "okay";
 
 				xor00 {
-					interrupts = <GIC_SPI 22 0x4>;
+					interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
 					dmacap,memcpy;
 					dmacap,xor;
 				};
 				xor01 {
-					interrupts = <GIC_SPI 23 0x4>;
+					interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 					dmacap,memcpy;
 					dmacap,xor;
 					dmacap,memset;
@@ -343,12 +348,12 @@
 				status = "okay";
 
 				xor10 {
-					interrupts = <GIC_SPI 65 0x4>;
+					interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 					dmacap,memcpy;
 					dmacap,xor;
 				};
 				xor11 {
-					interrupts = <GIC_SPI 66 0x4>;
+					interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
 					dmacap,memcpy;
 					dmacap,xor;
 					dmacap,memset;
@@ -358,7 +363,7 @@
 			sata at a0000 {
 				compatible = "marvell,orion-sata";
 				reg = <0xa0000 0x5000>;
-				interrupts = <GIC_SPI 26 0x4>;
+				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gateclk 14>, <&gateclk 20>;
 				clock-names = "0", "1";
 				status = "disabled";
@@ -369,7 +374,7 @@
 				reg = <0xd0000 0x54>;
 				#address-cells = <1>;
 				#size-cells = <1>;
-				interrupts = <GIC_SPI 84 0x4>;
+				interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gateclk 11>;
 				status = "disabled";
 			};
@@ -377,7 +382,7 @@
 			mvsdio at d4000 {
 				compatible = "marvell,orion-sdio";
 				reg = <0xd4000 0x200>;
-				interrupts = <GIC_SPI 25 0x4>;
+				interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gateclk 17>;
 				bus-width = <4>;
 				cap-sdio-irq;
@@ -430,7 +435,7 @@
 				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
 					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
 				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &gic GIC_SPI 29 0x4>;
+				interrupt-map = <0 0 0 0 &gic GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 				marvell,pcie-port = <0>;
 				marvell,pcie-lane = <0>;
 				clocks = <&gateclk 5>;
@@ -447,7 +452,7 @@
 				ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
 					  0x81000000 0 0 0x81000000 0x2 0 1 0>;
 				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &gic GIC_SPI 33 0x4>;
+				interrupt-map = <0 0 0 0 &gic GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 				marvell,pcie-port = <0>;
 				marvell,pcie-lane = <1>;
 				clocks = <&gateclk 6>;
diff --git a/arch/arm/boot/dts/armada-380.dtsi b/arch/arm/boot/dts/armada-380.dtsi
index 678ba3d..068031f 100644
--- a/arch/arm/boot/dts/armada-380.dtsi
+++ b/arch/arm/boot/dts/armada-380.dtsi
@@ -70,7 +70,7 @@
 				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
 					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
 				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &gic GIC_SPI 29 0x4>;
+				interrupt-map = <0 0 0 0 &gic GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 				marvell,pcie-port = <0>;
 				marvell,pcie-lane = <0>;
 				clocks = <&gateclk 8>;
@@ -88,7 +88,7 @@
 				ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
 					  0x81000000 0 0 0x81000000 0x2 0 1 0>;
 				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &gic GIC_SPI 33 0x4>;
+				interrupt-map = <0 0 0 0 &gic GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 				marvell,pcie-port = <1>;
 				marvell,pcie-lane = <0>;
 				clocks = <&gateclk 5>;
@@ -106,7 +106,7 @@
 				ranges = <0x82000000 0 0 0x82000000 0x3 0 1 0
 					  0x81000000 0 0 0x81000000 0x3 0 1 0>;
 				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &gic GIC_SPI 70 0x4>;
+				interrupt-map = <0 0 0 0 &gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 				marvell,pcie-port = <2>;
 				marvell,pcie-lane = <0>;
 				clocks = <&gateclk 6>;
diff --git a/arch/arm/boot/dts/armada-385.dtsi b/arch/arm/boot/dts/armada-385.dtsi
index 055bc2f..e2919f0 100644
--- a/arch/arm/boot/dts/armada-385.dtsi
+++ b/arch/arm/boot/dts/armada-385.dtsi
@@ -81,7 +81,7 @@
 				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
 					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
 				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &gic GIC_SPI 29 0x4>;
+				interrupt-map = <0 0 0 0 &gic GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 				marvell,pcie-port = <0>;
 				marvell,pcie-lane = <0>;
 				clocks = <&gateclk 8>;
@@ -99,7 +99,7 @@
 				ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
 					  0x81000000 0 0 0x81000000 0x2 0 1 0>;
 				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &gic GIC_SPI 33 0x4>;
+				interrupt-map = <0 0 0 0 &gic GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 				marvell,pcie-port = <1>;
 				marvell,pcie-lane = <0>;
 				clocks = <&gateclk 5>;
@@ -117,7 +117,7 @@
 				ranges = <0x82000000 0 0 0x82000000 0x3 0 1 0
 					  0x81000000 0 0 0x81000000 0x3 0 1 0>;
 				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &gic GIC_SPI 70 0x4>;
+				interrupt-map = <0 0 0 0 &gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 				marvell,pcie-port = <2>;
 				marvell,pcie-lane = <0>;
 				clocks = <&gateclk 6>;
@@ -138,7 +138,7 @@
 				ranges = <0x82000000 0 0 0x82000000 0x4 0 1 0
 					  0x81000000 0 0 0x81000000 0x4 0 1 0>;
 				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &gic GIC_SPI 71 0x4>;
+				interrupt-map = <0 0 0 0 &gic GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 				marvell,pcie-port = <3>;
 				marvell,pcie-lane = <0>;
 				clocks = <&gateclk 7>;
diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 502d21a..812ce28 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -14,6 +14,7 @@
 
 #include "skeleton.dtsi"
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 #define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
 
@@ -110,7 +111,7 @@
 			timer@c600 {
 				compatible = "arm,cortex-a9-twd-timer";
 				reg = <0xc600 0x20>;
-				interrupts = <GIC_PPI 13 0x301>;
+				interrupts = <GIC_PPI 13 (IRQ_TYPE_EDGE_RISING | GIC_CPU_MASK_SIMPLE(2))>;
 				clocks = <&coreclk 2>;
 			};
 
@@ -129,7 +130,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				cell-index = <0>;
-				interrupts = <GIC_SPI 1 0x4>;
+				interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&coreclk 0>;
 				status = "disabled";
 			};
@@ -140,7 +141,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				cell-index = <1>;
-				interrupts = <GIC_SPI 63 0x4>;
+				interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&coreclk 0>;
 				status = "disabled";
 			};
@@ -150,7 +151,7 @@
 				reg = <0x11000 0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interrupts = <GIC_SPI 2 0x4>;
+				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 				timeout-ms = <1000>;
 				clocks = <&coreclk 0>;
 				status = "disabled";
@@ -161,7 +162,7 @@
 				reg = <0x11100 0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interrupts = <GIC_SPI 3 0x4>;
+				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 				timeout-ms = <1000>;
 				clocks = <&coreclk 0>;
 				status = "disabled";
@@ -171,7 +172,7 @@
 				compatible = "snps,dw-apb-uart";
 				reg = <0x12000 0x100>;
 				reg-shift = <2>;
-				interrupts = <GIC_SPI 12 4>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 				reg-io-width = <1>;
 				status = "disabled";
 			};
@@ -180,7 +181,7 @@
 				compatible = "snps,dw-apb-uart";
 				reg = <0x12100 0x100>;
 				reg-shift = <2>;
-				interrupts = <GIC_SPI 13 4>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
 				reg-io-width = <1>;
 				status = "disabled";
 			};
@@ -198,8 +199,10 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
-				interrupts = <GIC_SPI 53 0x4>, <GIC_SPI 54 0x4>,
-					     <GIC_SPI 55 0x4>, <GIC_SPI 56 0x4>;
+				interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			gpio1: gpio at 18140 {
@@ -210,8 +213,10 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
-				interrupts = <GIC_SPI 58 0x4>, <GIC_SPI 59 0x4>,
-					     <GIC_SPI 60 0x4>, <GIC_SPI 61 0x4>;
+				interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			system-controller at 18200 {
@@ -245,17 +250,17 @@
 				#size-cells = <1>;
 				interrupt-controller;
 				msi-controller;
-				interrupts = <GIC_PPI 15 0x4>;
+				interrupts = <GIC_PPI 15 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			timer at 20300 {
 				compatible = "marvell,armada-380-timer",
 					     "marvell,armada-xp-timer";
 				reg = <0x20300 0x30>, <0x21040 0x30>;
-				interrupts-extended = <&gic  GIC_SPI  8 4>,
-						      <&gic  GIC_SPI  9 4>,
-						      <&gic  GIC_SPI 10 4>,
-						      <&gic  GIC_SPI 11 4>,
+				interrupts-extended = <&gic  GIC_SPI  8 IRQ_TYPE_LEVEL_HIGH>,
+						      <&gic  GIC_SPI  9 IRQ_TYPE_LEVEL_HIGH>,
+						      <&gic  GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+						      <&gic  GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
 						      <&mpic 5>,
 						      <&mpic 6>;
 				clocks = <&coreclk 2>, <&refclk>;
@@ -286,12 +291,12 @@
 				status = "okay";
 
 				xor00 {
-					interrupts = <GIC_SPI 22 0x4>;
+					interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
 					dmacap,memcpy;
 					dmacap,xor;
 				};
 				xor01 {
-					interrupts = <GIC_SPI 23 0x4>;
+					interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 					dmacap,memcpy;
 					dmacap,xor;
 					dmacap,memset;
@@ -306,12 +311,12 @@
 				status = "okay";
 
 				xor10 {
-					interrupts = <GIC_SPI 65 0x4>;
+					interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 					dmacap,memcpy;
 					dmacap,xor;
 				};
 				xor11 {
-					interrupts = <GIC_SPI 66 0x4>;
+					interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
 					dmacap,memcpy;
 					dmacap,xor;
 					dmacap,memset;
-- 
1.8.3.2
