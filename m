From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 03 Sep 2012 14:34:32 +0200
Subject: [PATCH 1/3] ARM: dts: Move parts common to Exynos4 from
 Exynos4210.dtsi to Exynos4.dtsi
In-Reply-To: <1346675674-16034-1-git-send-email-t.figa@samsung.com>
References: <1346675674-16034-1-git-send-email-t.figa@samsung.com>
Message-ID: <1346675674-16034-2-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most definitions from Exynos4210.dtsi can be applied for other SoCs from
Exynos4 line as well, so move the common part into separate file that
can be included by dtsi files of other Exynos4 SoCs (as well as current
Exynos4210.dtsi).

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi    | 210 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4210.dtsi | 181 +-------------------------------
 2 files changed, 211 insertions(+), 180 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos4.dtsi

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
new file mode 100644
index 0000000..e446fe7
--- /dev/null
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -0,0 +1,210 @@
+/*
+ * Samsung's Exynos4 SoC series common device tree source
+ *
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ * Copyright (c) 2010-2011 Linaro Ltd.
+ *		www.linaro.org
+ *
+ * Samsung's Exynos4 SoC series device nodes are listed in this file. Particular
+ * SoCs from Exynos4 series can include this file and provide values for SoCs
+ * specfic bindings.
+ *
+ * Note: This file does not include device nodes for all the controllers in
+ * Exynos4 SoCs. As device tree coverage for Exynos4 increases, additional
+ * nodes can be added to this file.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	interrupt-parent = <&gic>;
+
+	aliases {
+		spi0 = &spi_0;
+		spi1 = &spi_1;
+		spi2 = &spi_2;
+	};
+
+	gic:interrupt-controller at 10490000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x10490000 0x1000>, <0x10480000 0x100>;
+	};
+
+	combiner:interrupt-controller at 10440000 {
+		compatible = "samsung,exynos4210-combiner";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <0x10440000 0x1000>;
+	};
+
+	watchdog at 10060000 {
+		compatible = "samsung,s3c2410-wdt";
+		reg = <0x10060000 0x100>;
+		interrupts = <0 43 0>;
+	};
+
+	rtc at 10070000 {
+		compatible = "samsung,s3c6410-rtc";
+		reg = <0x10070000 0x100>;
+		interrupts = <0 44 0>, <0 45 0>;
+	};
+
+	keypad at 100A0000 {
+		compatible = "samsung,s5pv210-keypad";
+		reg = <0x100A0000 0x100>;
+		interrupts = <0 109 0>;
+	};
+
+	sdhci at 12510000 {
+		compatible = "samsung,exynos4210-sdhci";
+		reg = <0x12510000 0x100>;
+		interrupts = <0 73 0>;
+	};
+
+	sdhci at 12520000 {
+		compatible = "samsung,exynos4210-sdhci";
+		reg = <0x12520000 0x100>;
+		interrupts = <0 74 0>;
+	};
+
+	sdhci at 12530000 {
+		compatible = "samsung,exynos4210-sdhci";
+		reg = <0x12530000 0x100>;
+		interrupts = <0 75 0>;
+	};
+
+	sdhci at 12540000 {
+		compatible = "samsung,exynos4210-sdhci";
+		reg = <0x12540000 0x100>;
+		interrupts = <0 76 0>;
+	};
+
+	serial at 13800000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0x13800000 0x100>;
+		interrupts = <0 52 0>;
+	};
+
+	serial at 13810000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0x13810000 0x100>;
+		interrupts = <0 53 0>;
+	};
+
+	serial at 13820000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0x13820000 0x100>;
+		interrupts = <0 54 0>;
+	};
+
+	serial at 13830000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0x13830000 0x100>;
+		interrupts = <0 55 0>;
+	};
+
+	i2c at 13860000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x13860000 0x100>;
+		interrupts = <0 58 0>;
+	};
+
+	i2c at 13870000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x13870000 0x100>;
+		interrupts = <0 59 0>;
+	};
+
+	i2c at 13880000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x13880000 0x100>;
+		interrupts = <0 60 0>;
+	};
+
+	i2c at 13890000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x13890000 0x100>;
+		interrupts = <0 61 0>;
+	};
+
+	i2c at 138A0000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x138A0000 0x100>;
+		interrupts = <0 62 0>;
+	};
+
+	i2c at 138B0000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x138B0000 0x100>;
+		interrupts = <0 63 0>;
+	};
+
+	i2c at 138C0000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x138C0000 0x100>;
+		interrupts = <0 64 0>;
+	};
+
+	i2c at 138D0000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x138D0000 0x100>;
+		interrupts = <0 65 0>;
+	};
+
+	spi_0: spi at 13920000 {
+		compatible = "samsung,exynos4210-spi";
+		reg = <0x13920000 0x100>;
+		interrupts = <0 66 0>;
+		tx-dma-channel = <&pdma0 7>; /* preliminary */
+		rx-dma-channel = <&pdma0 6>; /* preliminary */
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	spi_1: spi at 13930000 {
+		compatible = "samsung,exynos4210-spi";
+		reg = <0x13930000 0x100>;
+		interrupts = <0 67 0>;
+		tx-dma-channel = <&pdma1 7>; /* preliminary */
+		rx-dma-channel = <&pdma1 6>; /* preliminary */
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	spi_2: spi at 13940000 {
+		compatible = "samsung,exynos4210-spi";
+		reg = <0x13940000 0x100>;
+		interrupts = <0 68 0>;
+		tx-dma-channel = <&pdma0 9>; /* preliminary */
+		rx-dma-channel = <&pdma0 8>; /* preliminary */
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	amba {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "arm,amba-bus";
+		interrupt-parent = <&gic>;
+		ranges;
+
+		pdma0: pdma at 12680000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x12680000 0x1000>;
+			interrupts = <0 35 0>;
+		};
+
+		pdma1: pdma at 12690000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x12690000 0x1000>;
+			interrupts = <0 36 0>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 02891fe..c71db9c 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -19,201 +19,22 @@
  * published by the Free Software Foundation.
 */
 
-/include/ "skeleton.dtsi"
+/include/ "exynos4.dtsi"
 
 / {
 	compatible = "samsung,exynos4210";
-	interrupt-parent = <&gic>;
-
-	aliases {
-		spi0 = &spi_0;
-		spi1 = &spi_1;
-		spi2 = &spi_2;
-	};
 
 	gic:interrupt-controller at 10490000 {
-		compatible = "arm,cortex-a9-gic";
-		#interrupt-cells = <3>;
-		interrupt-controller;
 		cpu-offset = <0x8000>;
-		reg = <0x10490000 0x1000>, <0x10480000 0x100>;
 	};
 
 	combiner:interrupt-controller at 10440000 {
-		compatible = "samsung,exynos4210-combiner";
-		#interrupt-cells = <2>;
-		interrupt-controller;
-		reg = <0x10440000 0x1000>;
 		interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
 			     <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
 			     <0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
 			     <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>;
 	};
 
-	watchdog at 10060000 {
-		compatible = "samsung,s3c2410-wdt";
-		reg = <0x10060000 0x100>;
-		interrupts = <0 43 0>;
-	};
-
-	rtc at 10070000 {
-		compatible = "samsung,s3c6410-rtc";
-		reg = <0x10070000 0x100>;
-		interrupts = <0 44 0>, <0 45 0>;
-	};
-
-	keypad at 100A0000 {
-		compatible = "samsung,s5pv210-keypad";
-		reg = <0x100A0000 0x100>;
-		interrupts = <0 109 0>;
-	};
-
-	sdhci at 12510000 {
-		compatible = "samsung,exynos4210-sdhci";
-		reg = <0x12510000 0x100>;
-		interrupts = <0 73 0>;
-	};
-
-	sdhci at 12520000 {
-		compatible = "samsung,exynos4210-sdhci";
-		reg = <0x12520000 0x100>;
-		interrupts = <0 74 0>;
-	};
-
-	sdhci at 12530000 {
-		compatible = "samsung,exynos4210-sdhci";
-		reg = <0x12530000 0x100>;
-		interrupts = <0 75 0>;
-	};
-
-	sdhci at 12540000 {
-		compatible = "samsung,exynos4210-sdhci";
-		reg = <0x12540000 0x100>;
-		interrupts = <0 76 0>;
-	};
-
-	serial at 13800000 {
-		compatible = "samsung,exynos4210-uart";
-		reg = <0x13800000 0x100>;
-		interrupts = <0 52 0>;
-	};
-
-	serial at 13810000 {
-		compatible = "samsung,exynos4210-uart";
-		reg = <0x13810000 0x100>;
-		interrupts = <0 53 0>;
-	};
-
-	serial at 13820000 {
-		compatible = "samsung,exynos4210-uart";
-		reg = <0x13820000 0x100>;
-		interrupts = <0 54 0>;
-	};
-
-	serial at 13830000 {
-		compatible = "samsung,exynos4210-uart";
-		reg = <0x13830000 0x100>;
-		interrupts = <0 55 0>;
-	};
-
-	i2c at 13860000 {
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x13860000 0x100>;
-		interrupts = <0 58 0>;
-	};
-
-	i2c at 13870000 {
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x13870000 0x100>;
-		interrupts = <0 59 0>;
-	};
-
-	i2c at 13880000 {
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x13880000 0x100>;
-		interrupts = <0 60 0>;
-	};
-
-	i2c at 13890000 {
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x13890000 0x100>;
-		interrupts = <0 61 0>;
-	};
-
-	i2c at 138A0000 {
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x138A0000 0x100>;
-		interrupts = <0 62 0>;
-	};
-
-	i2c at 138B0000 {
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x138B0000 0x100>;
-		interrupts = <0 63 0>;
-	};
-
-	i2c at 138C0000 {
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x138C0000 0x100>;
-		interrupts = <0 64 0>;
-	};
-
-	i2c at 138D0000 {
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x138D0000 0x100>;
-		interrupts = <0 65 0>;
-	};
-
-	spi_0: spi at 13920000 {
-		compatible = "samsung,exynos4210-spi";
-		reg = <0x13920000 0x100>;
-		interrupts = <0 66 0>;
-		tx-dma-channel = <&pdma0 7>; /* preliminary */
-		rx-dma-channel = <&pdma0 6>; /* preliminary */
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-	spi_1: spi at 13930000 {
-		compatible = "samsung,exynos4210-spi";
-		reg = <0x13930000 0x100>;
-		interrupts = <0 67 0>;
-		tx-dma-channel = <&pdma1 7>; /* preliminary */
-		rx-dma-channel = <&pdma1 6>; /* preliminary */
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-	spi_2: spi at 13940000 {
-		compatible = "samsung,exynos4210-spi";
-		reg = <0x13940000 0x100>;
-		interrupts = <0 68 0>;
-		tx-dma-channel = <&pdma0 9>; /* preliminary */
-		rx-dma-channel = <&pdma0 8>; /* preliminary */
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-	amba {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "arm,amba-bus";
-		interrupt-parent = <&gic>;
-		ranges;
-
-		pdma0: pdma at 12680000 {
-			compatible = "arm,pl330", "arm,primecell";
-			reg = <0x12680000 0x1000>;
-			interrupts = <0 35 0>;
-		};
-
-		pdma1: pdma at 12690000 {
-			compatible = "arm,pl330", "arm,primecell";
-			reg = <0x12690000 0x1000>;
-			interrupts = <0 36 0>;
-		};
-	};
-
 	gpio-controllers {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.7.12
