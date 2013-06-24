From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 24 Jun 2013 12:35:18 +0200
Subject: [PATCH 3/3] ARM: at91/DT: at91sam9n12: add SPI DMA client infos
In-Reply-To: <cover.1372069834.git.nicolas.ferre@atmel.com>
References: <cover.1372069834.git.nicolas.ferre@atmel.com>
Message-ID: <0db25022e463d6be2111e5dc3505faaf63f9cdc9.1372069834.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9n12.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 973bf5f..bb7f564 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -492,6 +492,9 @@
 				compatible = "atmel,at91rm9200-spi";
 				reg = <0xf0000000 0x100>;
 				interrupts = <13 IRQ_TYPE_LEVEL_HIGH 3>;
+				dmas = <&dma 1 AT91_DMA_CFG_PER_ID(1)>,
+				       <&dma 1 AT91_DMA_CFG_PER_ID(2)>;
+				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi0>;
 				status = "disabled";
@@ -503,6 +506,9 @@
 				compatible = "atmel,at91rm9200-spi";
 				reg = <0xf0004000 0x100>;
 				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 3>;
+				dmas = <&dma 1 AT91_DMA_CFG_PER_ID(3)>,
+				       <&dma 1 AT91_DMA_CFG_PER_ID(4)>;
+				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi1>;
 				status = "disabled";
-- 
1.8.2.2
