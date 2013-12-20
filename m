From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Fri, 20 Dec 2013 18:27:25 +0530
Subject: [PATCH 2/3] ARM: dts: replace clock numbers with macros for exynos5420
In-Reply-To: <1387544246-31658-1-git-send-email-rahul.sharma@samsung.com>
References: <1387544246-31658-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1387544246-31658-3-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT nodes contain clock numbers which are referred by drivers
to get the clocks. These numbers are replaced by MACROs
which are defined in the exynos5420-clk.h header file.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi |   47 +++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index e552608..db8b2da 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -17,6 +17,7 @@
 #include "exynos5420-pinctrl.dtsi"
 
 #include <dt-bindings/clk/exynos-audss-clk.h>
+#include <dt-bindings/clk/exynos5420-clk.h>
 
 / {
 	compatible = "samsung,exynos5420";
@@ -62,7 +63,7 @@
 		compatible = "samsung,exynos5420-audss-clock";
 		reg = <0x03810000 0x0C>;
 		#clock-cells = <1>;
-		clocks = <&clock 148>;
+		clocks = <&clock SCLK_MAUDIO0>;
 		clock-names = "sclk_audio";
 	};
 
@@ -70,7 +71,7 @@
 		compatible = "samsung,mfc-v7";
 		reg = <0x11000000 0x10000>;
 		interrupts = <0 96 0>;
-		clocks = <&clock 401>;
+		clocks = <&clock ACLK_MFC>;
 		clock-names = "mfc";
 	};
 
@@ -80,7 +81,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		reg = <0x12200000 0x2000>;
-		clocks = <&clock 351>, <&clock 132>;
+		clocks = <&clock ACLK_MMC0>, <&clock SCLK_MMC0>;
 		clock-names = "biu", "ciu";
 		fifo-depth = <0x40>;
 		status = "disabled";
@@ -92,7 +93,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		reg = <0x12210000 0x2000>;
-		clocks = <&clock 352>, <&clock 133>;
+		clocks = <&clock ACLK_MMC1>, <&clock SCLK_MMC1>;
 		clock-names = "biu", "ciu";
 		fifo-depth = <0x40>;
 		status = "disabled";
@@ -104,7 +105,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		reg = <0x12220000 0x1000>;
-		clocks = <&clock 353>, <&clock 134>;
+		clocks = <&clock ACLK_MMC2>, <&clock SCLK_MMC2>;
 		clock-names = "biu", "ciu";
 		fifo-depth = <0x40>;
 		status = "disabled";
@@ -118,7 +119,7 @@
 		interrupt-parent = <&mct_map>;
 		interrupts = <0>, <1>, <2>, <3>, <4>, <5>, <6>, <7>,
 				<8>, <9>, <10>, <11>;
-		clocks = <&clock 1>, <&clock 315>;
+		clocks = <&clock FIN_PLL>, <&clock PCLK_MCT>;
 		clock-names = "fin_pll", "mct";
 
 		mct_map: mct-map {
@@ -207,28 +208,28 @@
 	};
 
 	rtc at 101E0000 {
-		clocks = <&clock 317>;
+		clocks = <&clock PCLK_RTC>;
 		clock-names = "rtc";
 		status = "okay";
 	};
 
 	serial at 12C00000 {
-		clocks = <&clock 257>, <&clock 128>;
+		clocks = <&clock PCLK_UART0>, <&clock SCLK_UART0>;
 		clock-names = "uart", "clk_uart_baud0";
 	};
 
 	serial at 12C10000 {
-		clocks = <&clock 258>, <&clock 129>;
+		clocks = <&clock PCLK_UART1>, <&clock SCLK_UART1>;
 		clock-names = "uart", "clk_uart_baud0";
 	};
 
 	serial at 12C20000 {
-		clocks = <&clock 259>, <&clock 130>;
+		clocks = <&clock PCLK_UART2>, <&clock SCLK_UART2>;
 		clock-names = "uart", "clk_uart_baud0";
 	};
 
 	serial at 12C30000 {
-		clocks = <&clock 260>, <&clock 131>;
+		clocks = <&clock PCLK_UART3>, <&clock SCLK_UART3>;
 		clock-names = "uart", "clk_uart_baud0";
 	};
 
