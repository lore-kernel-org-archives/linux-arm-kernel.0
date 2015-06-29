From: leilk.liu@mediatek.com (Leilk Liu)
Date: Mon, 29 Jun 2015 21:04:30 +0800
Subject: [PATCH v2 4/4] arm64: dts: Add spi bus dts
In-Reply-To: <1435583070-9600-1-git-send-email-leilk.liu@mediatek.com>
References: <1435583070-9600-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1435583070-9600-5-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds MT8173 spi bus controllers into device tree.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 512e4eb..923d2eb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -259,6 +259,15 @@
 			status = "disabled";
 		};
 
+		spi: spi at 1100a000 {
+			compatible = "mediatek,mt8173-spi";
+			reg = <0 0x1100a000 0 0x1000>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_SPI0>;
+			clock-names = "main";
+			status = "disabled";
+		};
+
 		mmsys: mmsys at 14000000 {
 			compatible = "mediatek,mt8173-mmsys", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
-- 
1.8.1.1.dirty
