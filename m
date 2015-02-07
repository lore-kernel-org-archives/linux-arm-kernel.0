From: cbz@baozis.org (Chen Baozi)
Date: Sat,  7 Feb 2015 13:07:15 +0800
Subject: [PATCH 2/3] arm64, ft-1500a: Add initial dts for Phytium FT-1500A SoC
In-Reply-To: <1423285636-8623-1-git-send-email-cbz@baozis.org>
References: <1423285636-8623-1-git-send-email-cbz@baozis.org>
Message-ID: <1423285636-8623-3-git-send-email-cbz@baozis.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial device tree nodes for Phytium FT-1500A SoC with support of
16 cores, gicv3 interrupt controller, serial port, PCIe host and
on-chip GMAC ethernet controller.

Signed-off-by: Chen Baozi <chenbaozi@kylinos.com.cn>
---
 arch/arm64/boot/dts/Makefile                      |   1 +
 arch/arm64/boot/dts/phytium/Makefile              |   5 +
 arch/arm64/boot/dts/phytium/ft-1500a.dtsi         | 269 ++++++++++++++++++++++
 arch/arm64/boot/dts/phytium/ft1500a-v2-dsk-v2.dts |  39 ++++
 4 files changed, 314 insertions(+)
 create mode 100644 arch/arm64/boot/dts/phytium/Makefile
 create mode 100644 arch/arm64/boot/dts/phytium/ft-1500a.dtsi
 create mode 100644 arch/arm64/boot/dts/phytium/ft1500a-v2-dsk-v2.dts

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index c62b0f4..e7e9e3d 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -2,5 +2,6 @@ dts-dirs += amd
 dts-dirs += apm
 dts-dirs += arm
 dts-dirs += cavium
