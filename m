From: mohun106@gmail.com (mohun106 at gmail.com)
Date: Mon, 24 Mar 2014 14:39:38 +0530
Subject: [PATCH v2 2/3] arm64: dts: Add initial dts for Cavium Thunder SoC
In-Reply-To: <1395652179-9216-1-git-send-email-mohun106@gmail.com>
References: <1395652179-9216-1-git-send-email-mohun106@gmail.com>
Message-ID: <1395652179-9216-3-git-send-email-mohun106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>

Signed-off-by: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
---
 arch/arm64/boot/dts/Makefile    |    1 +
 arch/arm64/boot/dts/thunder.dts |  160 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 161 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index c52bdb0..9cc8740 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -1,3 +1,4 @@
+dtb-$(CONFIG_ARCH_THUNDER) += thunder.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb foundation-v8.dtb
 dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
 
diff --git a/arch/arm64/boot/dts/thunder.dts b/arch/arm64/boot/dts/thunder.dts
new file mode 100644
index 0000000..190e01a
--- /dev/null
+++ b/arch/arm64/boot/dts/thunder.dts
@@ -0,0 +1,160 @@
+/*
+ * Cavium Thunder DTS file
+ *
+ * Copyright (C) 2013, Cavium Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+/dts-v1/;
+
+/memreserve/ 0x80000000 0x00010000;
+
+/ {
+	model = "Cavium Thunder";
+	compatible = "cavium,thunder";
+	interrupt-parent = <&gic0>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &uaa0;
+		serial1 = &uaa1;
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x0>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0xfff8>;
+		};
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x1>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0xfff8>;
+		};
+		cpu at 2 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x2>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0xfff8>;
+		};
+		cpu at 3 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x3>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0xfff8>;
+		};
+		cpu at 4 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x4>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0xfff8>;
+		};
+		cpu at 5 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x5>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0xfff8>;
+		};
+		cpu at 6 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x6>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0xfff8>;
+		};
+		cpu at 7 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x7>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0xfff8>;
+		};
+
+	};
+
+	memory at 0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+
+	gic0: interrupt-controller at 801000000000 {
+		compatible = "arm,gic-v3";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0x8010 0x0 0x0 0x10000>,         /* GICD */
+		      <0x8010 0x80000000 0x0 0x100000>; /* GICR */
+		interrupts = <1 9 0xf04>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <1 13 0xff01>,
+		             <1 14 0xff01>,
+		             <1 11 0xff01>,
+		             <1 10 0xff01>;
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
+			refclk50mhz: refclk50mhz {
+				compatible = "fixed-clock";
+				#clock-cells = <0>;
+				clock-frequency = <50000000>;
+				clock-output-names = "refclk50mhz";
+			};
+		};
+
+		ahci0: host-bus-adapter at 810000000000 {
+			compatible = "snps,spear-ahci";
+			reg = <0x8100 0x0 0x0 0x1100>;
+			interrupts = <1 32 4>;
+		};
+
+		nic0: ethernet at 843000000000 {
+			compatible = "smsc,lan9115";
+			reg-io-width = <4>;
+			reg = <0x8430 0x0 0x0 0x1000>;
+			interrupts = <1 31 4>;
+		};
+
+		uaa0: uart at 87e024000000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x87e0 0x24000000 0x0 0x1000>;
+			interrupts = <1 21 4>;
+			clocks = <&refclk50mhz>;
+			clock-names = "apb_pclk";
+		};
+
+		uaa1: uart at 87e025000000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x87e0 0x25000000 0x0 0x1000>;
+			interrupts = <1 22 4>;
+			clocks = <&refclk50mhz>;
+			clock-names = "apb_pclk";
+		};
+	};
+};
-- 
1.7.1
