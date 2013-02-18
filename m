From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 18 Feb 2013 13:51:24 +0530
Subject: [PATCH v6 14/16] ARM: dts: add clock provider information for all
 controllers in Exynos5250 SoC
In-Reply-To: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
References: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1361175686-19400-15-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For all supported peripheral controllers on Exynos5250, add clock lookup
information.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/boot/dts/exynos5250.dtsi |   72 +++++++++++++++++++++++++++++++++++++
 1 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index d3eae4e..d7a49a3 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -98,6 +98,8 @@
 		interrupt-parent = <&mct_map>;
 		interrupts = <0 0>, <1 0>, <2 0>, <3 0>,
 			     <4 0>, <5 0>;
+		clocks = <&clock 1>, <&clock 335>;
+		clock-names = "fin_pll", "mct";
 
 		mct_map: mct-map {
 			#interrupt-cells = <2>;
@@ -122,6 +124,8 @@
 		compatible = "samsung,s3c2410-wdt";
 		reg = <0x101D0000 0x100>;
 		interrupts = <0 42 0>;
+		clocks = <&clock 336>;
+		clock-names = "watchdog";
 	};
 
 	mfc: codec at 11000000 {
@@ -135,42 +139,56 @@
 		compatible = "samsung,s3c6410-rtc";
 		reg = <0x101E0000 0x100>;
 		interrupts = <0 43 0>, <0 44 0>;
+		clocks = <&clock 337>;
+		clock-names = "rtc";
 	};
 
 	tmu at 10060000 {
 		compatible = "samsung,exynos5250-tmu";
 		reg = <0x10060000 0x100>;
 		interrupts = <0 65 0>;
+		clocks = <&clock 338>;
+		clock-names = "tmu_apbif";
 	};
 
 	serial at 12C00000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x12C00000 0x100>;
 		interrupts = <0 51 0>;
+		clocks = <&clock 289>, <&clock 146>;
+		clock-names = "uart", "clk_uart_baud0";
 	};
 
 	serial at 12C10000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x12C10000 0x100>;
 		interrupts = <0 52 0>;
+		clocks = <&clock 290>, <&clock 147>;
+		clock-names = "uart", "clk_uart_baud0";
 	};
 
 	serial at 12C20000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x12C20000 0x100>;
 		interrupts = <0 53 0>;
+		clocks = <&clock 291>, <&clock 148>;
+		clock-names = "uart", "clk_uart_baud0";
 	};
 
 	serial at 12C30000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x12C30000 0x100>;
 		interrupts = <0 54 0>;
