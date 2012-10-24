From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 24 Oct 2012 16:35:59 +0200
Subject: [PATCH] ARM: dts: exynos4: Add support for Exynos4x12 SoCs
Message-ID: <1351089359-7318-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree sources for Exynos4x12 SoC series (currently
Exynos4212 and Exynos4412) and enables mach-exynos4-dt to support these
SoCs.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4212.dtsi      | 28 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4412.dtsi      | 28 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4x12.dtsi      | 31 +++++++++++++++++++++++++++++++
 arch/arm/mach-exynos/mach-exynos4-dt.c |  2 ++
 4 files changed, 89 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos4212.dtsi
 create mode 100644 arch/arm/boot/dts/exynos4412.dtsi
 create mode 100644 arch/arm/boot/dts/exynos4x12.dtsi

diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
new file mode 100644
index 0000000..c6ae200
--- /dev/null
+++ b/arch/arm/boot/dts/exynos4212.dtsi
@@ -0,0 +1,28 @@
+/*
+ * Samsung's Exynos4212 SoC device tree source
+ *
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Samsung's Exynos4212 SoC device nodes are listed in this file. Exynos4212
+ * based board files can include this file and provide values for board specfic
+ * bindings.
+ *
+ * Note: This file does not include device nodes for all the controllers in
+ * Exynos4212 SoC. As device tree coverage for Exynos4212 increases, additional
+ * nodes can be added to this file.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/include/ "exynos4x12.dtsi"
+
+/ {
+	compatible = "samsung,exynos4212";
+
+	gic:interrupt-controller at 10490000 {
+		cpu-offset = <0x8000>;
+	};
+};
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
new file mode 100644
index 0000000..d7dfe31
--- /dev/null
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -0,0 +1,28 @@
+/*
+ * Samsung's Exynos4412 SoC device tree source
+ *
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Samsung's Exynos4412 SoC device nodes are listed in this file. Exynos4412
+ * based board files can include this file and provide values for board specfic
+ * bindings.
+ *
+ * Note: This file does not include device nodes for all the controllers in
+ * Exynos4412 SoC. As device tree coverage for Exynos4412 increases, additional
+ * nodes can be added to this file.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/include/ "exynos4x12.dtsi"
+
+/ {
+	compatible = "samsung,exynos4412";
+
+	gic:interrupt-controller at 10490000 {
+		cpu-offset = <0x4000>;
+	};
+};
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
new file mode 100644
index 0000000..b6a66f4
--- /dev/null
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -0,0 +1,31 @@
+/*
+ * Samsung's Exynos4x12 SoCs device tree source
+ *
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Samsung's Exynos4x12 SoCs device nodes are listed in this file. Exynos4x12
+ * based board files can include this file and provide values for board specfic
+ * bindings.
+ *
+ * Note: This file does not include device nodes for all the controllers in
+ * Exynos4x12 SoC. As device tree coverage for Exynos4x12 increases, additional
+ * nodes can be added to this file.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/include/ "exynos4.dtsi"
+/include/ "exynos4x12-pinctrl.dtsi"
+
+/ {
+	combiner:interrupt-controller at 10440000 {
+		interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
+			     <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
+			     <0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
+			     <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>,
+			     <0 16 0>, <0 17 0>, <0 18 0>, <0 19 0>;
+	};
+};
diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
index 977bd39..b2b9cc1 100644
--- a/arch/arm/mach-exynos/mach-exynos4-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
@@ -94,6 +94,8 @@ static void __init exynos4_dt_machine_init(void)
 
 static char const *exynos4_dt_compat[] __initdata = {
 	"samsung,exynos4210",
+	"samsung,exynos4212",
+	"samsung,exynos4412",
 	NULL
 };
 
-- 
1.7.12
