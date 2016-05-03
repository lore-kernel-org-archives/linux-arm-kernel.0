From: mike@mikebwilliams.com (Mike Williams)
Date: Tue,  3 May 2016 12:44:23 -0400
Subject: [PATCH 2/3] ARM: at91/dt: sama5d3: add trng node
In-Reply-To: <1462293864-32551-1-git-send-email-mike@mikebwilliams.com>
References: <1462293864-32551-1-git-send-email-mike@mikebwilliams.com>
Message-ID: <1462293864-32551-3-git-send-email-mike@mikebwilliams.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node to support SAMA5D3 hardware random number generator.
---
 arch/arm/boot/dts/sama5d3.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index a532791..c346aa9 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -426,6 +426,13 @@
 				clock-names = "tdes_clk";
 			};
 
+			trng at f8040000 {
+				compatible = "atmel,at91sam9g45-trng";
+				reg = <0xf8040000 0x4000>;
+				interrupts = <45 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&trng_clk>;
+			};
+
 			dma0: dma-controller at ffffe600 {
 				compatible = "atmel,at91sam9g45-dma";
 				reg = <0xffffe600 0x200>;
-- 
2.5.0