+		clocks = <&clock 292>, <&clock 149>;
+		clock-names = "uart", "clk_uart_baud0";
 	};
 
 	sata at 122F0000 {
 		compatible = "samsung,exynos5-sata-ahci";
 		reg = <0x122F0000 0x1ff>;
 		interrupts = <0 115 0>;
+		clocks = <&clock 277>, <&clock 143>;
+		clock-names = "sata", "sclk_sata";
 	};
 
 	sata-phy at 12170000 {
@@ -184,6 +202,8 @@
 		interrupts = <0 56 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&clock 294>;
+		clock-names = "i2c";
 	};
 
 	i2c_1: i2c at 12C70000 {
@@ -192,6 +212,8 @@
 		interrupts = <0 57 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&clock 295>;
+		clock-names = "i2c";
 	};
 
 	i2c_2: i2c at 12C80000 {
@@ -200,6 +222,8 @@
 		interrupts = <0 58 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&clock 296>;
+		clock-names = "i2c";
 	};
 
 	i2c_3: i2c at 12C90000 {
@@ -208,6 +232,8 @@
 		interrupts = <0 59 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&clock 297>;
+		clock-names = "i2c";
 	};
 
 	i2c_4: i2c at 12CA0000 {
@@ -216,6 +242,8 @@
 		interrupts = <0 60 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&clock 298>;
+		clock-names = "i2c";
 	};
 
 	i2c_5: i2c at 12CB0000 {
@@ -224,6 +252,8 @@
 		interrupts = <0 61 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&clock 299>;
+		clock-names = "i2c";
 	};
 
 	i2c_6: i2c at 12CC0000 {
@@ -232,6 +262,8 @@
 		interrupts = <0 62 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&clock 300>;
+		clock-names = "i2c";
 	};
 
 	i2c_7: i2c at 12CD0000 {
@@ -240,6 +272,8 @@
 		interrupts = <0 63 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&clock 301>;
+		clock-names = "i2c";
 	};
 
 	i2c_8: i2c at 12CE0000 {
@@ -248,6 +282,8 @@
 		interrupts = <0 64 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&clock 302>;
+		clock-names = "i2c";
 	};
 
 	i2c at 121D0000 {
@@ -255,6 +291,8 @@
                 reg = <0x121D0000 0x100>;
                 #address-cells = <1>;
                 #size-cells = <0>;
+		clocks = <&clock 288>;
+		clock-names = "i2c";
 	};
 
 	spi_0: spi at 12d20000 {
@@ -265,6 +303,8 @@
 		rx-dma-channel = <&pdma0 4>; /* preliminary */
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&clock 304>, <&clock 154>;
+		clock-names = "spi", "spi_busclk0";
 	};
 
 	spi_1: spi at 12d30000 {
@@ -275,6 +315,8 @@
 		rx-dma-channel = <&pdma1 4>; /* preliminary */
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&clock 305>, <&clock 155>;
+		clock-names = "spi", "spi_busclk0";
 	};
 
 	spi_2: spi at 12d40000 {
@@ -285,6 +327,8 @@
 		rx-dma-channel = <&pdma0 6>; /* preliminary */
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&clock 306>, <&clock 156>;
+		clock-names = "spi", "spi_busclk0";
 	};
 
 	dwmmc_0: dwmmc0 at 12200000 {
@@ -293,6 +337,8 @@
 		interrupts = <0 75 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&clock 280>, <&clock 139>;
+		clock-names = "biu", "ciu";
 	};
 
 	dwmmc_1: dwmmc1 at 12210000 {
@@ -301,6 +347,8 @@
 		interrupts = <0 76 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&clock 281>, <&clock 140>;
+		clock-names = "biu", "ciu";
 	};
 
 	dwmmc_2: dwmmc2 at 12220000 {
@@ -309,6 +357,8 @@
 		interrupts = <0 77 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&clock 282>, <&clock 141>;
+		clock-names = "biu", "ciu";
 	};
 
 	dwmmc_3: dwmmc3 at 12230000 {
@@ -317,6 +367,8 @@
 		interrupts = <0 78 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&clock 283>, <&clock 142>;
+		clock-names = "biu", "ciu";
 	};
 
 	usb at 12110000 {
@@ -342,24 +394,32 @@
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x121A0000 0x1000>;
 			interrupts = <0 34 0>;
+			clocks = <&clock 275>;
+			clock-names = "apb_pclk";
 		};
 
 		pdma1: pdma at 121B0000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x121B0000 0x1000>;
 			interrupts = <0 35 0>;
+			clocks = <&clock 276>;
+			clock-names = "apb_pclk";
 		};
 
 		mdma0: mdma at 10800000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x10800000 0x1000>;
 			interrupts = <0 33 0>;
+			clocks = <&clock 271>;
+			clock-names = "apb_pclk";
 		};
 
 		mdma1: mdma at 11C10000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x11C10000 0x1000>;
 			interrupts = <0 124 0>;
+			clocks = <&clock 271>;
+			clock-names = "apb_pclk";
 		};
 	};
 
@@ -616,6 +676,8 @@
 		reg = <0x13e00000 0x1000>;
 		interrupts = <0 85 0>;
 		samsung,power-domain = <&pd_gsc>;
+		clocks = <&clock 256>;
+		clock-names = "gscl";
 	};
 
 	gsc_1:  gsc at 0x13e10000 {
@@ -623,6 +685,8 @@
 		reg = <0x13e10000 0x1000>;
 		interrupts = <0 86 0>;
 		samsung,power-domain = <&pd_gsc>;
+		clocks = <&clock 257>;
+		clock-names = "gscl";
 	};
 
 	gsc_2:  gsc at 0x13e20000 {
@@ -630,6 +694,8 @@
 		reg = <0x13e20000 0x1000>;
 		interrupts = <0 87 0>;
 		samsung,power-domain = <&pd_gsc>;
+		clocks = <&clock 258>;
+		clock-names = "gscl";
 	};
 
 	gsc_3:  gsc at 0x13e30000 {
@@ -637,12 +703,18 @@
 		reg = <0x13e30000 0x1000>;
 		interrupts = <0 88 0>;
 		samsung,power-domain = <&pd_gsc>;
+		clocks = <&clock 259>;
+		clock-names = "gscl";
 	};
 
 	hdmi {
 		compatible = "samsung,exynos5-hdmi";
 		reg = <0x14530000 0x70000>;
 		interrupts = <0 95 0>;
+		clocks = <&clock 333>, <&clock 136>, <&clock 137>,
+				<&clock 333>, <&clock 333>;
+		clock-names = "hdmi", "sclk_hdmi", "sclk_pixel",
+				"sclk_hdmiphy", "hdmiphy";
 	};
 
 	mixer: mixer {
-- 
1.7.5.4
