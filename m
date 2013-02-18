From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 18 Feb 2013 13:51:25 +0530
Subject: [PATCH v6 15/16] ARM: dts: add clock provider information for all
 controllers in Exynos5440 SoC
In-Reply-To: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
References: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1361175686-19400-16-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For all supported peripheral controllers on Exynos5440, add clock lookup
information.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/boot/dts/exynos5440.dtsi |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index f5834d0..a54c4ab 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -65,12 +65,16 @@
 		compatible = "samsung,exynos4210-uart";
 		reg = <0xB0000 0x1000>;
 		interrupts = <0 2 0>;
+		clocks = <&clock 21>, <&clock 21>;
+		clock-names = "uart", "clk_uart_baud0";
 	};
 
 	serial at C0000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0xC0000 0x1000>;
 		interrupts = <0 3 0>;
+		clocks = <&clock 21>, <&clock 21>;
+		clock-names = "uart", "clk_uart_baud0";
 	};
 
 	spi {
@@ -81,6 +85,8 @@
 		rx-dma-channel = <&pdma0 4>; /* preliminary */
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&clock 21>, <&clock 16>;
+		clock-names = "spi", "spi_busclk0";
 	};
 
 	pinctrl {
@@ -113,6 +119,8 @@
 		interrupts = <0 5 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&clock 21>;
+		clock-names = "i2c";
 	};
 
 	i2c at 100000 {
@@ -121,12 +129,16 @@
 		interrupts = <0 6 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&clock 21>;
+		clock-names = "i2c";
 	};
 
 	watchdog {
 		compatible = "samsung,s3c2410-wdt";
 		reg = <0x110000 0x1000>;
 		interrupts = <0 1 0>;
+		clocks = <&clock 21>;
+		clock-names = "watchdog";
 	};
 
 	amba {
@@ -140,12 +152,16 @@
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x120000 0x1000>;
 			interrupts = <0 34 0>;
+			clocks = <&clock 21>;
+			clock-names = "apb_pclk";
 		};
 
 		pdma1: pdma at 121B0000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x121000 0x1000>;
 			interrupts = <0 35 0>;
+			clocks = <&clock 21>;
+			clock-names = "apb_pclk";
 		};
 	};
 
@@ -153,5 +169,7 @@
 		compatible = "samsung,s3c6410-rtc";
 		reg = <0x130000 0x1000>;
 		interrupts = <0 17 0>, <0 16 0>;
+		clocks = <&clock 21>;
+		clock-names = "rtc";
 	};
 };
-- 
1.7.5.4
