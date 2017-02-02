From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  2 Feb 2017 19:51:51 +0100
Subject: [PATCH 01/23] sama5d2.dtsi: workaround SPI DMA
Message-ID: <20170202185213.21698-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 111470359235..908b0baca42f 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -916,12 +916,6 @@
 				compatible = "atmel,at91rm9200-spi";
 				reg = <0xf8000000 0x100>;
 				interrupts = <33 IRQ_TYPE_LEVEL_HIGH 7>;
-				dmas = <&dma0
-					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
-					 AT91_XDMAC_DT_PERID(6))>,
-				       <&dma0
-					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
-					 AT91_XDMAC_DT_PERID(7))>;
 				dma-names = "tx", "rx";
 				clocks = <&spi0_clk>;
 				clock-names = "spi_clk";
-- 
2.11.0
