From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Fri, 14 Feb 2014 19:07:12 +0530
Subject: [PATCH v3 3/3] ARM: dts: add dts files for xyref5260 board
In-Reply-To: <1392385032-22015-1-git-send-email-rahul.sharma@samsung.com>
References: <1392385032-22015-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1392385032-22015-4-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch adds the dts files for xyref5260 board which
is based on Exynos5260 Evt0 sample.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 arch/arm/boot/dts/Makefile                      |    1 +
 arch/arm/boot/dts/exynos5260-xyref5260-evt0.dts |  105 +++++++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos5260-xyref5260-evt0.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index fa70ea2..c513a69 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -64,6 +64,7 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
 	exynos5250-arndale.dtb \
 	exynos5250-smdk5250.dtb \
 	exynos5250-snow.dtb \
+	exynos5260-xyref5260-evt0.dtb \
 	exynos5420-arndale-octa.dtb \
 	exynos5420-smdk5420.dtb \
 	exynos5440-sd5v1.dtb \
diff --git a/arch/arm/boot/dts/exynos5260-xyref5260-evt0.dts b/arch/arm/boot/dts/exynos5260-xyref5260-evt0.dts
new file mode 100644
index 0000000..c4efc1e
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5260-xyref5260-evt0.dts
@@ -0,0 +1,105 @@
+/*
+ * SAMSUNG XYREF5260 EVT0 board device tree source
+ *
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/dts-v1/;
+#include "exynos5260.dtsi"
+
+/ {
+	model = "SAMSUNG XYREF5260 EVT0 board based on EXYNOS5260";
+	compatible = "samsung,xyref5260", "samsung,exynos5260";
+
+	memory {
+		reg = <0x20000000 0x80000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttySAC2,115200";
+	};
+
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		fin_pll: oscillator at 0 {
+			compatible = "fixed-clock";
+			reg = <0>;
+			clock-frequency = <24000000>;
+			clock-output-names = "fin_pll";
+			#clock-cells = <0>;
+		};
+	};
+};
+
+&pinctrl_0 {
+	hdmi_hpd_irq: hdmi-hpd-irq {
+		samsung,pins = "gpx3-7";
+		samsung,pin-function = <0>;
+		samsung,pin-pud = <1>;
+		samsung,pin-drv = <0>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&mmc_0 {
+	status = "okay";
+	num-slots = <1>;
+	broken-cd;
+	bypass-smu;
+	supports-highspeed;
+	supports-hs200-mode; /* 200 Mhz */
+	fifo-depth = <0x40>;
+	card-detect-delay = <200>;
+	samsung,dw-mshc-ciu-div = <3>;
+	samsung,dw-mshc-sdr-timing = <0 4>;
+	samsung,dw-mshc-ddr-timing = <0 2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd0_rdqs &sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
+
+	slot at 0 {
+		reg = <0>;
+		bus-width = <8>;
+	};
+};
+
+&mmc_2 {
+	status = "okay";
+	num-slots = <1>;
+	supports-highspeed;
+	fifo-depth = <0x40>;
+	card-detect-delay = <200>;
+	samsung,dw-mshc-ciu-div = <3>;
+	samsung,dw-mshc-sdr-timing = <2 3>;
+	samsung,dw-mshc-ddr-timing = <1 2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
+
+	slot at 0 {
+		reg = <0>;
+		bus-width = <4>;
+		disable-wp;
+	};
+};
-- 
1.7.9.5
