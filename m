From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 4 Mar 2015 16:46:37 +0100
Subject: [PATCH] ARM: at91/dt: sama5d4: add pwm device node
Message-ID: <1425483997-14113-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bo Shen <voice.shen@atmel.com>

Signed-off-by: Bo Shen <voice.shen@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d4.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 93dc4e374b64..3041baaa19a1 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -64,6 +64,7 @@
 		gpio2 = &pioC;
 		gpio3 = &pioD;
 		gpio4 = &pioE;
+		pwm0 = &pwm0;
 		ssc0 = &ssc0;
 		ssc1 = &ssc1;
 		tcb0 = &tcb0;
@@ -821,6 +822,15 @@
 				status = "disabled";
 			};
 
+			pwm0: pwm at f800c000 {
+				compatible = "atmel,sama5d3-pwm";
+				reg = <0xf800c000 0x300>;
+				interrupts = <43 IRQ_TYPE_LEVEL_HIGH 4>;
+				#pwm-cells = <3>;
+				clocks = <&pwm_clk>;
+				status = "disabled";
+			};
+
 			spi0: spi at f8010000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.1.3
