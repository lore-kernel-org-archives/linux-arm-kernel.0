From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Tue, 20 Oct 2015 17:13:04 +0800
Subject: [PATCH v2 2/9] mmc: dt-bindings: update Mediatek MMC bindings
In-Reply-To: <1445332391-30530-1-git-send-email-chaotian.jing@mediatek.com>
References: <1445332391-30530-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <1445332391-30530-3-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 400Mhz clock source for HS400 mode

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
index a1adfa4..0120c7f 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
@@ -17,6 +17,11 @@ Required properties:
 - vmmc-supply: power to the Core
 - vqmmc-supply: power to the IO
 
+Optional properties:
+- assigned-clocks: PLL of the source clock
+- assigned-clock-parents: parent of source clock, used for HS400 mode to get 400Mhz source clock
+- hs400-ds-delay: HS400 DS delay setting
+
 Examples:
 mmc0: mmc at 11230000 {
 	compatible = "mediatek,mt8173-mmc", "mediatek,mt8135-mmc";
@@ -24,9 +29,13 @@ mmc0: mmc at 11230000 {
 	interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_LOW>;
 	vmmc-supply = <&mt6397_vemc_3v3_reg>;
 	vqmmc-supply = <&mt6397_vio18_reg>;
-	clocks = <&pericfg CLK_PERI_MSDC30_0>, <&topckgen CLK_TOP_MSDC50_0_H_SEL>;
+	clocks = <&pericfg CLK_PERI_MSDC30_0>,
+	         <&topckgen CLK_TOP_MSDC50_0_H_SEL>;
 	clock-names = "source", "hclk";
 	pinctrl-names = "default", "state_uhs";
 	pinctrl-0 = <&mmc0_pins_default>;
 	pinctrl-1 = <&mmc0_pins_uhs>;
+	assigned-clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>;
+	assigned-clock-parents = <&topckgen CLK_TOP_MSDCPLL_D2>;
+	hs400-ds-delay = <0x14015>;
 };
-- 
1.8.1.1.dirty
