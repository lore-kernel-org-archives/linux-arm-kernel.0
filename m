From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Wed, 12 Mar 2014 20:46:34 +0530
Subject: [PATCH v5 3/3] ARM: dts: add dts files for xyref5260 board
In-Reply-To: <1394637394-3960-1-git-send-email-rahul.sharma@samsung.com>
References: <1394637394-3960-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1394637394-3960-4-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch adds the dts files for xyref5260 board which
is based on Exynos5260 Evt0 sample.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 arch/arm/boot/dts/Makefile                      |    1 +
 arch/arm/boot/dts/exynos5260-xyref5260-evt0.dts |  110 +++++++++++++++++++++++
 2 files changed, 111 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos5260-xyref5260-evt0.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b9d6a8b..5a391bf 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -72,6 +72,7 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
 	exynos5250-arndale.dtb \
 	exynos5250-smdk5250.dtb \
 	exynos5250-snow.dtb \
+	exynos5260-xyref5260-evt0.dtb \
 	exynos5420-arndale-octa.dtb \
 	exynos5420-smdk5420.dtb \
 	exynos5440-sd5v1.dtb \
diff --git a/arch/arm/boot/dts/exynos5260-xyref5260-evt0.dts b/arch/arm/boot/dts/exynos5260-xyref5260-evt0.dts
new file mode 100644
index 0000000..d7d0aeb
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5260-xyref5260-evt0.dts
@@ -0,0 +1,110 @@
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
+		fin_pll: xxti {
+			compatible = "fixed-clock";
+			clock-frequency = <24000000>;
+			clock-output-names = "fin_pll";
+			#clock-cells = <0>;
+		};
+
+		xrtcxti: xrtcxti {
+			compatible = "fixed-clock";
+			clock-frequency = <32768>;
+			clock-output-names = "xrtcxti";
+		};
+
+		spdif_extclk: ioclk_spdif_extclk {
+			compatible = "fixed-clock";
+			clock-frequency = <49152000>;
+			clock-output-names = "ioclk_spdif_extclk";
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
