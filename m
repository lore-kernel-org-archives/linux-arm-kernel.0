From: leilk.liu@mediatek.com (Leilk Liu)
Date: Tue, 25 Sep 2018 10:20:43 +0800
Subject: [PATCH v4 3/3] arm64: dts: Add spi slave dts
In-Reply-To: <1537842043-15255-1-git-send-email-leilk.liu@mediatek.com>
References: <1537842043-15255-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1537842043-15255-4-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds MT2712 spi slave into device tree.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index 75cc0f7..ee627a7 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -301,6 +301,17 @@
 		status = "disabled";
 	};
 
+	spis1: spi at 10013000 {
+		compatible = "mediatek,mt2712-spi-slave";
+		reg = <0 0x10013000 0 0x100>;
+		interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infracfg CLK_INFRA_AO_SPI1>;
+		clock-names = "spi";
+		assigned-clocks = <&topckgen CLK_TOP_SPISLV_SEL>;
+		assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL1_D2>;
+		status = "disabled";
+	};
+
 	apmixedsys: syscon at 10209000 {
 		compatible = "mediatek,mt2712-apmixedsys", "syscon";
 		reg = <0 0x10209000 0 0x1000>;
-- 
1.7.9.5
