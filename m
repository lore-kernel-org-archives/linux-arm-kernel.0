From: jaz@semihalf.com (Grzegorz Jaszczyk)
Date: Thu, 21 Jul 2016 14:44:08 +0200
Subject: [PATCH 11/18] ARM: mvebu: a39x: add missing nodes describing GPIO's
In-Reply-To: <1469105055-25181-1-git-send-email-jaz@semihalf.com>
References: <1469105055-25181-1-git-send-email-jaz@semihalf.com>
Message-ID: <1469105055-25181-13-git-send-email-jaz@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The whole Armada 39x SoC family of processors has GPIO's which all can be
supported with existing driver.

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
---
 arch/arm/boot/dts/armada-39x.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/armada-39x.dtsi b/arch/arm/boot/dts/armada-39x.dtsi
index 5e01438..0749878 100644
--- a/arch/arm/boot/dts/armada-39x.dtsi
+++ b/arch/arm/boot/dts/armada-39x.dtsi
@@ -55,6 +55,8 @@
 	compatible = "marvell,armada390";
 
 	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
@@ -274,6 +276,34 @@
 				};
 			};
 
+			gpio0: gpio at 18100 {
+				compatible = "marvell,orion-gpio";
+				reg = <0x18100 0x40>;
+				ngpios = <32>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			gpio1: gpio at 18140 {
+				compatible = "marvell,orion-gpio";
+				reg = <0x18140 0x40>;
+				ngpios = <28>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
 			system-controller at 18200 {
 				compatible = "marvell,armada-390-system-controller",
 					     "marvell,armada-370-xp-system-controller";
-- 
1.8.3.1
