From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 14 Mar 2016 11:04:09 +0900
Subject: [PATCH 04/10] ARM: dts: Add MSHC2 dt node for Exynos3250 SoC
In-Reply-To: <1457921056-21257-1-git-send-email-cw00.choi@samsung.com>
References: <1457921056-21257-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1457921056-21257-5-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the MSHC2 (Mobile Storage Host Controller) Device Tree node for
Exynos3250 SoC.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos3250-pinctrl.dtsi | 35 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos3250.dtsi         | 13 ++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250-pinctrl.dtsi b/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
index 54c587f27265..40ea7de44933 100644
--- a/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
@@ -490,6 +490,41 @@
 		samsung,pin-drv = <3>;
 	};
 
+	sd2_clk: sd2-clk {
+		samsung,pins = "gpk2-0";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd2_cmd: sd2-cmd {
+		samsung,pins = "gpk2-1";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd2_cd: sd2-cd {
+		samsung,pins = "gpk2-2";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd2_bus1: sd2-bus-width1 {
+		samsung,pins = "gpk2-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd2_bus4: sd2-bus-width4 {
+		samsung,pins = "gpk2-4", "gpk2-5", "gpk2-6";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <3>;
+	};
+
 	cam_port_b_io: cam-port-b-io {
 		samsung,pins = "gpm0-0", "gpm0-1", "gpm0-2", "gpm0-3",
 				"gpm0-4", "gpm0-5", "gpm0-6", "gpm0-7",
diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 076677384d20..2fead5730879 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -30,6 +30,7 @@
 		pinctrl1 = &pinctrl_1;
 		mshc0 = &mshc_0;
 		mshc1 = &mshc_1;
+		mshc2 = &mshc_2;
 		spi0 = &spi_0;
 		spi1 = &spi_1;
 		i2c0 = &i2c_0;
@@ -371,6 +372,18 @@
 			status = "disabled";
 		};
 
+		mshc_2: mshc at 12530000 {
+			compatible = "samsung,exynos5250-dw-mshc";
+			reg = <0x12530000 0x1000>;
+			interrupts = <0 144 0>;
+			clocks = <&cmu CLK_SDMMC2>, <&cmu CLK_SCLK_MMC2>;
+			clock-names = "biu", "ciu";
+			fifo-depth = <0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		exynos_usbphy: exynos-usbphy at 125B0000 {
 			compatible = "samsung,exynos3250-usb2-phy";
 			reg = <0x125B0000 0x100>;
-- 
1.9.1
