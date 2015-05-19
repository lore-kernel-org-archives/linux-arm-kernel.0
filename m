From: fkan@apm.com (Feng Kan)
Date: Mon, 18 May 2015 17:56:16 -0700
Subject: [PATCH V4] arm64: dts: add APM Merlin Board device tree
Message-ID: <1431996976-17482-1-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the support for APM Merlin board. The Merlin board
is based on the APM X-Gene Shadowcat SoC. This DTS enables PMU,
Ethernet, SATA and Serial.

Signed-off-by: Feng Kan <fkan@apm.com>
---
  V4 Change:
	- Add ethernet

  V3 Change:
        - Add PCIe
        - Add merline to makefile in dts/apm directory

  V2 Change:
        - Add dma-range definition

  V1 Change:
        - add memreserve for spintable.
        - remove clkfreq attribute
        - update spin location, although it is done by bootloader.
        - remove msi reg entry
        - add chosen for stdout path
 arch/arm64/boot/dts/apm/Makefile           |   1 +
 arch/arm64/boot/dts/apm/apm-merlin.dts     |  54 ++++++
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 267 +++++++++++++++++++++++++++++
 3 files changed, 322 insertions(+)
 create mode 100644 arch/arm64/boot/dts/apm/apm-merlin.dts
 create mode 100644 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi

diff --git a/arch/arm64/boot/dts/apm/Makefile b/arch/arm64/boot/dts/apm/Makefile
index a2afabb..c75f17a 100644
--- a/arch/arm64/boot/dts/apm/Makefile
+++ b/arch/arm64/boot/dts/apm/Makefile
@@ -1,4 +1,5 @@
 dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
+dtb-$(CONFIG_ARCH_XGENE) += apm-merlin.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/apm/apm-merlin.dts b/arch/arm64/boot/dts/apm/apm-merlin.dts
new file mode 100644
index 0000000..10dfa7a
--- /dev/null
+++ b/arch/arm64/boot/dts/apm/apm-merlin.dts
@@ -0,0 +1,54 @@
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
+
+&pcie0 {
+	status = "ok";
+};
+
+&sata1 {
+	status = "ok";
+};
+
+&sata2 {
+	status = "ok";
+};
+
+&sata3 {
+	status = "ok";
+};
+
+&sgenet0 {
+	status = "ok";
+};
+
+&xgenet1 {
+	status = "ok";
+};
diff --git a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
new file mode 100644
index 0000000..77e3b0e
--- /dev/null
+++ b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
@@ -0,0 +1,267 @@
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
+		clocks {
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			refclk: refclk {
+				compatible = "fixed-clock";
+				#clock-cells = <1>;
+				clock-frequency = <100000000>;
+				clock-output-names = "refclk";
+			};
+
+			socpll: socpll at 17000120 {
+				compatible = "apm,xgene-socpll-clock";
+				#clock-cells = <1>;
+				clocks = <&refclk 0>;
+				reg = <0x0 0x17000120 0x0 0x1000>;
+				clock-output-names = "socpll";
+			};
+
+			socplldiv2: socplldiv2  {
+				compatible = "fixed-factor-clock";
+				#clock-cells = <1>;
+				clocks = <&socpll 0>;
+				clock-mult = <1>;
+				clock-div = <2>;
+				clock-output-names = "socplldiv2";
+			};
+
+			pcie0clk: pcie0clk at 1f2bc000 {
+				compatible = "apm,xgene-device-clock";
+				#clock-cells = <1>;
+				clocks = <&socplldiv2 0>;
+				reg = <0x0 0x1f2bc000 0x0 0x1000>;
+				reg-names = "csr-reg";
+				clock-output-names = "pcie0clk";
+			};
+
+			xge0clk: xge0clk at 1f61c000 {
+				compatible = "apm,xgene-device-clock";
+				#clock-cells = <1>;
+				clocks = <&socplldiv2 0>;
+				reg = <0x0 0x1f61c000 0x0 0x1000>;
+				reg-names = "csr-reg";
+				enable-mask = <0x3>;
+				csr-mask = <0x3>;
+				clock-output-names = "xge0clk";
+			};
+
+			xge1clk: xge1clk at 1f62c000 {
+				compatible = "apm,xgene-device-clock";
+				#clock-cells = <1>;
+				clocks = <&socplldiv2 0>;
+				reg = <0x0 0x1f62c000 0x0 0x1000>;
+				reg-names = "csr-reg";
+				enable-mask = <0x3>;
+				csr-mask = <0x3>;
+				clock-output-names = "xge1clk";
+			};
+		};
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
+		pcie0: pcie at 1f2b0000 {
+			device_type = "pci";
+			compatible = "apm,xgene-pcie";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = < 0x00 0x1f2b0000 0x0 0x00010000   /* Controller registers */
+				0xc0 0x10000000 0x0 0x00040000>; /* PCI config space */
+			reg-names = "csr", "cfg";
+			ranges = <0x01000000 0x00 0x00000000 0xC0 0x00000000 0x00 0x00010000   /* io */
+				0x02000000 0x00 0x80000000 0xC0 0x80000000 0x00 0x80000000>; /* mem */
+			dma-ranges = <0x42000000 0x80 0x00000000 0x80 0x00000000 0x00 0x80000000
+				0x42000000 0x00 0x00000000 0x00 0x00000000 0x80 0x00000000>;
+
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+			interrupt-map = <0x0 0x0 0x0 0x1 &gic 0x0 0x0 0x0 0x10 0x1
+				0x0 0x0 0x0 0x2 &gic 0x0 0x0 0x0 0x11 0x1
+				0x0 0x0 0x0 0x3 &gic 0x0 0x0 0x0 0x12 0x1
+				0x0 0x0 0x0 0x4 &gic 0x0 0x0 0x0 0x13 0x1>;
+			clocks = <&pcie0clk 0>;
+			dma-coherent;
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
+
+		sgenet0: ethernet at 1f610000 {
+			compatible = "apm,xgene2-sgenet";
+			status = "disabled";
+			reg = <0x0 0x1f610000 0x0 0x10000>,
+			      <0x0 0x1f600000 0x0 0Xd100>,
+			      <0x0 0x20000000 0x0 0X20000>;
+			interrupts = <0 96 4>,
+				     <0 97 4>;
+			dma-coherent;
+			clocks = <&xge0clk 0>;
+			local-mac-address = [00 01 73 00 00 01];
+			phy-connection-type = "sgmii";
+		};
+
+		xgenet1: ethernet at 1f620000 {
+			compatible = "apm,xgene2-xgenet";
+			status = "disabled";
+			reg = <0x0 0x1f620000 0x0 0x10000>,
+			      <0x0 0x1f600000 0x0 0Xd100>,
+			      <0x0 0x20000000 0x0 0X220000>;
+			interrupts = <0 108 4>,
+				     <0 109 4>;
+			port-id = <1>;
+			dma-coherent;
+			clocks = <&xge1clk 0>;
+			local-mac-address = [00 01 73 00 00 02];
+			phy-connection-type = "xgmii";
+		};
+	};
+};
-- 
1.9.1
