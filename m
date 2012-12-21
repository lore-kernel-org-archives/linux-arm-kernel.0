From: tobetter@gmail.com (Dongjin Kim)
Date: Sat, 22 Dec 2012 02:37:00 +0900
Subject: [PATCH v2 1/4] ODROID-X: dts: Add board dts file for ODROID-X
In-Reply-To: <1356111423-3454-1-git-send-email-tobetter@gmail.com>
References: <1356111423-3454-1-git-send-email-tobetter@gmail.com>
Message-ID: <1356111423-3454-2-git-send-email-tobetter@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial dtb file for Hardkernel's ODROID-X board based on EXYNOS4412 SoC.

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 arch/arm/boot/dts/Makefile               |    1 +
 arch/arm/boot/dts/exynos4412-odroidx.dts |   47 ++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos4412-odroidx.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d077ef8..364d67b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -44,6 +44,7 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
 	exynos4210-trats.dtb \
 	exynos5250-smdk5250.dtb \
 	exynos5440-ssdk5440.dtb \
+	exynos4412-odroidx.dtb \
 	exynos4412-smdk4412.dtb \
 	exynos5250-smdk5250.dtb \
 	exynos5250-snow.dtb
diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
new file mode 100644
index 0000000..323ed177
--- /dev/null
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -0,0 +1,47 @@
+/*
+ * Hardkernel's Exynos4412 based ODROID-X board device tree source
+ *
+ * Copyright (c) 2012 Dongjin Kim <tobetter@gmail.com>
+ *
+ * Device tree source file for Hardkernel's ODROID-X board which is based on
+ * Samsung's Exynos4412 SoC.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/dts-v1/;
+/include/ "exynos4412.dtsi"
+
+/ {
+	model = "Hardkernel ODROID-X board based on Exynos4412";
+	compatible = "hardkernel,exynos4412", "samsung,exynos4412";
+
+	memory {
+		reg = <0x40000000 0x40000000>;
+	};
+
+	serial at 13800000 {
+		status = "okay";
+	};
+
+	serial at 13810000 {
+		status = "okay";
+	};
+
+	serial at 13820000 {
+		status = "okay";
+	};
+
+	serial at 13830000 {
+		status = "okay";
+	};
+
+	sdhci at 12530000 {
+		bus-width = <4>;
+		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
+		pinctrl-names = "default";
+		status = "okay";
+	};
+};
-- 
1.7.9.5
