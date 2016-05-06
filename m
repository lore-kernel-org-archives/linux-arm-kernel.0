From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 6 May 2016 15:37:47 +0200
Subject: [PATCH] ARM: dts: at91: at91sam9g45 family: reduce the trng register
 map size
Message-ID: <1462541867-7800-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No need to map 0x4000 bytes for the TRNG device: reduce it to 0x100.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9g45.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index af8b708ac312..8837b7e4292c 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -978,7 +978,7 @@
 
 			trng at fffcc000 {
 				compatible = "atmel,at91sam9g45-trng";
-				reg = <0xfffcc000 0x4000>;
+				reg = <0xfffcc000 0x100>;
 				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 0>;
 				clocks = <&trng_clk>;
 			};
-- 
2.1.3
