From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 12 Feb 2012 02:34:44 +0900
Subject: [PATCH v2 10/11] ARM: dts: add initial dts file for EXYNOS5250,
 SMDK5250
In-Reply-To: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
References: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1328981685-8602-11-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds initial dts file for EXYNOS5250 SoC. This dts
file is including the SoC specific devices and properties. And
adds the dts file for SMDK5250 board which uses the EXYNOS5250
dts file. Its board specific properites will be added later.

Cc: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/boot/dts/exynos5250-smdk5250.dts |   26 ++
 arch/arm/boot/dts/exynos5250.dtsi         |  413 +++++++++++++++++++++++++++++
 2 files changed, 439 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5250-smdk5250.dts
 create mode 100644 arch/arm/boot/dts/exynos5250.dtsi

diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
new file mode 100644
index 0000000..491539a
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -0,0 +1,26 @@
+/*
+ * SAMSUNG SMDK5250 board device tree source
+ *
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
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
+	model = "SAMSUNG SMDK5250 board based on EXYNOS5250";
+	compatible = "samsung,smdk5250", "samsung,exynos5250";
+
+	memory {
+		reg = <0x40000000 0x80000000>;
+	};
+
+	chosen {
+		bootargs = "root=/dev/ram0 rw ramdisk=8192 rootfstype=squashfs initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc";
+	};
+};
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
new file mode 100644
index 0000000..3e70608
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -0,0 +1,413 @@
+/*
+ * SAMSUNG EXYNOS5250 SoC device tree source
+ *
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * SAMSUNG EXYNOS5250 SoC device nodes are listed in this file.
+ * EXYNOS5250 based board files can include this file and provide
+ * values for board specfic bindings.
+ *
+ * Note: This file does not include device nodes for all the controllers in
+ * EXYNOS5250 SoC. As device tree coverage for EXYNOS5250 increases,
+ * additional nodes can be added to this file.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "samsung,exynos5250";
+	interrupt-parent = <&gic>;
+
+	gic:interrupt-controller at 10490000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x10490000 0x1000>, <0x10480000 0x100>;
+	};
+
+	watchdog at 101D0000 {
+		compatible = "samsung,s3c2410-wdt";
+		reg = <0x101D0000 0x100>;
+		interrupts = <0 42 0>;
+	};
+
+	rtc at 101E0000 {
+		compatible = "samsung,s3c6410-rtc";
+		reg = <0x101E0000 0x100>;
+		interrupts = <0 43 0>, <0 44 0>;
+	};
+
+	sdhci at 12200000 {
+		compatible = "samsung,exynos4210-sdhci";
+		reg = <0x12200000 0x100>;
+		interrupts = <0 75 0>;
+	};
+
+	sdhci at 12210000 {
+		compatible = "samsung,exynos4210-sdhci";
+		reg = <0x12210000 0x100>;
+		interrupts = <0 76 0>;
+	};
+
+	sdhci at 12220000 {
+		compatible = "samsung,exynos4210-sdhci";
+		reg = <0x12220000 0x100>;
+		interrupts = <0 77 0>;
+	};
+
+	sdhci at 12230000 {
+		compatible = "samsung,exynos4210-sdhci";
+		reg = <0x12230000 0x100>;
+		interrupts = <0 78 0>;
+	};
+
+	serial at 12C00000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0x12C00000 0x100>;
+		interrupts = <0 51 0>;
+	};
+
+	serial at 12C10000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0x12C10000 0x100>;
+		interrupts = <0 52 0>;
+	};
+
+	serial at 12C20000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0x12C20000 0x100>;
+		interrupts = <0 53 0>;
+	};
+
+	serial at 12C30000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0x12C30000 0x100>;
+		interrupts = <0 54 0>;
+	};
+
+	i2c at 12C60000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x12C60000 0x100>;
+		interrupts = <0 56 0>;
+	};
+
+	i2c at 12C70000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x12C70000 0x100>;
+		interrupts = <0 57 0>;
+	};
+
+	i2c at 12C80000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x12C80000 0x100>;
+		interrupts = <0 58 0>;
+	};
+
+	i2c at 12C90000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x12C90000 0x100>;
+		interrupts = <0 59 0>;
+	};
+
+	i2c at 12CA0000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x12CA0000 0x100>;
+		interrupts = <0 60 0>;
+	};
+
+	i2c at 12CB0000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x12CB0000 0x100>;
+		interrupts = <0 61 0>;
+	};
+
+	i2c at 12CC0000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x12CC0000 0x100>;
+		interrupts = <0 62 0>;
+	};
+
+	i2c at 12CD0000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x12CD0000 0x100>;
+		interrupts = <0 63 0>;
+	};
+
+	amba {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "arm,amba-bus";
+		interrupt-parent = <&gic>;
+		ranges;
+
+		pdma0: pdma at 121A0000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x121A0000 0x1000>;
+			interrupts = <0 34 0>;
+		};
+
+		pdma1: pdma at 121B0000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x121B0000 0x1000>;
+			interrupts = <0 35 0>;
+		};
+
+		mdma0: pdma at 10800000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x10800000 0x1000>;
+			interrupts = <0 33 0>;
+		};
+
+		mdma1: pdma at 11C10000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x11C10000 0x1000>;
+			interrupts = <0 124 0>;
+		};
+	};
+
+	gpio-controllers {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		gpio-controller;
+		ranges;
+
+		gpa0: gpio-controller at 11400000 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11400000 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpa1: gpio-controller at 11400020 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11400020 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpa2: gpio-controller at 11400040 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11400040 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpb0: gpio-controller at 11400060 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11400060 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpb1: gpio-controller at 11400080 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11400080 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpb2: gpio-controller at 114000A0 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x114000A0 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpb3: gpio-controller at 114000C0 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x114000C0 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpc0: gpio-controller at 114000E0 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x114000E0 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpc1: gpio-controller at 11400100 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11400100 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpc2: gpio-controller at 11400120 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11400120 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpc3: gpio-controller at 11400140 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11400140 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpd0: gpio-controller at 11400160 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11400160 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpd1: gpio-controller at 11400180 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11400180 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpy0: gpio-controller at 114001A0 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x114001A0 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpy1: gpio-controller at 114001C0 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x114001C0 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpy2: gpio-controller at 114001E0 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x114001E0 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpy3: gpio-controller at 11400200 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11400200 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpy4: gpio-controller at 11400220 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11400220 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpy5: gpio-controller at 11400240 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11400240 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpy6: gpio-controller at 11400260 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11400260 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpx0: gpio-controller at 11400C00 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11400C00 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpx1: gpio-controller at 11400C20 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11400C20 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpx2: gpio-controller at 11400C40 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11400C40 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpx3: gpio-controller at 11400C60 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11400C60 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpe0: gpio-controller at 13400000 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x13400000 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpe1: gpio-controller at 13400020 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x13400020 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpf0: gpio-controller at 13400040 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x13400040 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpf1: gpio-controller at 13400060 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x13400060 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpg0: gpio-controller at 13400080 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x13400080 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpg1: gpio-controller at 134000A0 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x134000A0 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpg2: gpio-controller at 134000C0 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x134000C0 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gph0: gpio-controller at 134000E0 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x134000E0 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gph1: gpio-controller at 13400100 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x13400100 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpv0: gpio-controller at 10D10000 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x10D10000 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpv1: gpio-controller at 10D10020 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x10D10020 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpv2: gpio-controller at 10D10040 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x10D10040 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpv3: gpio-controller at 10D10060 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x10D10060 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpv4: gpio-controller at 10D10080 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x10D10080 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpz: gpio-controller at 03860000 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x03860000 0x20>;
+			#gpio-cells = <4>;
+		};
+	};
+};
-- 
1.7.4.4