+dts-dirs += phytium
 
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/phytium/Makefile b/arch/arm64/boot/dts/phytium/Makefile
new file mode 100644
index 0000000..12a22c6
--- /dev/null
+++ b/arch/arm64/boot/dts/phytium/Makefile
@@ -0,0 +1,5 @@
+dtb-$(CONFIG_ARCH_PHYTIUM) += ft1500a-v2-dsk-v2.dtb
+
+always		:= $(dtb-y)
+subdir-y	:= $(dts-dirs)
+clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/phytium/ft-1500a.dtsi b/arch/arm64/boot/dts/phytium/ft-1500a.dtsi
new file mode 100644
index 0000000..9005389
--- /dev/null
+++ b/arch/arm64/boot/dts/phytium/ft-1500a.dtsi
@@ -0,0 +1,269 @@
+/*
+ * DTS file for Phytium FT-1500A SoC
+ *
+ * Copyright (C) 2015, Phytium Technology Co., Ltd.
+ *
+ * This file is licensed under a dual GPLv2 or BSD license.
+ */
+
+/memreserve/    0x80000000 0x100000;
+/ {
+	compatible = "phytium,ft-1500a";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x000>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8007fff0>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x001>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8007fff0>;
+		};
+
+		cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x002>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8007fff0>;
+		};
+
+		cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x003>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8007fff0>;
+		};
+
+		cpu at 4 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x100>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8007fff0>;
+		};
+
+		cpu at 5 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x101>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8007fff0>;
+		};
+
+		cpu at 6 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x102>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8007fff0>;
+		};
+
+		cpu at 7 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x103>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8007fff0>;
+		};
+
+		cpu at 8 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x200>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8007fff0>;
+		};
+
+		cpu at 9 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x201>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8007fff0>;
+		};
+
+		cpu at 10 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x202>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8007fff0>;
+		};
+
+		cpu at 11 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x203>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8007fff0>;
+		};
+
+		cpu at 12 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x300>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8007fff0>;
+		};
+
+		cpu at 13 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x301>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8007fff0>;
+		};
+
+		cpu at 14 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x302>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8007fff0>;
+		};
+
+		cpu at 15 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x303>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8007fff0>;
+		};
+	};
+
+	gic: interrupt-controller at 29800000 {
+		compatible = "arm,gic-v3";
+		#interrupt-cells = <3>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		interrupt-controller;
+		reg = <0x0 0x29800000 0 0x10000>,	/* GICD */
+		      <0x0 0x29a00000 0 0x200000>,	/* GICR */
+		      <0x0 0x29c00000 0 0x10000>,	/* GICC */
+		      <0x0 0x29c10000 0 0x10000>,	/* GICH */
+		      <0x0 0x29c20000 0 0x10000>;	/* GICV */
+		interrupts = <1 9 4>;
+
+		its: gic-its at 29820000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			reg = <0x0 0x29820000 0x0 0x20000>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <1 13 8>,
+			     <1 14 8>,
+			     <1 11 8>,
+			     <1 10 8>;
+		clock-frequency = <50000000>;
+	};
+
+	soc {
+		compatible = "arm,amba-bus", "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gmac_clk: clk_csr {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <250000000>;
+		};
+
+		uart0: serial at 28000000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x28000000 0x0 0x1000>;
+			clock-frequency = <50000000>;
+			interrupts = <0 34 4>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disable";
+		};
+
+		uart1: serial at 28001000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x28001000 0x0 0x1000>;
+			clock-frequency = <50000000>;
+			interrupts = <0 35 4>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disable";
+		};
+
+		gmac0: ethernet at 28c00000 {
+			compatible = "snps,dwmac";
+			reg = <0 0x28c00000 0x0 0x2000>;
+			interrupts = <0 44 4>;
+			interrupt-names = "macirq";
+			clocks = <&gmac_clk>;
+			clock-names = "stmmaceth";
+			snps,pbl = <16>;
+			snps,abl = <32>;
+			snps,fixed-burst;
+			snps,force_sf_dma_mode;
+			snps,multicast-filter-bins = <64>;
+			snps,perfect-filter-entries = <1>;
+			max-frame-size = <9000>;
+			status = "disable";
+		};
+
+		gmac1: ethernet at 28c02000 {
+			compatible = "snps,dwmac";
+			reg = <0 0x28c02000 0x0 0x2000>;
+			interrupts = <0 45 4>;
+			interrupt-names = "macirq";
+			clocks = <&gmac_clk>;
+			clock-names = "stmmaceth";
+			snps,pbl = <16>;
+			snps,abl = <32>;
+			snps,fixed-burst;
+			snps,force_sf_dma_mode;
+			snps,multicast-filter-bins = <64>;
+			snps,perfect-filter-entries = <1>;
+			max-frame-size = <9000>;
+			status = "disable";
+		};
+
+		pcie0: pcie-controller {
+			compatible = "pci-host-ecam-generic";
+			device_type = "pci";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			reg = <0 0x40000000 0 0x10000000>;
+			dma-coherent;
+			msi-parent = <&its>;
+			interrupt-map-mask = <0x0000 0x0 0x0 0x7>;
+			interrupt-map = <0x0 0x0 0x0 0x1 &gic 0x0 0x0 0x0 0x33 0x4>,
+					<0x0 0x0 0x0 0x2 &gic 0x0 0x0 0x0 0x34 0x4>,
+					<0x0 0x0 0x0 0x3 &gic 0x0 0x0 0x0 0x35 0x4>,
+					<0x0 0x0 0x0 0x4 &gic 0x0 0x0 0x0 0x36 0x4>;
+			ranges = <0x01000000 0x00 0x00000000 0x00 0x50000000 0x00 0x1000000>,
+				 <0x02000000 0x00 0x60000000 0x00 0x60000000 0x00 0x20000000>,
+				 <0x03000000 0x01 0x00000000 0x01 0x00000000 0x01 0x00000000>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/phytium/ft1500a-v2-dsk-v2.dts b/arch/arm64/boot/dts/phytium/ft1500a-v2-dsk-v2.dts
new file mode 100644
index 0000000..7717112
--- /dev/null
+++ b/arch/arm64/boot/dts/phytium/ft1500a-v2-dsk-v2.dts
@@ -0,0 +1,39 @@
+/*
+ * DTS file for Phytium FT1500A-V2-DSK-V2 board
+ *
+ * Copyright (C) 2015, Phytium Technology Co., Ltd.
+ *
+ * This file is licensed under a dual GPLv2 or BSD license.
+ */
+
+/dts-v1/;
+
+/include/ "ft-1500a.dtsi"
+
+/ {
+	model = "Phytium ft1500a-v2-dsk-v2 board";
+	compatible = "phytium,ft-1500a";
+
+	chosen {
+		linux,pci-probe-only;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x80000000>;	/* Updated by bootloader */
+	};
+};
+
+&uart1 {
+	status = "ok";
+};
+
+&gmac0 {
+	phy-mode = "gmii";
+	status = "ok";
+};
+
+&gmac1 {
+	phy-mode = "gmii";
+	status = "ok";
+};
-- 
2.1.4
