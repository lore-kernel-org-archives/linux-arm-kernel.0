From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Wed, 12 Aug 2015 16:24:05 +0800
Subject: [PATCH 4/4] mmc: dt-bindings:  Add 400Mhz clock source
In-Reply-To: <1439367845-5891-1-git-send-email-chaotian.jing@mediatek.com>
References: <1439367845-5891-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <1439367845-5891-5-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 400Mhz clock source for HS400 mode

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
index a1adfa4..2c28305 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
@@ -17,6 +17,10 @@ Required properties:
 - vmmc-supply: power to the Core
 - vqmmc-supply: power to the IO
 
+Optional properties:
+- clocks: 400Mhz clk, used for HS400 mode, 400Mhz source clock
+- clock-name: "400Mhz_clk"
+
 Examples:
 mmc0: mmc at 11230000 {
 	compatible = "mediatek,mt8173-mmc", "mediatek,mt8135-mmc";
@@ -24,8 +28,10 @@ mmc0: mmc at 11230000 {
 	interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_LOW>;
 	vmmc-supply = <&mt6397_vemc_3v3_reg>;
 	vqmmc-supply = <&mt6397_vio18_reg>;
-	clocks = <&pericfg CLK_PERI_MSDC30_0>, <&topckgen CLK_TOP_MSDC50_0_H_SEL>;
-	clock-names = "source", "hclk";
+	clocks = <&pericfg CLK_PERI_MSDC30_0>,
+	         <&topckgen CLK_TOP_MSDC50_0_H_SEL>,
+	         <&topckgen CLK_TOP_MSDCPLL_D2>;
+	clock-names = "source", "hclk", "400Mhz_clk";
 	pinctrl-names = "default", "state_uhs";
 	pinctrl-0 = <&mmc0_pins_default>;
 	pinctrl-1 = <&mmc0_pins_uhs>;
-- 
1.8.1.1.dirty
