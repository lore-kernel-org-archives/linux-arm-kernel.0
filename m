From: anders.berg@avagotech.com (Anders Berg)
Date: Fri, 23 May 2014 11:08:36 +0200
Subject: [PATCH v4 2/5] ARM: dts: Device tree for AXM55xx.
In-Reply-To: <cover.1400834521.git.anders.berg@avagotech.com>
References: <cover.1400834521.git.anders.berg@avagotech.com>
Message-ID: <5299e66103868a1e253e91c2e995507bfb399804.1400834521.git.anders.berg@avagotech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anders Berg <anders.berg@lsi.com>

Add device tree for the Amarillo validation board with an AXM5516 SoC.

Signed-off-by: Anders Berg <anders.berg@lsi.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/Makefile             |   1 +
 arch/arm/boot/dts/axm5516-amarillo.dts |  51 +++++++++
 arch/arm/boot/dts/axm5516-cpus.dtsi    | 204 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/axm55xx.dtsi         | 199 ++++++++++++++++++++++++++++++++
 4 files changed, 455 insertions(+)
 create mode 100644 arch/arm/boot/dts/axm5516-amarillo.dts
 create mode 100644 arch/arm/boot/dts/axm5516-cpus.dtsi
 create mode 100644 arch/arm/boot/dts/axm55xx.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ba4c394..3899d59 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -50,6 +50,7 @@ dtb-$(CONFIG_ARCH_AT91)	+= sama5d35ek.dtb
 dtb-$(CONFIG_ARCH_AT91)	+= sama5d36ek.dtb
 
 dtb-$(CONFIG_ARCH_ATLAS6) += atlas6-evb.dtb
+dtb-$(CONFIG_ARCH_AXXIA) += axm5516-amarillo.dtb
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
 dtb-$(CONFIG_ARCH_BCM_5301X) += bcm4708-netgear-r6250.dtb
 dtb-$(CONFIG_ARCH_BCM_MOBILE) += bcm28155-ap.dtb \
