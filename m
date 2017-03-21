From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 21 Mar 2017 11:07:38 +0100
Subject: [PATCH] arm: spear6xx: add labels to various nodes in spear600.dtsi
Message-ID: <1490090858-8866-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Having labels allows to more easily reference nodes in .dts files
including spear600.dtsi.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/spear600.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/spear600.dtsi b/arch/arm/boot/dts/spear600.dtsi
index 9f60a7b..55b23f5 100644
--- a/arch/arm/boot/dts/spear600.dtsi
+++ b/arch/arm/boot/dts/spear600.dtsi
@@ -57,7 +57,7 @@
 			status = "disabled";
 		};
 
-		dma at fc400000 {
+		dmac: dma at fc400000 {
 			compatible = "arm,pl080", "arm,primecell";
 			reg = <0xfc400000 0x1000>;
 			interrupt-parent = <&vic1>;
@@ -97,7 +97,7 @@
 			status = "disabled";
 		};
 
-		ehci at e1800000 {
+		ehci_usb0: ehci at e1800000 {
 			compatible = "st,spear600-ehci", "usb-ehci";
 			reg = <0xe1800000 0x1000>;
 			interrupt-parent = <&vic1>;
@@ -105,7 +105,7 @@
 			status = "disabled";
 		};
 
-		ehci at e2000000 {
+		ehci_usb1: ehci at e2000000 {
 			compatible = "st,spear600-ehci", "usb-ehci";
 			reg = <0xe2000000 0x1000>;
 			interrupt-parent = <&vic1>;
@@ -113,7 +113,7 @@
 			status = "disabled";
 		};
 
-		ohci at e1900000 {
+		ohci_usb0: ohci at e1900000 {
 			compatible = "st,spear600-ohci", "usb-ohci";
 			reg = <0xe1900000 0x1000>;
 			interrupt-parent = <&vic1>;
@@ -121,7 +121,7 @@
 			status = "disabled";
 		};
 
-		ohci at e2100000 {
+		ohci_usb1: ohci at e2100000 {
 			compatible = "st,spear600-ohci", "usb-ohci";
 			reg = <0xe2100000 0x1000>;
 			interrupt-parent = <&vic1>;
@@ -135,7 +135,7 @@
 			compatible = "simple-bus";
 			ranges = <0xd0000000 0xd0000000 0x30000000>;
 
-			serial at d0000000 {
+			uart0: serial at d0000000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0xd0000000 0x1000>;
 				interrupt-parent = <&vic0>;
@@ -143,7 +143,7 @@
 				status = "disabled";
 			};
 
-			serial at d0080000 {
+			uart1: serial at d0080000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0xd0080000 0x1000>;
 				interrupt-parent = <&vic0>;
-- 
2.7.4
