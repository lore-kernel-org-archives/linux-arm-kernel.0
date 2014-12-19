From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 19 Dec 2014 18:53:47 +0530
Subject: [PATCH 4/4] arm64: dts: Add PDMA and SPI device tree node for exynos7
In-Reply-To: <1418995427-7712-1-git-send-email-padma.v@samsung.com>
References: <1418995427-7712-1-git-send-email-padma.v@samsung.com>
Message-ID: <1418995427-7712-5-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PDMA0,PDMA1 and 5 SPI dt nodes for Exynos7.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos7.dtsi |  113 +++++++++++++++++++++++++++++++
 1 files changed, 113 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index eeaa9b8d..db7058a 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -28,6 +28,9 @@
 		pinctrl7 = &pinctrl_fsys1;
 		pinctrl8 = &pinctrl_bus1;
 		pinctrl9 = &pinctrl_aud;
+		spi0 = &spi_0;
+		spi1 = &spi_1;
+		spi2 = &spi_2;
 	};
 
 	cpus {
@@ -573,6 +576,116 @@
 			samsung,pmu-syscon = <&pmu_system_controller>;
 			#phy-cells = <1>;
 		};
+
+		amba {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "arm,amba-bus";
+			interrupt-parent = <&gic>;
+			ranges;
+
+			pdma1: pdma1 at 10EB0000 {
+				compatible = "arm,pl330", "arm,primecell";
+				reg = <0x10EB0000 0x1000>;
+				interrupts = <0 226 0>;
+				clocks = <&clock_fsys0 ACLK_PDMA1>;
+				clock-names = "apb_pclk";
+				#dma-cells = <1>;
+				#dma-channels = <8>;
+				#dma-requests = <32>;
+			};
+
+			pdma0: pdma0 at 10E10000 {
+				compatible = "arm,pl330", "arm,primecell";
+				reg = <0x10E10000 0x1000>;
+				interrupts = <0 225 0>;
+				clocks = <&clock_fsys0 ACLK_PDMA0>;
+				clock-names = "apb_pclk";
+				#dma-cells = <1>;
+				#dma-channels = <8>;
+				#dma-requests = <32>;
+			};
+		};
+
+		spi_0: spi at 14d20000 {
+			compatible = "samsung,exynos7-spi";
+			reg = <0x14d20000 0x100>;
+			interrupts = <0 464 0>;
+			dmas = <&pdma0 7
+				&pdma0 6>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clock_peric1 PCLK_SPI0>, <&clock_peric1 SCLK_SPI0>;
+			clock-names = "spi", "spi_busclk0";
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi0_bus>;
+			status = "disabled";
+		};
+
+		spi_1: spi at 14d30000 {
+			compatible = "samsung,exynos7-spi";
+			reg = <0x14d30000 0x100>;
+			interrupts = <0 465 0>;
+			dmas = <&pdma0 9
+				&pdma0 8>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clock_peric1 PCLK_SPI1>, <&clock_peric1 SCLK_SPI1>;
+			clock-names = "spi", "spi_busclk0";
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi1_bus>;
+			status = "disabled";
+		};
+
+		spi_2: spi at 14d40000 {
+			compatible = "samsung,exynos7-spi";
+			reg = <0x14d40000 0x100>;
+			interrupts = <0 466 0>;
+			dmas = <&pdma0 11
+				&pdma0 10>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clock_peric1 PCLK_SPI2>, <&clock_peric1 SCLK_SPI2>;
+			clock-names = "spi", "spi_busclk0";
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi2_bus>;
+			status = "disabled";
+		};
+
+		spi_3: spi at 14d50000 {
+			compatible = "samsung,exynos7-spi";
+			reg = <0x14d50000 0x100>;
+			interrupts = <0 467 0>;
+			dmas = <&pdma0 13
+				&pdma0 12>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clock_peric1 PCLK_SPI3>, <&clock_peric1 SCLK_SPI3>;
+			clock-names = "spi", "spi_busclk0";
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi3_bus>;
+			status = "disabled";
+		};
+
+		spi_4: spi at 14d70000 {
+			compatible = "samsung,exynos7-spi";
+			reg = <0x14d70000 0x100>;
+			interrupts = <0 468 0>;
+			dmas = <&pdma0 3
+				&pdma0 2>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clock_peric1 PCLK_SPI4>, <&clock_peric1 SCLK_SPI4>;
+			clock-names = "spi", "spi_busclk0";
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi4_bus>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
1.7.4.4
