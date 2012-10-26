From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 27 Oct 2012 02:55:51 +0900
Subject: [PATCH 5/7] ARM: dts: add clock controller node for Samsung EXYNOS5440
In-Reply-To: <1351274153-3120-1-git-send-email-kgene.kim@samsung.com>
References: <1351274153-3120-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1351274153-3120-5-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.abraham@linaro.org>

This patch add device tree nodes for representing the clock controller
module in Samsung EXYNOS5440 SoC.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/boot/dts/exynos5440-clock.dtsi |  143 +++++++++++++++++++++++++++++++
 1 files changed, 143 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5440-clock.dtsi

diff --git a/arch/arm/boot/dts/exynos5440-clock.dtsi b/arch/arm/boot/dts/exynos5440-clock.dtsi
new file mode 100644
index 0000000..062f29f
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5440-clock.dtsi
@@ -0,0 +1,143 @@
+/*
+ * Samsung's EXYNOS5440 SoC clock nodes
+ *
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/ {
+	xmu {
+		compatible = "samsung,exynos5440-xmu";
+		reg = <0x160000 0x1000>;
+
+		xtal: xtal {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-output-names = "xtal";
+			clock-frequency = <50000000>;
+		};
+
+		peri_pll: peri-pll {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-output-names = "xusbxti";
+			clock-frequency = <1000000000>;
+		};
+
+		peri_250mhz: peri-250mhz {
+			compatible = "samsung,fixed-factor-clock";
+			#clock-cells = <0>;
+			clock-output-names = "peri-250mhz";
+			clocks = <&peri_pll>;
+			clock-fixed-factor-div = <4>;
+		};
+
+		peri_200mhz: peri-200mhz {
+			compatible = "samsung,fixed-factor-clock";
+			#clock-cells = <0>;
+			clock-output-names = "peri-200mhz";
+			clocks = <&peri_pll>;
+			clock-fixed-factor-div = <5>;
+		};
+
+		peri_125mhz: peri-125mhz {
+			compatible = "samsung,fixed-factor-clock";
+			#clock-cells = <0>;
+			clock-output-names = "peri-125mhz";
+			clocks = <&peri_250mhz>;
+			clock-fixed-factor-div = <2>;
+		};
+
+		b250_clk: b250-clk {
+			compatible = "samsung,clock-gate";
+			#clock-cells = <0>;
+			clock-output-names = "b250-clk";
+			clocks = <&peri_250mhz>;
+			reg-info = <0xf4 0>;
+		};
+
+		pb0250_clk: pb0250-clk {
+			compatible = "samsung,clock-gate";
+			#clock-cells = <0>;
+			clock-output-names = "pb0250-clk";
+			clocks = <&peri_250mhz>;
+			reg-info = <0xf4 1>;
+		};
+
+		pr0250_clk: pr0250-clk {
+			compatible = "samsung,clock-gate";
+			#clock-cells = <0>;
+			clock-output-names = "pr0250-clk";
+			clocks = <&peri_250mhz>;
+			reg-info = <0xf4 2>;
+		};
+
+		pr1250_clk: pr1250-clk {
+			compatible = "samsung,clock-gate";
+			#clock-cells = <0>;
+			clock-output-names = "pr1250-clk";
+			clocks = <&peri_250mhz>;
+			reg-info = <0xf4 3>;
+		};
+
+		cs250_clk: cs250-clk {
+			compatible = "samsung,clock-gate";
+			#clock-cells = <0>;
+			clock-output-names = "cs250-clk";
+			clocks = <&peri_250mhz>;
+			reg-info = <0xf4 4>;
+		};
+
+		drex_pclk: drex-pclk {
+			compatible = "samsung,clock-gate";
+			#clock-cells = <0>;
+			clock-output-names = "drex-pclk";
+			clocks = <&peri_125mhz>;
+			reg-info = <0xf4 5>;
+		};
+
+		b125_pclk: b125-pclk {
+			compatible = "samsung,clock-gate";
+			#clock-cells = <0>;
+			clock-output-names = "b125-pclk";
+			clocks = <&peri_125mhz>;
+			reg-info = <0xf4 6>;
+		};
+
+		b200_clk: b200-clk {
+			compatible = "samsung,clock-gate";
+			#clock-cells = <0>;
+			clock-output-names = "b200-clk";
+			clocks = <&peri_200mhz>;
+			reg-info = <0xf4 7>;
+		};
+
+		sata_clk: sata-clk {
+			compatible = "samsung,clock-gate";
+			#clock-cells = <0>;
+			clock-output-names = "sata-clk";
+			clocks = <&peri_200mhz>;
+			reg-info = <0xf4 8>;
+		};
+
+		usb_clk: usb-clk {
+			compatible = "samsung,clock-gate";
+			#clock-cells = <0>;
+			clock-output-names = "usb-clk";
+			clocks = <&peri_200mhz>;
+			reg-info = <0xf4 9>;
+		};
+
+		gmac0_clk: gmac0-clk {
+			compatible = "samsung,clock-gate";
+			#clock-cells = <0>;
+			clock-output-names = "gmac0-clk";
+			clocks = <&peri_200mhz>;
+			reg-info = <0xf4 10>;
+		};
+	};
+};
-- 
1.7.4.4
