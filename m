From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Wed, 27 Jul 2016 15:58:16 +0800
Subject: [PATCH v2] arm64: dts: mt8173: add mmsel clocks for 4K support
Message-ID: <1469606296-50515-1-git-send-email-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If MT8173 can support HDMI 4K resoultion,
the VENCPLL should be configured to 800MHZ.
We didn't set VENCPLL directly, we set the
mm_sel to 400MHz statically in the board
device tree.

Changes since v1:
 - Do not set the VENCPLL by clk_set_rate
   at display driver.
 - Configure the mm_sel to 400MHz statically
   in the board device tree.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 78529e4..e89aca6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -690,6 +690,8 @@
 			compatible = "mediatek,mt8173-mmsys", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			clocks = <&topckgen CLK_TOP_MM_SEL>;
+			clock-names = "mmsel";
 			#clock-cells = <1>;
 		};
 
@@ -858,8 +860,8 @@
 			interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>;
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DPI_PIXEL>,
-				 <&mmsys CLK_MM_DPI_ENGINE>,
-				 <&apmixedsys CLK_APMIXED_TVDPLL>;
+					 <&mmsys CLK_MM_DPI_ENGINE>,
+					 <&apmixedsys CLK_APMIXED_TVDPLL>;
 			clock-names = "pixel", "engine", "pll";
 			status = "disabled";
 		};
-- 
1.7.9.5
