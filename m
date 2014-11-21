From: arno@natisbad.org (Arnaud Ebalard)
Date: Fri, 21 Nov 2014 20:45:59 +0100
Subject: [PATCHv5 07/10] arm: mvebu: define and use common Armada XP UART2/3
 pinctrl settings
In-Reply-To: <cover.1416598536.git.arno@natisbad.org>
References: <cover.1416598536.git.arno@natisbad.org>
Message-ID: <31e3c46bf4794c08aae4e92099c840c792f19c3b.1416598537.git.arno@natisbad.org>
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
index b59a83cf2f26..7cefb9b6d27c 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -55,6 +55,8 @@
 
 			uart2: serial at 12200 {
 				compatible = "snps,dw-apb-uart";
+				pinctrl-0 = <&uart2_pins>;
+				pinctrl-names = "default";
 				reg = <0x12200 0x100>;
 				reg-shift = <2>;
 				interrupts = <43>;
@@ -65,6 +67,8 @@
 
 			uart3: serial at 12300 {
 				compatible = "snps,dw-apb-uart";
+				pinctrl-0 = <&uart3_pins>;
+				pinctrl-names = "default";
 				reg = <0x12300 0x100>;
 				reg-shift = <2>;
 				interrupts = <44>;
@@ -235,4 +239,14 @@
 			       "mpp33", "mpp34", "mpp35";
 		marvell,function = "sd0";
 	};
+
+	uart2_pins: uart2-pins {
+		marvell,pins = "mpp42", "mpp43";
+		marvell,function = "uart2";
+	};
+
+	uart3_pins: uart3-pins {
+		marvell,pins = "mpp44", "mpp45";
+		marvell,function = "uart3";
+	};
 };
-- 
2.1.1
