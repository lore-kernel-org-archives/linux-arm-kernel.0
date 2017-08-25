From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 25 Aug 2017 11:26:16 +0200
Subject: [PATCH 4/5] arm: dts: sun8i: a83t: Add the UART1 controller
In-Reply-To: <20170825092617.32533-1-maxime.ripard@free-electrons.com>
References: <20170825092617.32533-1-maxime.ripard@free-electrons.com>
Message-ID: <20170825092617.32533-4-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A83T has an UART1 controller, with the RTS and CTS pins routed so it
can be used for devices with hardware flow control, like a bluetooth chip.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 91dee798f3ca..f6aaaa9a1fe2 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -373,6 +373,16 @@
 				pins = "PF2", "PF4";
 				function = "uart0";
 			};
+
+			uart1_pg_pins: uart1-pg-pins {
+				pins = "PG6", "PG7";
+				function = "uart1";
+			};
+
+			uart1_rtscts_pins: uart1-rtscts-pins {
+				pins = "PG8", "PG9";
+				function = "uart1";
+			};
 		};
 
 		timer at 1c20c00 {
@@ -417,6 +427,17 @@
 			status = "disabled";
 		};
 
+		uart1: serial at 01c28400 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c28400 0x400>;
+			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART1>;
+			resets = <&ccu RST_BUS_UART1>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller at 1c81000 {
 			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
 			reg = <0x01c81000 0x1000>,
-- 
2.13.5
