From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 24 Jun 2013 12:35:17 +0200
Subject: [PATCH 2/3] ARM: at91/DT: sama5d3: add SPI DMA client infos
In-Reply-To: <cover.1372069834.git.nicolas.ferre@atmel.com>
References: <cover.1372069834.git.nicolas.ferre@atmel.com>
Message-ID: <4a802034c6c31e37bf9b2066de01ff966cea7f29.1372069834.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d3.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 178fd09..a1d5e25 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -83,6 +83,9 @@
 				compatible = "atmel,at91rm9200-spi";
 				reg = <0xf0004000 0x100>;
 				interrupts = <24 IRQ_TYPE_LEVEL_HIGH 3>;
+				dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(1)>,
+				       <&dma0 2 AT91_DMA_CFG_PER_ID(2)>;
+				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi0>;
 				status = "disabled";
@@ -206,6 +209,9 @@
 				compatible = "atmel,at91rm9200-spi";
 				reg = <0xf8008000 0x100>;
 				interrupts = <25 IRQ_TYPE_LEVEL_HIGH 3>;
+				dmas = <&dma1 2 AT91_DMA_CFG_PER_ID(15)>,
+				       <&dma1 2 AT91_DMA_CFG_PER_ID(16)>;
+				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi1>;
 				status = "disabled";
-- 
1.8.2.2
