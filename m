From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 18 Feb 2013 13:51:23 +0530
Subject: [PATCH v6 13/16] ARM: dts: add clock provider information for all
 controllers in Exynos4 SoCs
In-Reply-To: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
References: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1361175686-19400-14-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For all supported peripheral controllers on Exynos4 SoCs, add clock lookup
information.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
Tested-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/boot/dts/exynos4.dtsi    |   50 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4210.dtsi |    2 +
 arch/arm/boot/dts/exynos4412.dtsi |    2 +
 3 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 1a02189..621f331 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -91,6 +91,8 @@
 		compatible = "samsung,s3c2410-wdt";
 		reg = <0x10060000 0x100>;
 		interrupts = <0 43 0>;
+		clocks = <&clock 345>;
+		clock-names = "watchdog";
 		status = "disabled";
 	};
 
@@ -98,6 +100,8 @@
 		compatible = "samsung,s3c6410-rtc";
 		reg = <0x10070000 0x100>;
 		interrupts = <0 44 0>, <0 45 0>;
+		clocks = <&clock 346>;
+		clock-names = "rtc";
 		status = "disabled";
 	};
 
@@ -105,6 +109,8 @@
 		compatible = "samsung,s5pv210-keypad";
 		reg = <0x100A0000 0x100>;
 		interrupts = <0 109 0>;
+		clocks = <&clock 347>;
+		clock-names = "keypad";
 		status = "disabled";
 	};
 
@@ -112,6 +118,8 @@
 		compatible = "samsung,exynos4210-sdhci";
 		reg = <0x12510000 0x100>;
 		interrupts = <0 73 0>;
+		clocks = <&clock 297>, <&clock 145>;
+		clock-names = "hsmmc", "mmc_busclk.2";
 		status = "disabled";
 	};
 
@@ -119,6 +127,8 @@
 		compatible = "samsung,exynos4210-sdhci";
 		reg = <0x12520000 0x100>;
 		interrupts = <0 74 0>;
+		clocks = <&clock 298>, <&clock 146>;
+		clock-names = "hsmmc", "mmc_busclk.2";
 		status = "disabled";
 	};
 
@@ -126,6 +136,8 @@
 		compatible = "samsung,exynos4210-sdhci";
 		reg = <0x12530000 0x100>;
 		interrupts = <0 75 0>;
+		clocks = <&clock 299>, <&clock 147>;
+		clock-names = "hsmmc", "mmc_busclk.2";
 		status = "disabled";
 	};
 
@@ -133,6 +145,8 @@
 		compatible = "samsung,exynos4210-sdhci";
 		reg = <0x12540000 0x100>;
 		interrupts = <0 76 0>;
+		clocks = <&clock 300>, <&clock 148>;
+		clock-names = "hsmmc", "mmc_busclk.2";
 		status = "disabled";
 	};
 
@@ -148,6 +162,8 @@
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13800000 0x100>;
 		interrupts = <0 52 0>;
+		clocks = <&clock 312>, <&clock 151>;
+		clock-names = "uart", "clk_uart_baud0";
 		status = "disabled";
 	};
 
@@ -155,6 +171,8 @@
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13810000 0x100>;
 		interrupts = <0 53 0>;
+		clocks = <&clock 313>, <&clock 152>;
+		clock-names = "uart", "clk_uart_baud0";
 		status = "disabled";
 	};
 
@@ -162,6 +180,8 @@
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13820000 0x100>;
 		interrupts = <0 54 0>;
+		clocks = <&clock 314>, <&clock 153>;
+		clock-names = "uart", "clk_uart_baud0";
 		status = "disabled";
 	};
 
@@ -169,6 +189,8 @@
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13830000 0x100>;
 		interrupts = <0 55 0>;
+		clocks = <&clock 315>, <&clock 154>;
+		clock-names = "uart", "clk_uart_baud0";
 		status = "disabled";
 	};
 
@@ -178,6 +200,8 @@
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13860000 0x100>;
 		interrupts = <0 58 0>;
