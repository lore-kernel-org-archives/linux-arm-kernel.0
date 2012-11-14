From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 15 Nov 2012 03:37:30 +0530
Subject: [PATCH v3 08/11] ARM: dts: add clock provider information for all
 controllers in Exynos4 SoC
In-Reply-To: <1352930853-12268-1-git-send-email-thomas.abraham@linaro.org>
References: <1352930853-12268-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1352930853-12268-9-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For all supported peripheral controllers on Exynos4, add clock lookup
information.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/boot/dts/exynos4.dtsi |   48 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index db2d4aa..cc73bc2 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -53,6 +53,8 @@
 		compatible = "samsung,s3c2410-wdt";
 		reg = <0x10060000 0x100>;
 		interrupts = <0 43 0>;
+		clocks = <&clock 345>;
+		clock-names = "watchdog";
 		status = "disabled";
 	};
 
@@ -60,6 +62,8 @@
 		compatible = "samsung,s3c6410-rtc";
 		reg = <0x10070000 0x100>;
 		interrupts = <0 44 0>, <0 45 0>;
+		clocks = <&clock 346>;
+		clock-names = "rtc";
 		status = "disabled";
 	};
 
@@ -67,6 +71,8 @@
 		compatible = "samsung,s5pv210-keypad";
 		reg = <0x100A0000 0x100>;
 		interrupts = <0 109 0>;
+		clocks = <&clock 347>;
+		clock-names = "keypad";
 		status = "disabled";
 	};
 
@@ -74,6 +80,8 @@
 		compatible = "samsung,exynos4210-sdhci";
 		reg = <0x12510000 0x100>;
 		interrupts = <0 73 0>;
+		clocks = <&clock 297>, <&clock 145>;
+		clock-names = "hsmmc", "mmc_busclk.2";
 		status = "disabled";
 	};
 
@@ -81,6 +89,8 @@
 		compatible = "samsung,exynos4210-sdhci";
 		reg = <0x12520000 0x100>;
 		interrupts = <0 74 0>;
+		clocks = <&clock 298>, <&clock 146>;
+		clock-names = "hsmmc", "mmc_busclk.2";
 		status = "disabled";
 	};
 
@@ -88,6 +98,8 @@
 		compatible = "samsung,exynos4210-sdhci";
 		reg = <0x12530000 0x100>;
 		interrupts = <0 75 0>;
+		clocks = <&clock 299>, <&clock 147>;
+		clock-names = "hsmmc", "mmc_busclk.2";
 		status = "disabled";
 	};
 
@@ -95,6 +107,8 @@
 		compatible = "samsung,exynos4210-sdhci";
 		reg = <0x12540000 0x100>;
 		interrupts = <0 76 0>;
+		clocks = <&clock 300>, <&clock 148>;
+		clock-names = "hsmmc", "mmc_busclk.2";
 		status = "disabled";
 	};
 
@@ -102,6 +116,8 @@
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13800000 0x100>;
 		interrupts = <0 52 0>;
+		clocks = <&clock 312>, <&clock 151>;
+		clock-names = "uart", "clk_uart_baud0";
 		status = "disabled";
 	};
 
@@ -109,6 +125,8 @@
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13810000 0x100>;
 		interrupts = <0 53 0>;
+		clocks = <&clock 313>, <&clock 152>;
+		clock-names = "uart", "clk_uart_baud0";
 		status = "disabled";
 	};
 
@@ -116,6 +134,8 @@
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13820000 0x100>;
 		interrupts = <0 54 0>;
+		clocks = <&clock 314>, <&clock 153>;
+		clock-names = "uart", "clk_uart_baud0";
 		status = "disabled";
 	};
 
@@ -123,6 +143,8 @@
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13830000 0x100>;
 		interrupts = <0 55 0>;
+		clocks = <&clock 315>, <&clock 154>;
+		clock-names = "uart", "clk_uart_baud0";
 		status = "disabled";
 	};
 
@@ -132,6 +154,8 @@
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13860000 0x100>;
 		interrupts = <0 58 0>;
+		clocks = <&clock 317>;
+		clock-names = "i2c";
 		status = "disabled";
 	};
 
@@ -141,6 +165,8 @@
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13870000 0x100>;
 		interrupts = <0 59 0>;
+		clocks = <&clock 318>;
+		clock-names = "i2c";
 		status = "disabled";
 	};
 
@@ -150,6 +176,8 @@
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13880000 0x100>;
 		interrupts = <0 60 0>;
+		clocks = <&clock 319>;
+		clock-names = "i2c";
 		status = "disabled";
 	};
 
@@ -159,6 +187,8 @@
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13890000 0x100>;
 		interrupts = <0 61 0>;
+		clocks = <&clock 320>;
+		clock-names = "i2c";
 		status = "disabled";
 	};
 
@@ -168,6 +198,8 @@
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x138A0000 0x100>;
 		interrupts = <0 62 0>;
+		clocks = <&clock 321>;
+		clock-names = "i2c";
 		status = "disabled";
 	};
 
@@ -177,6 +209,8 @@
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x138B0000 0x100>;
 		interrupts = <0 63 0>;
+		clocks = <&clock 322>;
+		clock-names = "i2c";
 		status = "disabled";
 	};
 
@@ -186,6 +220,8 @@
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x138C0000 0x100>;
 		interrupts = <0 64 0>;
+		clocks = <&clock 323>;
+		clock-names = "i2c";
 		status = "disabled";
 	};
 
@@ -195,6 +231,8 @@
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x138D0000 0x100>;
 		interrupts = <0 65 0>;
+		clocks = <&clock 324>;
+		clock-names = "i2c";
 		status = "disabled";
 	};
 
@@ -206,6 +244,8 @@
 		rx-dma-channel = <&pdma0 6>; /* preliminary */
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&clock 327>, <&clock 159>;
+		clock-names = "spi", "spi_busclk0";
 		status = "disabled";
 	};
 
@@ -217,6 +257,8 @@
 		rx-dma-channel = <&pdma1 6>; /* preliminary */
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&clock 328>, <&clock 160>;
+		clock-names = "spi", "spi_busclk0";
 		status = "disabled";
 	};
 
@@ -228,6 +270,8 @@
 		rx-dma-channel = <&pdma0 8>; /* preliminary */
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&clock 329>, <&clock 161>;
+		clock-names = "spi", "spi_busclk0";
 		status = "disabled";
 	};
 
@@ -242,12 +286,16 @@
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
 	};
 };
-- 
1.7.4.4
