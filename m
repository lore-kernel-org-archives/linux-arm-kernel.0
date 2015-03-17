From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Tue, 17 Mar 2015 11:13:51 +0800
Subject: [PATCH v2 1/5] mmc: dt-bindings: add Mediatek MMC bindings
In-Reply-To: <1426562035-16709-1-git-send-email-chaotian.jing@mediatek.com>
References: <1426562035-16709-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <1426562035-16709-2-git-send-email-chaotian.jing@mediatek.com>
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
index 0000000..ac43f77
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
+- clocks: MSDC source clock
+- clock-names: "source"
+- pinctrl-names: should be "default", "state_uhs"
+- pinctrl-0: should contain default/high speed pin ctrl
+- pinctrl-1: should contain uhs mode pin ctrl
+
+Optional properties:
+- vmmc-supply: power to the Core
+- vqmmc-supply: power to the IO(for SD/SDIO)
+
+Examples:
+mmc0: mmc at 11230000 {
+	compatible = "mediatek,mt8173-mmc","mediatek,mt8135-mmc";
+	reg = <0 0x11230000 0 0x108>;
+	interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_LOW>;
+	vmmc-supply = <&mt6397_vemc_3v3_reg>;
+	clocks = <&pericfg PERI_MSDC20_1_CK>;
+	clock-names = "source";
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_pins_default>;
+	pinctrl-1 = <&mmc0_pins_uhs>;
+};
-- 
1.8.1.1.dirty
