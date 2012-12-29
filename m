From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sat, 29 Dec 2012 15:04:52 -0800
Subject: [PATCH] ARM: dts: add board dts file for EXYNOS4412 based Origen board
Message-ID: <1356822292-26465-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a minimal board dts file for EXYNOS4412 based Insignal Origen board.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/boot/dts/Makefile              |    1 +
 arch/arm/boot/dts/exynos4412-origen.dts |   45 +++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos4412-origen.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e44da40..c84f9f7 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -43,6 +43,7 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
 	exynos4210-smdkv310.dtb \
 	exynos4210-trats.dtb \
 	exynos4412-smdk4412.dtb \
+	exynos4412-origen.dtb \
 	exynos5250-smdk5250.dtb \
 	exynos5250-snow.dtb \
 	exynos5440-ssdk5440.dtb
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
new file mode 100644
index 0000000..df880c4
--- /dev/null
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -0,0 +1,45 @@
+/*
+ * Insignal's Exynos4412 based Origen board device tree source
+ *
+ * Copyright (c) 2012-2013 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Device tree source file for Insignal's Origen board which is based on
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
+	model = "Insignal Origen evaluation board based on Exynos4412";
+	compatible = "insignal,origen4412", "samsung,exynos4412";
+
+	memory {
+		reg = <0x40000000 0x40000000>;
+	};
+
+	chosen {
+		bootargs ="console=ttySAC2,115200";
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
+};
-- 
1.7.5.4
