From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed,  3 Aug 2011 00:08:29 +0100
Subject: [PATCH 4/4] arm: dts: Add device tree source file for Exynos4
	platforms
In-Reply-To: <1312326509-2723-1-git-send-email-thomas.abraham@linaro.org>
References: <1312326509-2723-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1312326509-2723-5-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create a new device tree source file for Samsung's Exynos4 architecture and let
Exynos4 based boards include it. We start with a uart device nodes in the device
tree source file and incrementally add nodes as we improve the device tree
coverage for Exynos4 architecture and related boards.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/boot/dts/exynos4-smdkv310.dts |   31 ++++++++++++++
 arch/arm/boot/dts/exynos4.dtsi         |   72 ++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos4-smdkv310.dts
 create mode 100644 arch/arm/boot/dts/exynos4.dtsi

diff --git a/arch/arm/boot/dts/exynos4-smdkv310.dts b/arch/arm/boot/dts/exynos4-smdkv310.dts
new file mode 100644
index 0000000..34a00b5
--- /dev/null
+++ b/arch/arm/boot/dts/exynos4-smdkv310.dts
@@ -0,0 +1,31 @@
+/*
+ * Samsung's Exynos4 based SMDKV310 board device tree source.
+ *
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ * Copyright (c) 2010-2011 Linaro Ltd.
+ *		www.linaro.org
+ *
+ * Device tree source file for Samsung's SMDKV310 board which is based on
+ * Samsung's Exynos4 architecture.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/dts-v1/;
+/include/ "exynos4.dtsi"
+
+/ {
+	model = "Samsung Exynos4 smdkv310 eval board";
+	compatible = "samsung,smdkv310", "samsung,exynos4";
+
+	memory {
+		reg = <0x40000000 0x80000000>;
+	};
+
+	chosen {
+		bootargs ="root=/dev/ram0 rw ramdisk=8192 console=ttySAC1,115200 init=/linuxrc";
+	};
+};
diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
new file mode 100644
index 0000000..babb24d
--- /dev/null
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -0,0 +1,72 @@
+/*
+ * Samsung's Exynos4 Architecture device tree source.
+ *
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ * Copyright (c) 2010-2011 Linaro Ltd.
+ *		www.linaro.org
+ *
+ * This file acts as the core device tree for Samsung's Exynos4 based board
+ * device tree files. The Exynos4 architecture related device tree nodes
+ * will be listed in this file and Exynos4 based board device tree files
+ * should include this file.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "samsung,exynos4";
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&intc>;
+		ranges;
+
+		intc:interrupt-controller at 10490000 {
+			compatible = "samsung,exynos4-gic","arm,cortex-a9-gic";
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			reg = <0x10490000 0x1000>, <0x10480000 0x100>;
+		};
+
+		watchdog at 10060000 {
+			compatible = "samsung,s3c2410-wdt";
+			reg = <0x10060000 0x100>;
+			interrupts = <107>;
+		};
+
+		serial at 13800000 {
+			compatible = "samsung,s5pv310-uart";
+			reg = <0x13800000 0x100>;
+			interrupts = <16 18 17>;
+			samsung,uart-fifosize = <256>;
+		};
+
+		serial at 13810000 {
+			compatible = "samsung,s5pv310-uart";
+			reg = <0x13810000 0x100>;
+			interrupts = <20 22 21>;
+			samsung,uart-fifosize = <64>;
+		};
+
+		serial at 13820000 {
+			compatible = "samsung,s5pv310-uart";
+			reg = <0x13820000 0x100>;
+			interrupts = <24 26 25>;
+			samsung,uart-fifosize = <16>;
+		};
+
+		serial at 13830000 {
+			compatible = "samsung,s5pv310-uart";
+			reg = <0x13830000 0x100>;
+			interrupts = <28 30 29>;
+			samsung,uart-fifosize = <16>;
+		};
+	};
+};
-- 
1.7.4.1
