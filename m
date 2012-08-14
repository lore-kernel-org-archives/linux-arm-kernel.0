From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 14 Aug 2012 15:49:34 +0200
Subject: [PATCH 20/23] spi-atmel: add dma support in sam9x5 device tree
In-Reply-To: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
References: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1344952177-18385-21-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 arch/arm/boot/dts/at91sam9x5.dtsi |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 8cb8b0d..ef09816 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -357,6 +357,12 @@
 					    &pioB 3 0 /* conflicts with ERXDV */
 					   >;
 				dma-mask = <0xffffffff>;
+				dma = <&dma0>;
+				atc_src_per = <2>; /* AT_DMA_ID_SPI0_RX */
+				atc_dst_per = <1>; /* AT_DMA_ID_SPI0_TX */
+				atc_fifocfg_halffifo;
+				atc_src_h2sel_hw;
+				atc_dst_h2sel_hw;
 				status = "disabled";
 			};
 
@@ -372,6 +378,12 @@
 					    &pioA 30 0 /* conflitcs with TWD0 */
 					   >;
 				dma-mask = <0xffffffff>;
+				dma = <&dma0>;
+				atc_src_per = <4>; /* AT_DMA_ID_SPI1_RX */
+				atc_dst_per = <3>; /* AT_DMA_ID_SPI1_TX */
+				atc_fifocfg_halffifo;
+				atc_src_h2sel_hw;
+				atc_dst_h2sel_hw;
 				status = "disabled";
 			};
 		};
-- 
1.7.2.5
