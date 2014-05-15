From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 15 May 2014 17:15:23 +0200
Subject: [PATCH 1/2] ARM: at91/dt: add DMA controller node to at91sam9rl
Message-ID: <47a342121566bca0025a20a57282fb72c990ce09.1400166895.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9rl.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index 6e6e87dd0c92..412617084cfd 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -348,6 +348,15 @@
 				};
 			};
 
+			dma0: dma-controller at ffffe600 {
+				compatible = "atmel,at91sam9rl-dma";
+				reg = <0xffffe600 0x200>;
+				interrupts = <21 IRQ_TYPE_LEVEL_HIGH 0>;
+				#dma-cells = <2>;
+				clocks = <&dma0_clk>;
+				clock-names = "dma_clk";
+			};
+
 			ramc0: ramc at ffffea00 {
 				compatible = "atmel,at91sam9260-sdramc";
 				reg = <0xffffea00 0x200>;
-- 
1.8.2.2
