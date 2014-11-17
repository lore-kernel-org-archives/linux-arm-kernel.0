From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 18 Nov 2014 00:27:58 +0100
Subject: [PATCHv3 08/12] arm: mvebu: define and use common Armada XP UART2/3
 pinctrl settings
In-Reply-To: <cover.1416266432.git.arno@natisbad.org>
References: <cover.1416266432.git.arno@natisbad.org>
Message-ID: <92e99f389c8f7a41221995e4cbebfeffb14e8da8.1416266432.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch defines common Armada XP pinctrl settings for uart2 and
uart3 interfaces (uart0 and uart1 rx/tx do not rely on MPP):

 uart2: MPP42-43 as default
 uart3: MPP44-45 as default

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/armada-xp.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 83bf32344a60..c7449f652fb5 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -48,6 +48,16 @@
 						       "mpp33", "mpp34", "mpp35";
 					marvell,function = "sd0";
 				};
+
+				uart2_pins: uart2-pins {
+					marvell,pins = "mpp42", "mpp43";
+					marvell,function = "uart2";
+				};
+
+				uart3_pins: uart3-pins {
+					marvell,pins = "mpp44", "mpp45";
+					marvell,function = "uart3";
+				};
 			};
 
 			i2c0: i2c at 11000 {
@@ -62,6 +72,8 @@
 
 			uart2: serial at 12200 {
 				compatible = "snps,dw-apb-uart";
+				pinctrl-0 = <&uart2_pins>;
+				pinctrl-names = "default";
 				reg = <0x12200 0x100>;
 				reg-shift = <2>;
 				interrupts = <43>;
@@ -72,6 +84,8 @@
 
 			uart3: serial at 12300 {
 				compatible = "snps,dw-apb-uart";
+				pinctrl-0 = <&uart3_pins>;
+				pinctrl-names = "default";
 				reg = <0x12300 0x100>;
 				reg-shift = <2>;
 				interrupts = <44>;
-- 
2.1.1
