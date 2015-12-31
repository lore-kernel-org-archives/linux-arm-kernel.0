From: leilk.liu@mediatek.com (Leilk Liu)
Date: Thu, 31 Dec 2015 10:59:02 +0800
Subject: [PATCH 3/4] dts: mt2701: add spi dts for mt2701
In-Reply-To: <1451530743-8995-1-git-send-email-leilk.liu@mediatek.com>
References: <1451530743-8995-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1451530743-8995-4-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds dtsi node of spi for mt2701.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 arch/arm/boot/dts/mt2701.dtsi |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index bd88ae9..9ccd1f0 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -194,4 +194,43 @@
 		clocks = <&uart_clk>;
 		status = "disabled";
 	};
+
+	spi0: spi at 1100a000 {
+		compatible = "mediatek,mt2701-spi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0 0x1100a000 0 0x100>;
+		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_SYSPLL3_D2>,
+			 <&topckgen CLK_TOP_SPI0_SEL>,
+			 <&pericfg CLK_PERI_SPI0>;
+		clock-names = "parent-clk", "sel-clk", "spi-clk";
+		status = "disabled";
+	};
+
+	spi1: spi at 11016000 {
+		compatible = "mediatek,mt2701-spi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0 0x11016000 0 0x100>;
+		interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_SYSPLL3_D2>,
+			 <&topckgen CLK_TOP_SPI1_SEL>,
+			 <&pericfg CLK_PERI_SPI1>;
+		clock-names = "parent-clk", "sel-clk", "spi-clk";
+		status = "disabled";
+	};
+
+	spi2: spi at 11017000 {
+		compatible = "mediatek,mt2701-spi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0 0x11017000 0 0x1000>;
+		interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_SYSPLL3_D2>,
+			 <&topckgen CLK_TOP_SPI2_SEL>,
+			 <&pericfg CLK_PERI_SPI2>;
+		clock-names = "parent-clk", "sel-clk", "spi-clk";
+		status = "disabled";
+	};
 };
-- 
1.7.9.5
