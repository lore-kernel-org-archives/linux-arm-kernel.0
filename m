From: mike@mikebwilliams.com (Mike Williams)
Date: Tue,  3 May 2016 12:44:24 -0400
Subject: [PATCH 3/3] ARM: at91/dt: sama5d4: add trng node
In-Reply-To: <1462293864-32551-1-git-send-email-mike@mikebwilliams.com>
References: <1462293864-32551-1-git-send-email-mike@mikebwilliams.com>
Message-ID: <1462293864-32551-4-git-send-email-mike@mikebwilliams.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node to support SAMA5D4 hardware random number generator.
---
 arch/arm/boot/dts/sama5d4.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index db1151c..a95eb36 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -1202,6 +1202,13 @@
 				status = "disabled";
 			};
 
+			trng at fc030000 {
+				compatible = "atmel,at91sam9g45-trng";
+				reg = <0xfc030000 0x4000>;
+				interrupts = <53 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&trng_clk>;
+			};
+
 			adc0: adc at fc034000 {
 				compatible = "atmel,at91sam9x5-adc";
 				reg = <0xfc034000 0x100>;
-- 
2.5.0
