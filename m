From: jaz@semihalf.com (Grzegorz Jaszczyk)
Date: Thu,  4 Aug 2016 12:14:14 +0200
Subject: [PATCH v2 11/17] ARM: dts: mvebu: armada-39x: add missing nodes
 describing USB2.0 and USB3.0
In-Reply-To: <1470305660-6601-1-git-send-email-jaz@semihalf.com>
References: <1470305660-6601-1-git-send-email-jaz@semihalf.com>
Message-ID: <1470305660-6601-12-git-send-email-jaz@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The whole Armada 39x SoC family of processors has one USB2.0 and one
USB3.0 which all can be supported with existing drivers.

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-39x.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/armada-39x.dtsi b/arch/arm/boot/dts/armada-39x.dtsi
index 0749878..1225cd8 100644
--- a/arch/arm/boot/dts/armada-39x.dtsi
+++ b/arch/arm/boot/dts/armada-39x.dtsi
@@ -381,6 +381,14 @@
 				reg = <0x22000 0x1000>;
 			};
 
+			usb at 58000 {
+				compatible = "marvell,orion-ehci";
+				reg = <0x58000 0x500>;
+				interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gateclk 18>;
+				status = "disabled";
+			};
+
 			xor at 60800 {
 				compatible = "marvell,armada-380-xor", "marvell,orion-xor";
 				reg = <0x60800 0x100
@@ -457,6 +465,14 @@
 				reg = <0xe4078 0x4>, <0xe4074 0x4>;
 				status = "okay";
 			};
+
+			usb3 at f8000 {
+				compatible = "marvell,armada-380-xhci";
+				reg = <0xf8000 0x4000>,<0xfc000 0x4000>;
+				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gateclk 10>;
+				status = "disabled";
+			};
 		};
 
 		pcie-controller {
-- 
1.8.3.1