diff --git a/arch/arm/boot/dts/axm5516-amarillo.dts b/arch/arm/boot/dts/axm5516-amarillo.dts
new file mode 100644
index 0000000..a9d6047
--- /dev/null
+++ b/arch/arm/boot/dts/axm5516-amarillo.dts
@@ -0,0 +1,51 @@
+/*
+ * arch/arm/boot/dts/axm5516-amarillo.dts
+ *
+ * Copyright (C) 2013 LSI
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+/dts-v1/;
+
+/memreserve/ 0x00000000 0x00400000;
+
+#include "axm55xx.dtsi"
+#include "axm5516-cpus.dtsi"
+
+/ {
+	model = "Amarillo AXM5516";
+	compatible = "lsi,axm5516-amarillo", "lsi,axm5516";
+
+	memory {
+		device_type = "memory";
+		reg = <0 0x00000000 0x02 0x00000000>;
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
+
+&serial1 {
+	status = "okay";
+};
+
+&serial2 {
+	status = "okay";
+};
+
+&serial3 {
+	status = "okay";
+};
+
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/axm5516-cpus.dtsi b/arch/arm/boot/dts/axm5516-cpus.dtsi
new file mode 100644
index 0000000..b85f360
--- /dev/null
+++ b/arch/arm/boot/dts/axm5516-cpus.dtsi
@@ -0,0 +1,204 @@
+/*
+ * arch/arm/boot/dts/axm5516-cpus.dtsi
+ *
+ * Copyright (C) 2013 LSI
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&CPU0>;
+				};
+				core1 {
+					cpu = <&CPU1>;
+				};
+				core2 {
+					cpu = <&CPU2>;
+				};
+				core3 {
+					cpu = <&CPU3>;
+				};
+			};
+			cluster1 {
+				core0 {
+					cpu = <&CPU4>;
+				};
+				core1 {
+					cpu = <&CPU5>;
+				};
+				core2 {
+					cpu = <&CPU6>;
+				};
+				core3 {
+					cpu = <&CPU7>;
+				};
+			};
+			cluster2 {
+				core0 {
+					cpu = <&CPU8>;
+				};
+				core1 {
+					cpu = <&CPU9>;
+				};
+				core2 {
+					cpu = <&CPU10>;
+				};
+				core3 {
+					cpu = <&CPU11>;
+				};
+			};
+			cluster3 {
+				core0 {
+					cpu = <&CPU12>;
+				};
+				core1 {
+					cpu = <&CPU13>;
+				};
+				core2 {
+					cpu = <&CPU14>;
+				};
+				core3 {
+					cpu = <&CPU15>;
+				};
+			};
+		};
+
+		CPU0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x00>;
+			clock-frequency= <1400000000>;
+			cpu-release-addr = <0>; // Fixed by the boot loader
+		};
+
+		CPU1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x01>;
+			clock-frequency= <1400000000>;
+			cpu-release-addr = <0>; // Fixed by the boot loader
+		};
+
+		CPU2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x02>;
+			clock-frequency= <1400000000>;
+			cpu-release-addr = <0>; // Fixed by the boot loader
+		};
+
+		CPU3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x03>;
+			clock-frequency= <1400000000>;
+			cpu-release-addr = <0>; // Fixed by the boot loader
+		};
+
+		CPU4: cpu at 100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x100>;
+			clock-frequency= <1400000000>;
+			cpu-release-addr = <0>; // Fixed by the boot loader
+		};
+
+		CPU5: cpu at 101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x101>;
+			clock-frequency= <1400000000>;
+			cpu-release-addr = <0>; // Fixed by the boot loader
+		};
+
+		CPU6: cpu at 102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x102>;
+			clock-frequency= <1400000000>;
+			cpu-release-addr = <0>; // Fixed by the boot loader
+		};
+
+		CPU7: cpu at 103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x103>;
+			clock-frequency= <1400000000>;
+			cpu-release-addr = <0>; // Fixed by the boot loader
+		};
+
+		CPU8: cpu at 200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x200>;
+			clock-frequency= <1400000000>;
+			cpu-release-addr = <0>; // Fixed by the boot loader
+		};
+
+		CPU9: cpu at 201 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x201>;
+			clock-frequency= <1400000000>;
+			cpu-release-addr = <0>; // Fixed by the boot loader
+		};
+
+		CPU10: cpu at 202 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x202>;
+			clock-frequency= <1400000000>;
+			cpu-release-addr = <0>; // Fixed by the boot loader
+		};
+
+		CPU11: cpu at 203 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x203>;
+			clock-frequency= <1400000000>;
+			cpu-release-addr = <0>; // Fixed by the boot loader
+		};
+
+		CPU12: cpu at 300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x300>;
+			clock-frequency= <1400000000>;
+			cpu-release-addr = <0>; // Fixed by the boot loader
+		};
+
+		CPU13: cpu at 301 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x301>;
+			clock-frequency= <1400000000>;
+			cpu-release-addr = <0>; // Fixed by the boot loader
+		};
+
+		CPU14: cpu at 302 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x302>;
+			clock-frequency= <1400000000>;
+			cpu-release-addr = <0>; // Fixed by the boot loader
+		};
+
+		CPU15: cpu at 303 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x303>;
+			clock-frequency= <1400000000>;
+			cpu-release-addr = <0>; // Fixed by the boot loader
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/axm55xx.dtsi b/arch/arm/boot/dts/axm55xx.dtsi
new file mode 100644
index 0000000..3fbd83c
--- /dev/null
+++ b/arch/arm/boot/dts/axm55xx.dtsi
@@ -0,0 +1,199 @@
+/*
+ * arch/arm/boot/dts/axm55xx.dtsi
+ *
+ * Copyright (C) 2013 LSI
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/lsi,axm5516-clks.h>
+
+#include "skeleton64.dtsi"
+
+/ {
+	interrupt-parent = <&gic>;
+
+	aliases {
+		serial0	  = &serial0;
+		serial1   = &serial1;
+		serial2	  = &serial2;
+		serial3	  = &serial3;
+		timer	  = &timer0;
+	};
+
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		clk_ref0: clk_ref0 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <125000000>;
+		};
+
+		clk_ref1: clk_ref1 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <125000000>;
+		};
+
+		clk_ref2: clk_ref2 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <125000000>;
+		};
+
+		clks: clock-controller at 2010020000 {
+			compatible = "lsi,axm5516-clks";
+			#clock-cells = <1>;
+			reg = <0x20 0x10020000 0 0x20000>;
+		};
+	};
+
+	gic: interrupt-controller at 2001001000 {
+		compatible = "arm,cortex-a15-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0x20 0x01001000 0 0x1000>,
+		      <0x20 0x01002000 0 0x1000>,
+		      <0x20 0x01004000 0 0x2000>,
+		      <0x20 0x01006000 0 0x2000>;
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
+				IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts =
+			<GIC_PPI 13
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 14
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 11
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 10
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+
+	pmu {
+		compatible = "arm,cortex-a15-pmu";
+		interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		device_type = "soc";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		interrupt-parent = <&gic>;
+		ranges;
+
+		syscon: syscon at 2010030000 {
+			compatible = "lsi,axxia-syscon", "syscon";
+			reg = <0x20 0x10030000 0 0x2000>;
+		};
+
+		amba {
+			compatible = "arm,amba-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			serial0: uart at 2010080000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x20 0x10080000 0 0x1000>;
+				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks AXXIA_CLK_PER>;
+				clock-names = "apb_pclk";
+				status = "disabled";
+			};
+
+			serial1: uart at 2010081000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x20 0x10081000 0 0x1000>;
+				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks AXXIA_CLK_PER>;
+				clock-names = "apb_pclk";
+				status = "disabled";
+			};
+
+			serial2: uart at 2010082000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x20 0x10082000 0 0x1000>;
+				interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks AXXIA_CLK_PER>;
+				clock-names = "apb_pclk";
+				status = "disabled";
+			};
+
+			serial3: uart at 2010083000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x20 0x10083000 0 0x1000>;
+				interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks AXXIA_CLK_PER>;
+				clock-names = "apb_pclk";
+				status = "disabled";
+			};
+
+			timer0: timer at 2010091000 {
+				compatible = "arm,sp804", "arm,primecell";
+				reg = <0x20 0x10091000 0 0x1000>;
+				interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks AXXIA_CLK_PER>;
+				clock-names = "apb_pclk";
+				status = "okay";
+			};
+
+			gpio0: gpio at 2010092000 {
+				#gpio-cells = <2>;
+				compatible = "arm,pl061", "arm,primecell";
+				gpio-controller;
+				reg = <0x20 0x10092000 0x00 0x1000>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks AXXIA_CLK_PER>;
+				clock-names = "apb_pclk";
+				status = "disabled";
+			};
+
+			gpio1: gpio at 2010093000 {
+				#gpio-cells = <2>;
+				compatible = "arm,pl061", "arm,primecell";
+				gpio-controller;
+				reg = <0x20 0x10093000 0x00 0x1000>;
+				interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks AXXIA_CLK_PER>;
+				clock-names = "apb_pclk";
+				status = "disabled";
+			};
+		};
+	};
+};
+
+/*
+  Local Variables:
+  mode: C
+  End:
+*/
-- 
1.8.3.2