+		clocks = <&clock 317>;
+		clock-names = "i2c";
 		status = "disabled";
 	};
 
@@ -187,6 +211,8 @@
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13870000 0x100>;
 		interrupts = <0 59 0>;
+		clocks = <&clock 318>;
+		clock-names = "i2c";
 		status = "disabled";
 	};
 
@@ -196,6 +222,8 @@
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13880000 0x100>;
 		interrupts = <0 60 0>;
+		clocks = <&clock 319>;
+		clock-names = "i2c";
 		status = "disabled";
 	};
 
@@ -205,6 +233,8 @@
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13890000 0x100>;
 		interrupts = <0 61 0>;
+		clocks = <&clock 320>;
+		clock-names = "i2c";
 		status = "disabled";
 	};
 
@@ -214,6 +244,8 @@
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x138A0000 0x100>;
 		interrupts = <0 62 0>;
+		clocks = <&clock 321>;
+		clock-names = "i2c";
 		status = "disabled";
 	};
 
@@ -223,6 +255,8 @@
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x138B0000 0x100>;
 		interrupts = <0 63 0>;
+		clocks = <&clock 322>;
+		clock-names = "i2c";
 		status = "disabled";
 	};
 
@@ -232,6 +266,8 @@
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x138C0000 0x100>;
 		interrupts = <0 64 0>;
+		clocks = <&clock 323>;
+		clock-names = "i2c";
 		status = "disabled";
 	};
 
@@ -241,6 +277,8 @@
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x138D0000 0x100>;
 		interrupts = <0 65 0>;
+		clocks = <&clock 324>;
+		clock-names = "i2c";
 		status = "disabled";
 	};
 
@@ -252,6 +290,8 @@
 		rx-dma-channel = <&pdma0 6>; /* preliminary */
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&clock 327>, <&clock 159>;
+		clock-names = "spi", "spi_busclk0";
 		status = "disabled";
 	};
 
@@ -263,6 +303,8 @@
 		rx-dma-channel = <&pdma1 6>; /* preliminary */
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&clock 328>, <&clock 160>;
+		clock-names = "spi", "spi_busclk0";
 		status = "disabled";
 	};
 
@@ -274,6 +316,8 @@
 		rx-dma-channel = <&pdma0 8>; /* preliminary */
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&clock 329>, <&clock 161>;
+		clock-names = "spi", "spi_busclk0";
 		status = "disabled";
 	};
 
@@ -288,18 +332,24 @@
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x12680000 0x1000>;
 			interrupts = <0 35 0>;
+			clocks = <&clock 292>;
+			clock-names = "apb_pclk";
 		};
 
 		pdma1: pdma at 12690000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x12690000 0x1000>;
 			interrupts = <0 36 0>;
+			clocks = <&clock 293>;
+			clock-names = "apb_pclk";
 		};
 
 		mdma1: mdma at 12850000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x12850000 0x1000>;
 			interrupts = <0 34 0>;
+			clocks = <&clock 279>;
+			clock-names = "apb_pclk";
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 6b25095..072d3b2 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -55,6 +55,8 @@
 		interrupt-parent = <&mct_map>;
 		interrupts = <0 0>, <1 0>, <2 0>, <3 0>,
 			     <4 0>, <5 0>;
+		clocks = <&clock 3>, <&clock 344>;
+		clock-names = "fin_pll", "mct";
 
 		mct_map: mct-map {
 			#interrupt-cells = <2>;
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 821c9fd..1ecc28d 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -34,6 +34,8 @@
 		interrupt-parent = <&mct_map>;
 		interrupts = <0 0>, <1 0>, <2 0>, <3 0>,
 			     <4 0>, <5 0>, <6 0>, <7 0>;
+		clocks = <&clock 3>, <&clock 344>;
+		clock-names = "fin_pll", "mct";
 
 		mct_map: mct-map {
 			#interrupt-cells = <2>;
-- 
1.7.5.4
