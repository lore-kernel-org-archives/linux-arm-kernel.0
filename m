From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 4 Mar 2015 16:45:41 +0100
Subject: [PATCH] ARM: at91/dt: sama5d4: add aes, sha and tdes nodes
Message-ID: <1425483941-13995-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leilei Zhao <leilei.zhao@atmel.com>

Signed-off-by: Leilei Zhao <leilei.zhao@atmel.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d4.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 5661b90b0b2b..93dc4e374b64 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -1068,6 +1068,46 @@
 				};
 			};
 
+			aes at fc044000 {
+				compatible = "atmel,at91sam9g46-aes";
+				reg = <0xfc044000 0x100>;
+				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 0>;
+				dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1))
+					AT91_XDMAC_DT_PERID(41)>,
+				       <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1))
+					AT91_XDMAC_DT_PERID(40)>;
+				dma-names = "tx", "rx";
+				clocks = <&aes_clk>;
+				clock-names = "aes_clk";
+				status = "disabled";
+			};
+
+			tdes at fc04c000 {
+				compatible = "atmel,at91sam9g46-tdes";
+				reg = <0xfc04c000 0x100>;
+				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 0>;
+				dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1))
+					AT91_XDMAC_DT_PERID(42)>,
+				       <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1))
+					AT91_XDMAC_DT_PERID(43)>;
+				dma-names = "tx", "rx";
+				clocks = <&tdes_clk>;
+				clock-names = "tdes_clk";
+				status = "disabled";
+			};
+
+			sha at fc050000 {
+				compatible = "atmel,at91sam9g46-sha";
+				reg = <0xfc050000 0x100>;
+				interrupts = <15 IRQ_TYPE_LEVEL_HIGH 0>;
+				dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1))
+					AT91_XDMAC_DT_PERID(44)>;
+				dma-names = "tx";
+				clocks = <&sha_clk>;
+				clock-names = "sha_clk";
+				status = "disabled";
+			};
+
 			rstc at fc068600 {
 				compatible = "atmel,at91sam9g45-rstc";
 				reg = <0xfc068600 0x10>;
-- 
2.1.3
