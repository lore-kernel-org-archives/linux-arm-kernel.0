From: richard.genoud@gmail.com (Richard Genoud)
Date: Fri, 31 May 2013 17:02:00 +0200
Subject: [PATCH 2/2] ARM: at91: dt: at91sam9x5: add SPI DMA client infos
In-Reply-To: <1370012520-30539-1-git-send-email-richard.genoud@gmail.com>
References: <1370012520-30539-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1370012520-30539-2-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 arch/arm/boot/dts/at91sam9x5.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

rebased on linux-next next-20130531
plus Ludovic Desroches' patch "ARM: at91: dt: add header to define at_hdmac configuration"
to get the AT91_DMA_CFG_PER_ID() macro

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index af91599..a5942d0 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -629,6 +629,9 @@
 				compatible = "atmel,at91rm9200-spi";
 				reg = <0xf0000000 0x100>;
 				interrupts = <13 IRQ_TYPE_LEVEL_HIGH 3>;
+				dmas = <&dma0 1 AT91_DMA_CFG_PER_ID(1)>,
+				       <&dma0 1 AT91_DMA_CFG_PER_ID(2)>;
+				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi0>;
 				status = "disabled";
@@ -640,6 +643,9 @@
 				compatible = "atmel,at91rm9200-spi";
 				reg = <0xf0004000 0x100>;
 				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 3>;
+				dmas = <&dma1 1 AT91_DMA_CFG_PER_ID(1)>,
+				       <&dma1 1 AT91_DMA_CFG_PER_ID(2)>;
+				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi1>;
 				status = "disabled";
-- 
1.7.10.4
