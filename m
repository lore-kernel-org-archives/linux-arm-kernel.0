From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Mon, 25 Sep 2017 02:02:44 +0200
Subject: [PATCH v3 10/10] arm64: allwinner: a64: add dma controller references
 to spi nodes
In-Reply-To: <20170925000244.11679-1-stefan.bruens@rwth-aachen.de>
References: <20170925000244.11679-1-stefan.bruens@rwth-aachen.de>
Message-ID: <53ca1daf-1d17-4442-bb71-551e879ebc14@rwthex-w2-a.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The spi controller nodes omit the dma controller/channel references, add
it.

This does not yet enable DMA for SPI transfers, as the spi-sun6i driver
lacks support for DMA, but always uses PIO to the FIFO.

Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
---

Changes in v3: None
Changes in v2: None

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index cbffefce0e71..a6a5a40d76d0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -476,6 +476,8 @@
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
 			clock-names = "ahb", "mod";
+			dmas = <&dma 23>, <&dma 23>;
+			dma-names = "rx", "tx";
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi0_pins>;
 			resets = <&ccu RST_BUS_SPI0>;
@@ -491,6 +493,8 @@
 			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_SPI1>, <&ccu CLK_SPI1>;
 			clock-names = "ahb", "mod";
+			dmas = <&dma 24>, <&dma 24>;
+			dma-names = "rx", "tx";
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi1_pins>;
 			resets = <&ccu RST_BUS_SPI1>;
-- 
2.14.1
