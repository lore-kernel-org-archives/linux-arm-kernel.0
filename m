From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Tue, 6 Feb 2018 17:53:04 +0800
Subject: [PATCH v2 15/16] arm64: dts: mt7622: add High-Speed DMA device nodes
In-Reply-To: <cover.1517910489.git.sean.wang@mediatek.com>
References: <cover.1517910489.git.sean.wang@mediatek.com>
Message-ID: <40c5f7cdd094166d4a3eb1f36f89cdb8edf6d243.1517910489.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

add High-Speed DMA (HSDMA) nodes

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 6cf67dd..ed7ee78 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -712,6 +712,16 @@
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