@@ -239,14 +240,14 @@
 	};
 
 	dp-controller at 145B0000 {
-		clocks = <&clock 412>;
+		clocks = <&clock PCLK_DP1>;
 		clock-names = "dp";
 		phys = <&dp_phy>;
 		phy-names = "dp";
 	};
 
 	fimd at 14400000 {
-		clocks = <&clock 147>, <&clock 421>;
+		clocks = <&clock SCLK_FIMD1>, <&clock ACLK_FIMD1>;
 		clock-names = "sclk_fimd", "fimd";
 	};
 
@@ -254,7 +255,7 @@
 		compatible = "samsung,exynos-adc-v2";
 		reg = <0x12D10000 0x100>, <0x10040720 0x4>;
 		interrupts = <0 106 0>;
-		clocks = <&clock 270>;
+		clocks = <&clock PCLK_TSADC>;
 		clock-names = "adc";
 		#io-channel-cells = <1>;
 		io-channel-ranges;
@@ -267,7 +268,7 @@
 		interrupts = <0 56 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clocks = <&clock 261>;
+		clocks = <&clock PCLK_I2C0>;
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c0_bus>;
@@ -280,7 +281,7 @@
 		interrupts = <0 57 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clocks = <&clock 262>;
+		clocks = <&clock PCLK_I2C1>;
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c1_bus>;
@@ -293,7 +294,7 @@
 		interrupts = <0 58 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clocks = <&clock 263>;
+		clocks = <&clock PCLK_I2C2>;
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c2_bus>;
@@ -306,7 +307,7 @@
 		interrupts = <0 59 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clocks = <&clock 264>;
+		clocks = <&clock PCLK_I2C3>;
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c3_bus>;
@@ -317,8 +318,8 @@
 		compatible = "samsung,exynos5420-hdmi";
 		reg = <0x14530000 0x70000>;
 		interrupts = <0 95 0>;
-		clocks = <&clock 413>, <&clock 143>, <&clock 768>,
-			<&clock 158>, <&clock 640>;
+		clocks = <&clock PCLK_HDMI>, <&clock SCLK_HDMI>, <&clock DOUT_PIXEL>,
+			<&clock SCLK_HDMIPHY>, <&clock MOUT_HDMI>;
 		clock-names = "hdmi", "sclk_hdmi", "sclk_pixel",
 			"sclk_hdmiphy", "mout_hdmi";
 		status = "disabled";
@@ -340,7 +341,7 @@
 		compatible = "samsung,exynos5420-mixer";
 		reg = <0x14450000 0x10000>;
 		interrupts = <0 94 0>;
-		clocks = <&clock 431>, <&clock 143>;
+		clocks = <&clock ACLK_MIXER>, <&clock SCLK_HDMI>;
 		clock-names = "mixer", "sclk_hdmi";
 	};
 
@@ -348,7 +349,7 @@
 		compatible = "samsung,exynos5-gsc";
 		reg = <0x13e00000 0x1000>;
 		interrupts = <0 85 0>;
-		clocks = <&clock 465>;
+		clocks = <&clock ACLK_GSCL0>;
 		clock-names = "gscl";
 		samsung,power-domain = <&gsc_pd>;
 	};
@@ -357,7 +358,7 @@
 		compatible = "samsung,exynos5-gsc";
 		reg = <0x13e10000 0x1000>;
 		interrupts = <0 86 0>;
-		clocks = <&clock 466>;
+		clocks = <&clock ACLK_GSCL1>;
 		clock-names = "gscl";
 		samsung,power-domain = <&gsc_pd>;
 	};
-- 
1.7.10.4
