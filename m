From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 8 Jun 2015 15:55:48 +0200
Subject: [PATCH] ARM: at91/dt: sama5d4: fix dma conf for aes,
 sha and tdes nodes
Message-ID: <1433771754-4999-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The xdmac channel configuration is done in one cell not two. This error
prevents from probing devices correctly.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Fixes: 83906783b766 ("ARM: at91/dt: sama5d4: add aes, sha and tdes nodes")
Cc: stable at vger.kernel.org # 4.1
---
 arch/arm/boot/dts/sama5d4.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 6b1bb58..51ddec4 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -1125,10 +1125,10 @@
 				compatible = "atmel,at91sam9g46-aes";
 				reg = <0xfc044000 0x100>;
 				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 0>;
-				dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1))
-					AT91_XDMAC_DT_PERID(41)>,
-				       <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1))
-					AT91_XDMAC_DT_PERID(40)>;
+				dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+					| AT91_XDMAC_DT_PERID(41))>,
+				       <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+					| AT91_XDMAC_DT_PERID(40))>;
 				dma-names = "tx", "rx";
 				clocks = <&aes_clk>;
 				clock-names = "aes_clk";
@@ -1139,10 +1139,10 @@
 				compatible = "atmel,at91sam9g46-tdes";
 				reg = <0xfc04c000 0x100>;
 				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 0>;
-				dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1))
-					AT91_XDMAC_DT_PERID(42)>,
-				       <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1))
-					AT91_XDMAC_DT_PERID(43)>;
+				dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+					| AT91_XDMAC_DT_PERID(42))>,
+				       <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+					| AT91_XDMAC_DT_PERID(43))>;
 				dma-names = "tx", "rx";
 				clocks = <&tdes_clk>;
 				clock-names = "tdes_clk";
@@ -1153,8 +1153,8 @@
 				compatible = "atmel,at91sam9g46-sha";
 				reg = <0xfc050000 0x100>;
 				interrupts = <15 IRQ_TYPE_LEVEL_HIGH 0>;
-				dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1))
-					AT91_XDMAC_DT_PERID(44)>;
+				dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+					| AT91_XDMAC_DT_PERID(44))>;
 				dma-names = "tx";
 				clocks = <&sha_clk>;
 				clock-names = "sha_clk";
-- 
2.2.0
