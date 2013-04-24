From: vkale@apm.com (Vinayak Kale)
Date: Wed, 24 Apr 2013 14:37:00 +0530
Subject: [PATCH V3 4/4] arm64: Add initial DTS for APM X-Gene Storm SOC and
 APM Mustang board
In-Reply-To: <1366794420-17849-1-git-send-email-vkale@apm.com>
References: <1366794420-17849-1-git-send-email-vkale@apm.com>
Message-ID: <1366794420-17849-5-git-send-email-vkale@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds initial DTS files required for APM Mustang board.

Signed-off-by: Kumar Sankaran <ksankaran@apm.com>
Signed-off-by: Loc Ho <lho@apm.com>
Signed-off-by: Feng Kan <fkan@apm.com>
---
 arch/arm64/boot/dts/Makefile        |    1 +
 arch/arm64/boot/dts/apm-mustang.dts |   26 ++++++++
 arch/arm64/boot/dts/apm-storm.dtsi  |  116 +++++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/boot/dts/apm-mustang.dts
 create mode 100644 arch/arm64/boot/dts/apm-storm.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 68457e9..c52bdb0 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -1,4 +1,5 @@
 dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb foundation-v8.dtb
+dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
 
 targets += dtbs
 targets += $(dtb-y)
diff --git a/arch/arm64/boot/dts/apm-mustang.dts b/arch/arm64/boot/dts/apm-mustang.dts
new file mode 100644
index 0000000..1247ca1
--- /dev/null
+++ b/arch/arm64/boot/dts/apm-mustang.dts
@@ -0,0 +1,26 @@
+/*
+ * dts file for AppliedMicro (APM) Mustang Board
+ *
+ * Copyright (C) 2013, Applied Micro Circuits Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+/dts-v1/;
+
+/include/ "apm-storm.dtsi"
+
+/ {
+	model = "APM X-Gene Mustang board";
+	compatible = "apm,mustang", "apm,xgene-storm";
+
+	chosen { };
+
+	memory {
+		device_type = "memory";
+		reg = < 0x1 0x00000000 0x0 0x80000000 >; /* Updated by bootloader */
+	};
+};
diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
new file mode 100644
index 0000000..bfdc578
--- /dev/null
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -0,0 +1,116 @@
+/*
+ * dts file for AppliedMicro (APM) X-Gene Storm SOC
+ *
+ * Copyright (C) 2013, Applied Micro Circuits Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+/ {
+	compatible = "apm,xgene-storm";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu at 000 {
+			device_type = "cpu";
+			compatible = "apm,potenza", "arm,armv8";
+			reg = <0x0 0x000>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x1 0x0000fff8>;
+		};
+		cpu at 001 {
+			device_type = "cpu";
+			compatible = "apm,potenza", "arm,armv8";
+			reg = <0x0 0x001>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x1 0x0000fff8>;
+		};
+		cpu at 100 {
+			device_type = "cpu";
+			compatible = "apm,potenza", "arm,armv8";
+			reg = <0x0 0x100>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x1 0x0000fff8>;
+		};
+		cpu at 101 {
+			device_type = "cpu";
+			compatible = "apm,potenza", "arm,armv8";
+			reg = <0x0 0x101>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x1 0x0000fff8>;
+		};
+		cpu at 200 {
+			device_type = "cpu";
+			compatible = "apm,potenza", "arm,armv8";
+			reg = <0x0 0x200>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x1 0x0000fff8>;
+		};
+		cpu at 201 {
+			device_type = "cpu";
+			compatible = "apm,potenza", "arm,armv8";
+			reg = <0x0 0x201>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x1 0x0000fff8>;
+		};
+		cpu at 300 {
+			device_type = "cpu";
+			compatible = "apm,potenza", "arm,armv8";
+			reg = <0x0 0x300>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x1 0x0000fff8>;
+		};
+		cpu at 301 {
+			device_type = "cpu";
+			compatible = "apm,potenza", "arm,armv8";
+			reg = <0x0 0x301>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x1 0x0000fff8>;
+		};
+	};
+
+	gic: interrupt-controller at 78010000 {
+		compatible = "arm,cortex-a15-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x0 0x78010000 0x0 0x1000>,	/* GIC Dist */
+		      <0x0 0x78020000 0x0 0x1000>,	/* GIC CPU */
+		      <0x0 0x78040000 0x0 0x2000>,	/* GIC VCPU Control */
+		      <0x0 0x78060000 0x0 0x2000>;	/* GIC VCPU */
+		interrupts = <1 9 0xf04>;	/* GIC Maintenence IRQ */
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <1 0 0xff01>,	/* Secure Phys IRQ */
+			     <1 13 0xff01>,	/* Non-secure Phys IRQ */
+			     <1 14 0xff01>,	/* Virt IRQ */
+			     <1 15 0xff01>;	/* Hyp IRQ */
+		clock-frequency = <50000000>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		serial0: serial at 1c020000 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0 0x1c020000 0x0 0x1000>;
+			reg-shift = <2>;
+			clock-frequency = <10000000>; /* Updated by bootloader */
+			interrupt-parent = <&gic>;
+			interrupts = <0x0 0x4c 0x4>;
+		};
+	};
+};
-- 
1.7.4.1
