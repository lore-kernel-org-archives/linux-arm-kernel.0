From: tushar.behera@linaro.org (Tushar Behera)
Date: Fri, 25 Jan 2013 15:14:14 +0530
Subject: [PATCH V3] ARM: DTS: exynos5250-arndale: Add initial board support
 file
Message-ID: <1359107054-7177-1-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Girish K S <ks.giri@samsung.com>

Arndale is a low cost board based on the Samsung Exynos5250 SoC. This
patch adds initial device tree support for this board.

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Girish K S <ks.giri@samsung.com>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
Changes for V3:
  * Removed unused GPIO lines for dwmmc2.

Changes for V2:
  * Addressed review comments from Sachin.
  * Fixed GPIO numbers for dwmmc0 and dwmmc2.

 arch/arm/boot/dts/Makefile               |    1 +
 arch/arm/boot/dts/exynos5250-arndale.dts |  122 ++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5250-arndale.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5ebb44f..e21f27c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -43,6 +43,7 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
 	exynos4210-smdkv310.dtb \
 	exynos4210-trats.dtb \
 	exynos4412-smdk4412.dtb \
+	exynos5250-arndale.dtb \
 	exynos5250-smdk5250.dtb \
 	exynos5250-snow.dtb \
 	exynos5440-ssdk5440.dtb
diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
new file mode 100644
index 0000000..63572f9
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -0,0 +1,122 @@
+/*
+ * Samsung's Exynos5250 based Arndale board device tree source
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
+/include/ "exynos5250.dtsi"
+
+/ {
+	model = "Insignal Arndale evaluation board based on EXYNOS5250";
+	compatible = "insignal,arndale", "samsung,exynos5250";
+
+	memory {
+		reg = <0x40000000 0x80000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttySAC2,115200";
+	};
+
+	i2c at 12C60000 {
+		status = "disabled";
+	};
+
+	i2c at 12C70000 {
+		status = "disabled";
+	};
+
+	i2c at 12C80000 {
+		status = "disabled";
+	};
+
+	i2c at 12C90000 {
+		status = "disabled";
+	};
+
+	i2c at 12CA0000 {
+		status = "disabled";
+	};
+
+	i2c at 12CB0000 {
+		status = "disabled";
+	};
+
+	i2c at 12CC0000 {
+		status = "disabled";
+	};
+
+	i2c at 12CD0000 {
+		status = "disabled";
+	};
+
+	i2c at 121D0000 {
+		status = "disabled";
+	};
+
+	dwmmc_0: dwmmc0 at 12200000 {
+		num-slots = <1>;
+		supports-highspeed;
+		broken-cd;
+		fifo-depth = <0x80>;
+		card-detect-delay = <200>;
+		samsung,dw-mshc-ciu-div = <3>;
+		samsung,dw-mshc-sdr-timing = <2 3>;
+		samsung,dw-mshc-ddr-timing = <1 2>;
+
+		slot at 0 {
+			reg = <0>;
+			bus-width = <8>;
+			gpios = <&gpc0 0 2 0 3>, <&gpc0 1 2 0 3>,
+				<&gpc0 3 2 3 3>, <&gpc0 4 2 3 3>,
+				<&gpc0 5 2 3 3>, <&gpc0 6 2 3 3>,
+				<&gpc1 0 2 3 3>, <&gpc1 1 2 3 3>,
+				<&gpc1 2 2 3 3>, <&gpc1 3 2 3 3>;
+		};
+	};
+
+	dwmmc_1: dwmmc1 at 12210000 {
+		status = "disabled";
+	};
+
+	dwmmc_2: dwmmc2 at 12220000 {
+		num-slots = <1>;
+		supports-highspeed;
+		fifo-depth = <0x80>;
+		card-detect-delay = <200>;
+		samsung,dw-mshc-ciu-div = <3>;
+		samsung,dw-mshc-sdr-timing = <2 3>;
+		samsung,dw-mshc-ddr-timing = <1 2>;
+
+		slot at 0 {
+			reg = <0>;
+			bus-width = <4>;
+			samsung,cd-pinmux-gpio = <&gpc3 2 2 3 3>;
+			gpios = <&gpc3 0 2 0 3>, <&gpc3 1 2 0 3>,
+				<&gpc3 3 2 3 3>, <&gpc3 4 2 3 3>,
+				<&gpc3 5 2 3 3>, <&gpc3 6 2 3 3>;
+		};
+	};
+
+	dwmmc_3: dwmmc3 at 12230000 {
+		status = "disabled";
+	};
+
+	spi_0: spi at 12d20000 {
+		status = "disabled";
+	};
+
+	spi_1: spi at 12d30000 {
+		status = "disabled";
+	};
+
+	spi_2: spi at 12d40000 {
+		status = "disabled";
+	};
+};
-- 
1.7.4.1
