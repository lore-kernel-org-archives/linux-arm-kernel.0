From: leilk.liu@mediatek.com (Leilk Liu)
Date: Tue, 28 Aug 2018 14:28:05 +0800
Subject: [PATCH 3/3] arm64: dts: Add spi slave dts
In-Reply-To: <1535437685-30230-1-git-send-email-leilk.liu@mediatek.com>
References: <1535437685-30230-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1535437685-30230-4-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds MT2712 spi slave into device tree.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index 75cc0f7..064419b 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -301,6 +301,18 @@
 		status = "disabled";
 	};
 
+	spis1: spi at 10013000 {
+		compatible = "mediatek,mt2712-spi-slave";
+		reg = <0 0x10013000 0 0x100>;
+		interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_UNIVPLL1_D2>,
+			<&topckgen CLK_TOP_SPISLV_SEL>,
+			<&infracfg CLK_INFRA_AO_SPI1>;
+		clock-names = "parent-clk", "sel-clk", "spi-clk";
+		spi-slave;
+		status = "disabled";
+	};
+
 	apmixedsys: syscon at 10209000 {
 		compatible = "mediatek,mt2712-apmixedsys", "syscon";
 		reg = <0 0x10209000 0 0x1000>;
-- 
1.7.9.5
