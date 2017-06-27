From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Tue, 27 Jun 2017 19:35:27 +0200
Subject: [PATCH] ARM: dts: BCM5301X: Specify USB ports for each controller
Message-ID: <20170627173527.16682-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

Northstar has 3 controllers: OHCI and EHCI (each with 2 ports) and XHCI
(with just 1 port). Describe them in the DT. In future this will allow
to reference them as trigger sources.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/bcm5301x.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 98647d22b291..045b9bb857f9 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -272,6 +272,19 @@
 				reg = <0x00021000 0x1000>;
 				interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&usb2_phy>;
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ehci_port1: port at 1 {
+					reg = <1>;
+					#trigger-source-cells = <0>;
+				};
+
+				ehci_port2: port at 2 {
+					reg = <2>;
+					#trigger-source-cells = <0>;
+				};
 			};
 
 			ohci: ohci at 22000 {
@@ -280,6 +293,19 @@
 				compatible = "generic-ohci";
 				reg = <0x00022000 0x1000>;
 				interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ohci_port1: port at 1 {
+					reg = <1>;
+					#trigger-source-cells = <0>;
+				};
+
+				ohci_port2: port at 2 {
+					reg = <2>;
+					#trigger-source-cells = <0>;
+				};
 			};
 		};
 
@@ -300,6 +326,14 @@
 				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&usb3_phy>;
 				phy-names = "usb";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				xhci_port1: port at 1 {
+					reg = <1>;
+					#trigger-source-cells = <0>;
+				};
 			};
 		};
 
-- 
2.11.0
