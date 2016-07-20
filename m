From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Wed, 20 Jul 2016 12:06:11 +0800
Subject: [PATCH] arm64: dts: mt8173: add tvdpll and vencpll clocks for 4K
 support
Message-ID: <1468987571-39104-1-git-send-email-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Junzhi Zhao <junzhi.zhao@mediatek.com>

When the resolution is set to 4k*2k, the hdmi
pixel clock will be 250MHz, however, the correct
pixel clock should be 297MHz. Fix this error by
adding the correct tvdpll clocks.
If MT8173 can support 4K, the vencpll clock should
be 800MHz. Add the vencpll clocks to support 4K.

Signed-off-by: Junzhi Zhao <junzhi.zhao@mediatek.com>
Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 78529e4..e79bacf 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -690,6 +690,8 @@
 			compatible = "mediatek,mt8173-mmsys", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			clocks = <&topckgen CLK_TOP_VENCPLL>;
+			clock-names = "vencpll";
 			#clock-cells = <1>;
 		};
 
@@ -857,10 +859,22 @@
 			reg = <0 0x1401d000 0 0x1000>;
 			interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>;
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
-			clocks = <&mmsys CLK_MM_DPI_PIXEL>,
+			clocks = <&topckgen CLK_TOP_TVDPLL_D2>,
+				 <&topckgen CLK_TOP_TVDPLL_D4>,
+				 <&topckgen CLK_TOP_TVDPLL_D8>,
+				 <&topckgen CLK_TOP_TVDPLL_D16>,
+				 <&topckgen CLK_TOP_DPI0_SEL>,
+				 <&mmsys CLK_MM_DPI_PIXEL>,
 				 <&mmsys CLK_MM_DPI_ENGINE>,
 				 <&apmixedsys CLK_APMIXED_TVDPLL>;
-			clock-names = "pixel", "engine", "pll";
+			clock-names = "tvdpll_d2",
+				      "tvdpll_d4",
+				      "tvdpll_d8",
+				      "tvdpll_d16",
+				      "tvdpll_mux",
+				      "pixel",
+				      "engine",
+				      "pll";
 			status = "disabled";
 		};
 
-- 
1.7.9.5
