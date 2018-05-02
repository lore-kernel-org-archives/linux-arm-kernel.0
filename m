From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 2 May 2018 11:41:23 +0800
Subject: [PATCH 1/2] arm64: dts: mt7622: add High-Speed DMA device nodes
Message-ID: <d208e8cf93f18b97ee9cf24cdd0220aa44188b8b.1525231985.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

add High-Speed DMA (HSDMA) nodes

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index e9d5130..6bbabb6 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -735,6 +735,16 @@
 		#reset-cells = <1>;
 	};
 
+	hsdma: dma-controller at 1b007000 {
+		compatible = "mediatek,mt7622-hsdma";
+		reg = <0 0x1b007000 0 0x1000>;
+		interrupts = <GIC_SPI 219 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&ethsys CLK_ETH_HSDMA_EN>;
+		clock-names = "hsdma";
+		power-domains = <&scpsys MT7622_POWER_DOMAIN_ETHSYS>;
+		#dma-cells = <1>;
+	};
+
 	eth: ethernet at 1b100000 {
 		compatible = "mediatek,mt7622-eth",
 			     "mediatek,mt2701-eth",
-- 
2.7.4
