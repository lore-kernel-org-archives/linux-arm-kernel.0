From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 1 Dec 2016 11:49:48 +0100
Subject: [PATCH 2/3] ARM: dts: at91: sama5d2: move UART3 to DMA1
In-Reply-To: <20161201104949.23985-1-nicolas.ferre@atmel.com>
References: <20161201104949.23985-1-nicolas.ferre@atmel.com>
Message-ID: <20161201104949.23985-2-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that DMA1 is defined, use it to distribute channel usage among the two
controllers.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index c791ce9c750c..5b69eff523d9 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -1151,10 +1151,10 @@
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfc008000 0x100>;
 				interrupts = <27 IRQ_TYPE_LEVEL_HIGH 7>;
-				dmas = <&dma0
+				dmas = <&dma1
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
 					 AT91_XDMAC_DT_PERID(41))>,
-				       <&dma0
+				       <&dma1
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
 					 AT91_XDMAC_DT_PERID(42))>;
 				dma-names = "tx", "rx";
-- 
2.9.0
