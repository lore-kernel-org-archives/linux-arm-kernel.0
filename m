From: dingtianhong@huawei.com (Ding Tianhong)
Date: Sun, 6 Sep 2015 17:34:35 +0800
Subject: [PATCH v3 2/2] arm64: dts: add dts files for Hisilicon Hip05-D02
 Development Board
In-Reply-To: <1441532075-9452-1-git-send-email-dingtianhong@huawei.com>
References: <1441532075-9452-1-git-send-email-dingtianhong@huawei.com>
Message-ID: <1441532075-9452-3-git-send-email-dingtianhong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial dtsi file to support Hisilicon Hip05-D02 Board with
support of CPUs in four clusters and each cluster has quard Cortex-A57.

Also add dts file to support Hip05-D02 development board.

Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/Makefile      |   2 +-
 arch/arm64/boot/dts/hisilicon/hip05-d02.dts |  36 ++++
 arch/arm64/boot/dts/hisilicon/hip05.dtsi    | 271 ++++++++++++++++++++++++++++
 3 files changed, 308 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hip05-d02.dts
 create mode 100644 arch/arm64/boot/dts/hisilicon/hip05.dtsi

diff --git a/arch/arm64/boot/dts/hisilicon/Makefile b/arch/arm64/boot/dts/hisilicon/Makefile
index fa81a6e..cd158b8 100644
--- a/arch/arm64/boot/dts/hisilicon/Makefile
+++ b/arch/arm64/boot/dts/hisilicon/Makefile
@@ -1,4 +1,4 @@
-dtb-$(CONFIG_ARCH_HISI) += hi6220-hikey.dtb
+dtb-$(CONFIG_ARCH_HISI) += hi6220-hikey.dtb hip05-d02.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/hisilicon/hip05-d02.dts b/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
new file mode 100644
index 0000000..ae34e25
--- /dev/null
+++ b/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
@@ -0,0 +1,36 @@
+/**
+ * dts file for Hisilicon D02 Development Board
+ *
+ * Copyright (C) 2014,2015 Hisilicon Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * publishhed by the Free Software Foundation.
+ *
+ */
+
+/dts-v1/;
+
+#include "hip05.dtsi"
+
+/ {
+	model = "Hisilicon Hip05 D02 Development Board";
+	compatible = "hisilicon,hip05-d02";
+
+	memory at 00000000 {
+		device_type = "memory";
+		reg = <0x0 0x00000000 0x0 0x80000000>;
+	};
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	status = "ok";
+};
diff --git a/arch/arm64/boot/dts/hisilicon/hip05.dtsi b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
new file mode 100644
index 0000000..4ff16d0
--- /dev/null
+++ b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
@@ -0,0 +1,271 @@
+/**
+ * dts file for Hisilicon D02 Development Board
+ *
+ * Copyright (C) 2014,2015 Hisilicon Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * publishhed by the Free Software Foundation.
+ *
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "hisilicon,hip05-d02";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+				core1 {
+					cpu = <&cpu1>;
+				};
+				core2 {
+					cpu = <&cpu2>;
+				};
+				core3 {
+					cpu = <&cpu3>;
+				};
+			};
+			cluster1 {
+				core0 {
+					cpu = <&cpu4>;
+				};
+				core1 {
+					cpu = <&cpu5>;
+				};
+				core2 {
+					cpu = <&cpu6>;
+				};
+				core3 {
+					cpu = <&cpu7>;
+				};
+			};
+			cluster2 {
+				core0 {
+					cpu = <&cpu8>;
+				};
+				core1 {
+					cpu = <&cpu9>;
+				};
+				core2 {
+					cpu = <&cpu10>;
+				};
+				core3 {
+					cpu = <&cpu11>;
+				};
+			};
+			cluster3 {
+				core0 {
+					cpu = <&cpu12>;
+				};
+				core1 {
+					cpu = <&cpu13>;
+				};
+				core2 {
+					cpu = <&cpu14>;
+				};
+				core3 {
+					cpu = <&cpu15>;
+				};
+			};
+		};
+
+		cpu0: cpu at 20000 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x20000>;
+			enable-method = "psci";
+		};
+
+		cpu1: cpu at 20001 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x20001>;
+			enable-method = "psci";
+		};
+
+		cpu2: cpu at 20002 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x20002>;
+			enable-method = "psci";
+		};
+
+		cpu3: cpu at 20003 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x20003>;
+			enable-method = "psci";
+		};
+
+		cpu4: cpu at 20100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x20100>;
+			enable-method = "psci";
+		};
+
+		cpu5: cpu at 20101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x20101>;
+			enable-method = "psci";
+		};
+
+		cpu6: cpu at 20102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x20102>;
+			enable-method = "psci";
+		};
+
+		cpu7: cpu at 20103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x20103>;
+			enable-method = "psci";
+		};
+
+		cpu8: cpu at 20200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x20200>;
+			enable-method = "psci";
+		};
+
+		cpu9: cpu at 20201 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x20201>;
+			enable-method = "psci";
+		};
+
+		cpu10: cpu at 20202 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x20202>;
+			enable-method = "psci";
+		};
+
+		cpu11: cpu at 20203 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x20203>;
+			enable-method = "psci";
+		};
+
+		cpu12: cpu at 20300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x20300>;
+			enable-method = "psci";
+		};
+
+		cpu13: cpu at 20301 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x20301>;
+			enable-method = "psci";
+		};
+
+		cpu14: cpu at 20302 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x20302>;
+			enable-method = "psci";
+		};
+
+		cpu15: cpu at 20303 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x20303>;
+			enable-method = "psci";
+		};
+	};
+
+	gic: interrupt-controller at 8d000000 {
+		compatible = "arm,gic-v3";
+                #interrupt-cells = <3>;
+                #address-cells = <2>;
+                #size-cells = <2>;
+                ranges;
+                interrupt-controller;
+                #redistributor-regions = <1>;
+                redistributor-stride = <0x0 0x30000>;
+		reg = <0x0 0x8d000000 0 0x10000>,	/* GICD */
+		      <0x0 0x8d100000 0 0x300000>,	/* GICR */
+		      <0x0 0xfe000000 0 0x10000>,	/* GICC */
+		      <0x0 0xfe010000 0 0x10000>,       /* GICH */
+		      <0x0 0xfe020000 0 0x10000>;       /* GICV */
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
+		its_totems: interrupt-controller at 8c000000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			reg = <0x0 0x8c000000 0x0 0x40000>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		refclk200mhz: refclk200mhz {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <200000000>;
+		};
+
+		uart0: uart at 80300000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x80300000 0x0 0x10000>;
+			interrupts = <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&refclk200mhz>;
+			clock-names = "apb_pclk";
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart1: uart at 80310000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x80310000 0x0 0x10000>;
+			interrupts = <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&refclk200mhz>;
+			clock-names = "apb_pclk";
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+	};
+};
-- 
1.9.0
