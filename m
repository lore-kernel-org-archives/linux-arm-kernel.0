From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Wed, 27 Jul 2016 16:25:14 +0800
Subject: [PATCH v3] arm64: dts: mt8173: add mmsel clocks for 4K support
Message-ID: <1469607914-64831-1-git-send-email-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If MT8173 can support HDMI 4K resoultion, the
VENCPLL should be configured to 800MHZ.
We didn't set VENCPLL directly, we set the
mm_sel to 400MHz statically in the board device tree.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
Changes since v2:
 - Align the clocks of dpi0 node.

Changes since v1:
 - Do not set the VENCPLL by clk_set_rate
   at display driver.
 - Configure the mm_sel to 400MHz statically
   in the board device tree.
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 78529e4..9c22204 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -690,7 +690,9 @@
 			compatible = "mediatek,mt8173-mmsys", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			clocks = <&topckgen CLK_TOP_MM_SEL>;
 			#clock-cells = <1>;
+			clock-frequency  = <400000000>;
 		};
 
 		ovl0: ovl at 1400c000 {
-- 
1.7.9.5
