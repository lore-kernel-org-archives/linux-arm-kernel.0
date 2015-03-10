From: fkan@apm.com (Feng Kan)
Date: Tue, 10 Mar 2015 10:10:54 -0700
Subject: [PATCH] arm64: dts: add APM Merlin Board device tree
Message-ID: <1426007454-11848-1-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the support for APM Merlin board. The Merlin board
is based on the APM X-Gene Shadowcat SoC. This DTS enables PMU,
SATA and Serial.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 arch/arm64/boot/dts/apm/apm-merlin.dts     |  39 ++++++++
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 154 +++++++++++++++++++++++++++++
 2 files changed, 193 insertions(+)
 create mode 100644 arch/arm64/boot/dts/apm/apm-merlin.dts
 create mode 100644 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi

diff --git a/arch/arm64/boot/dts/apm/apm-merlin.dts b/arch/arm64/boot/dts/apm/apm-merlin.dts
new file mode 100644
index 0000000..152c513
--- /dev/null
+++ b/arch/arm64/boot/dts/apm/apm-merlin.dts
@@ -0,0 +1,39 @@
+/*
+ * dts file for AppliedMicro (APM) Merlin Board
+ *
+ * Copyright (C) 2015, Applied Micro Circuits Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+/dts-v1/;
+
+/include/ "apm-shadowcat.dtsi"
+
+/ {
+	model = "APM X-Gene Merlin board";
+	compatible = "apm,merlin", "apm,xgene-shadowcat";
+
+	chosen { };
+
+	memory {
+		device_type = "memory";
+		reg = < 0x1 0x00000000 0x0 0x80000000 >;
+	};
+};
+
+&serial0 {
+	status = "ok";
+};
+&sata1 {
+	status = "ok";
+};
+&sata2 {
+	status = "ok";
+};
+&sata3 {
+	status = "ok";
+};
diff --git a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
new file mode 100644
index 0000000..14b6cce
--- /dev/null
+++ b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
@@ -0,0 +1,154 @@
+/*
+ * dts file for AppliedMicro (APM) X-Gene Shadowcat SOC
+ *
+ * Copyright (C) 2015, Applied Micro Circuits Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+/ {
+	compatible = "apm,xgene-shadowcat";
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
+			compatible = "apm,strega", "arm,armv8";
+			reg = <0x0 0x000>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x1 0x0000fff8>;
+		};
+		cpu at 001 {
+			device_type = "cpu";
+			compatible = "apm,strega", "arm,armv8";
+			reg = <0x0 0x001>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x1 0x0000fff8>;
+		};
+		cpu at 100 {
+			device_type = "cpu";
+			compatible = "apm,strega", "arm,armv8";
+			reg = <0x0 0x100>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x1 0x0000fff8>;
+		};
+		cpu at 101 {
+			device_type = "cpu";
+			compatible = "apm,strega", "arm,armv8";
+			reg = <0x0 0x101>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x1 0x0000fff8>;
+		};
+		cpu at 200 {
+			device_type = "cpu";
+			compatible = "apm,strega", "arm,armv8";
+			reg = <0x0 0x200>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x1 0x0000fff8>;
+		};
+		cpu at 201 {
+			device_type = "cpu";
+			compatible = "apm,strega", "arm,armv8";
+			reg = <0x0 0x201>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x1 0x0000fff8>;
+		};
+		cpu at 300 {
+			device_type = "cpu";
+			compatible = "apm,strega", "arm,armv8";
+			reg = <0x0 0x300>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x1 0x0000fff8>;
+		};
+		cpu at 301 {
+			device_type = "cpu";
+			compatible = "apm,strega", "arm,armv8";
+			reg = <0x0 0x301>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x1 0x0000fff8>;
+		};
+	};
+
+	gic: interrupt-controller at 78090000 {
+		compatible = "arm,cortex-a15-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		interrupt-controller;
+		interrupts = <1 9 0xf04>;	/* GIC Maintenence IRQ */
+		ranges = <0 0 0 0x79000000 0x0 0x800000>; /* MSI Range */
+		reg = <0x0 0x78090000 0x0 0x10000>,	/* GIC Dist */
+		      <0x0 0x780A0000 0x0 0x20000>,	/* GIC CPU */
+		      <0x0 0x780C0000 0x0 0x10000>,	/* GIC VCPU Control */
+		      <0x0 0x780E0000 0x0 0x20000>;	/* GIC VCPU */
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <1 12 0xff04>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <1 0 0xff04>,	/* Secure Phys IRQ */
+			     <1 13 0xff04>,	/* Non-secure Phys IRQ */
+			     <1 14 0xff04>,	/* Virt IRQ */
+			     <1 15 0xff04>;	/* Hyp IRQ */
+		clock-frequency = <50000000>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		serial0: serial at 10600000 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0 0x10600000 0x0 0x1000>;
+			reg-shift = <2>;
+			clock-frequency = <10000000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0x0 0x4c 0x4>;
+		};
+
+		sata1: sata at 1a000000 {
+			compatible = "apm,xgene-ahci";
+			reg = <0x0 0x1a000000 0x0 0x1000>,
+			      <0x0 0x1f200000 0x0 0x1000>,
+			      <0x0 0x1f20d000 0x0 0x1000>,
+			      <0x0 0x1f20e000 0x0 0x1000>;
+			interrupts = <0x0 0x5a 0x4>;
+			dma-coherent;
+		};
+
+		sata2: sata at 1a200000 {
+			compatible = "apm,xgene-ahci";
+			reg = <0x0 0x1a200000 0x0 0x1000>,
+			      <0x0 0x1f210000 0x0 0x1000>,
+			      <0x0 0x1f21d000 0x0 0x1000>,
+			      <0x0 0x1f21e000 0x0 0x1000>;
+			interrupts = <0x0 0x5b 0x4>;
+			dma-coherent;
+		};
+
+		sata3: sata at 1a400000 {
+			compatible = "apm,xgene-ahci";
+			reg = <0x0 0x1a400000 0x0 0x1000>,
+			      <0x0 0x1f220000 0x0 0x1000>,
+			      <0x0 0x1f22d000 0x0 0x1000>,
+			      <0x0 0x1f22e000 0x0 0x1000>;
+			interrupts = <0x0 0x5c 0x4>;
+			dma-coherent;
+		};
+	};
+};
-- 
1.9.1
