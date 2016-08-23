From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 23 Aug 2016 13:58:26 +0800
Subject: [PATCH 2/2] ARM: dts: sun8i: Add extra UART pinmux settings for A23/33
In-Reply-To: <20160823055826.20591-1-icenowy@aosc.xyz>
References: <20160823055826.20591-1-icenowy@aosc.xyz>
Message-ID: <20160823055826.20591-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A23/33 have 4 UART controllers outside PRCM. However, the devicetree used
to mentioned only UART0's pinmux settings. Some extra UART controllers have
RTS/CTS, and is suitable for using as bluetooth UART controller.

Add the pinmux settings for the UART controller, to make use of the
bluetooth function of some tablets.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 56 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/sun8i-a23.dtsi     |  7 +++++
 2 files changed, 63 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 7e05e09..89ea479 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -361,6 +361,62 @@
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
+			uart1_pins_a: uart1 at 0 {
+				allwinner,pins = "PD10", "PD11";
+				allwinner,function = "uart1";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart1_pins_cts_rts_a: uart1-cts-rts at 1 {
+				allwinner,pins = "PD12", "PD13";
+				allwinner,function = "uart1";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart1_pins_b: uart1 at 1 {
+				allwinner,pins = "PG6", "PG7";
+				allwinner,function = "uart1";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart1_pins_cts_rts_b: uart1-cts-rts at 0 {
+				allwinner,pins = "PG8", "PG9";
+				allwinner,function = "uart1";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart2_pins_a: uart2 at 0 {
+				allwinner,pins = "PB0", "PB1";
+				allwinner,function = "uart2";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart2_pins_cts_rts_a: uart2-cts-rts at 1 {
+				allwinner,pins = "PB2", "PB3";
+				allwinner,function = "uart2";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart3_pins_a: uart3 at 0 {
+				allwinner,pins = "PH6", "PH7";
+				allwinner,function = "uart3";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart3_pins_cts_rts_a: uart3-cts-rts at 1 {
+				allwinner,pins = "PH8", "PH9";
+				allwinner,function = "uart3";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
 			mmc0_pins_a: mmc0 at 0 {
 				allwinner,pins = "PF0", "PF1", "PF2",
 						 "PF3", "PF4", "PF5";
diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 92e6616..6b76580 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -123,4 +123,11 @@
 	interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
 		     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
 		     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+
+	uart3_pins_b: uart3 at 0 {
+		allwinner,pins = "PD8", "PD9";
+		allwinner,function = "uart3";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
 };
-- 
2.9.3
