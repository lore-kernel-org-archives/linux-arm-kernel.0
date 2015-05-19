From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Tue, 19 May 2015 14:36:45 +0800
Subject: [PATCH v4 1/7] mmc: dt-bindings: add Mediatek MMC bindings
In-Reply-To: <1432017411-2996-1-git-send-email-chaotian.jing@mediatek.com>
References: <1432017411-2996-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <1432017411-2996-2-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the device-tree binding of Mediatek MMC host

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.txt | 33 ++++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/mtk-sd.txt

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
new file mode 100644
index 0000000..ba6d668
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
@@ -0,0 +1,33 @@
+* MTK MMC controller
+
+The MTK  MSDC can act as a MMC controller
+to support MMC, SD, and SDIO types of memory cards.
+
+This file documents differences between the core properties in mmc.txt
+and the properties used by the msdc driver.
+
+Required properties:
+- compatible: Should be "mediatek,mt8173-mmc","mediatek,mt8135-mmc".
+- interrupts: Should contain MSDC interrupt number
+- clocks: MSDC source clock, HCLK, HCLK is mandatory when it is not controlled by Infra
+- clock-names: "source", "hclk"
+- pinctrl-names: should be "default", "state_uhs"
+- pinctrl-0: should contain default/high speed pin ctrl
+- pinctrl-1: should contain uhs mode pin ctrl
+- vmmc-supply: power to the Core
+
+Optional properties:
+- vqmmc-supply: power to the IO(for SD/SDIO)
+
+Examples:
+mmc0: mmc at 11230000 {
+	compatible = "mediatek,mt8173-mmc", "mediatek,mt8135-mmc";
+	reg = <0 0x11230000 0 0x108>;
+	interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_LOW>;
+	vmmc-supply = <&mt6397_vemc_3v3_reg>;
+	clocks = <&pericfg CLK_PERI_MSDC30_0>, <&topckgen CLK_TOP_MSDC50_0_H_SEL>;
+	clock-names = "source", "hclk";
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_pins_default>;
+	pinctrl-1 = <&mmc0_pins_uhs>;
+};
-- 
1.8.1.1.dirty
