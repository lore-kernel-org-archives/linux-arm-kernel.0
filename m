From: erin.lo@mediatek.com (Erin Lo)
Date: Wed, 11 Jan 2017 16:38:41 +0800
Subject: [PATCH 1/4] arm: dts: mt2701: Add spi device node
In-Reply-To: <1484123924-8946-1-git-send-email-erin.lo@mediatek.com>
References: <1484123924-8946-1-git-send-email-erin.lo@mediatek.com>
Message-ID: <1484123924-8946-2-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leilk Liu <leilk.liu@mediatek.com>

Add spi device node for MT2701.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 arch/arm/boot/dts/mt2701.dtsi | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index bdf8954..eb4c6fd 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -227,6 +227,45 @@
 		status = "disabled";
 	};
 
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
+
 	mmsys: syscon at 14000000 {
 		compatible = "mediatek,mt2701-mmsys", "syscon";
 		reg = <0 0x14000000 0 0x1000>;
-- 
1.9.1
