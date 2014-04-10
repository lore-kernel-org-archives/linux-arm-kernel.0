From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 10 Apr 2014 19:06:13 +0900
Subject: [PATCH 23/27] ARM: dts: exynos3250: Add spi dt node to support spi bus
In-Reply-To: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
References: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1397124377-16969-15-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomasz Figa <t.figa@samsung.com>

This patch add spi dt node to support SPI (Serial Peripheral Interface) bus.
SPI in Exynos3250 transfers serial data by using various peripherals. Exynos3250
has two independent interface (spi0/1).

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index b8e5ae13..03e7931 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -30,6 +30,8 @@
 		pinctrl1 = &pinctrl_1;
 		mshc0 = &mshc_0;
 		mshc1 = &mshc_1;
+		spi0 = &spi_0;
+		spi1 = &spi_1;
 		i2c0 = &i2c_0;
 		i2c1 = &i2c_1;
 		i2c2 = &i2c_2;
@@ -311,6 +313,38 @@
 		status = "disabled";
 	};
 
+	spi_0: spi at 13920000 {
+		compatible = "samsung,exynos4210-spi";
+		reg = <0x13920000 0x100>;
+		interrupts = <0 121 0>;
+		dmas = <&pdma0 7>, <&pdma0 6>;
+		dma-names = "tx", "rx";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&cmu CLK_SPI0>, <&cmu CLK_SCLK_SPI0>;
+		clock-names = "spi", "spi_busclk0";
+		samsung,spi-src-clk = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi0_bus>;
+		status = "disabled";
+	};
+
+	spi_1: spi at 13930000 {
+		compatible = "samsung,exynos4210-spi";
+		reg = <0x13930000 0x100>;
+		interrupts = <0 122 0>;
+		dmas = <&pdma1 7>, <&pdma1 6>;
+		dma-names = "tx", "rx";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&cmu CLK_SPI1>, <&cmu CLK_SCLK_SPI1>;
+		clock-names = "spi", "spi_busclk0";
+		samsung,spi-src-clk = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi1_bus>;
+		status = "disabled";
+	};
+
 	pmu {
 		compatible = "arm,cortex-a7-pmu";
 		interrupts = <0 18 0>, <0 19 0>, <0 20 0>, <0 21 0>;
-- 
1.8.0
