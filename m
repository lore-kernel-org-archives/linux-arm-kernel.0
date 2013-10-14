From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 14 Oct 2013 18:46:37 +0200
Subject: [PATCH 3/3] ARM: at91/dt/sama5d3: add DMA information to SHA/AES/TDES
 nodes
In-Reply-To: <ba9872c3bb29c9a06f06caa8e0b4528329f07675.1381769174.git.nicolas.ferre@atmel.com>
References: <ba9872c3bb29c9a06f06caa8e0b4528329f07675.1381769174.git.nicolas.ferre@atmel.com>
Message-ID: <269bcba07a15338d3e7a3699ed25c4e775f7fca0.1381769174.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d3.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 99bd4a6..aca3893 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -345,18 +345,26 @@
 				compatible = "atmel,at91sam9g46-sha";
 				reg = <0xf8034000 0x100>;
 				interrupts = <42 IRQ_TYPE_LEVEL_HIGH 0>;
+				dmas = <&dma1 2 AT91_DMA_CFG_PER_ID(17)>;
+				dma-names = "tx";
 			};
 
 			aes at f8038000 {
 				compatible = "atmel,at91sam9g46-aes";
 				reg = <0xf8038000 0x100>;
 				interrupts = <43 IRQ_TYPE_LEVEL_HIGH 0>;
+				dmas = <&dma1 2 AT91_DMA_CFG_PER_ID(18)>,
+				       <&dma1 2 AT91_DMA_CFG_PER_ID(19)>;
+				dma-names = "tx", "rx";
 			};
 
 			tdes at f803c000 {
 				compatible = "atmel,at91sam9g46-tdes";
 				reg = <0xf803c000 0x100>;
 				interrupts = <44 IRQ_TYPE_LEVEL_HIGH 0>;
+				dmas = <&dma1 2 AT91_DMA_CFG_PER_ID(20)>,
+				       <&dma1 2 AT91_DMA_CFG_PER_ID(21)>;
+				dma-names = "tx", "rx";
 			};
 
 			dma0: dma-controller at ffffe600 {
-- 
1.8.2.2
