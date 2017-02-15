From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 15 Feb 2017 17:55:28 +0100
Subject: [PATCH 11/11] ARM64: dts: Prepare Actions Semi S900 and Bubblegum-96
In-Reply-To: <20170215165528.10052-1-afaerber@suse.de>
References: <20170215165528.10052-1-afaerber@suse.de>
Message-ID: <20170215165528.10052-12-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/boot/dts/Makefile                     |   1 +
 arch/arm64/boot/dts/actions/Makefile             |   5 +
 arch/arm64/boot/dts/actions/s900-bubblegum96.dts |  62 ++++++++++
 arch/arm64/boot/dts/actions/s900.dtsi            | 140 +++++++++++++++++++++++
 4 files changed, 208 insertions(+)
 create mode 100644 arch/arm64/boot/dts/actions/Makefile
 create mode 100644 arch/arm64/boot/dts/actions/s900-bubblegum96.dts
 create mode 100644 arch/arm64/boot/dts/actions/s900.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 080232b..d1a6b0a 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -1,3 +1,4 @@
+dts-dirs += actions
 dts-dirs += al
 dts-dirs += allwinner
 dts-dirs += altera
diff --git a/arch/arm64/boot/dts/actions/Makefile b/arch/arm64/boot/dts/actions/Makefile
new file mode 100644
index 0000000..bc1e6d6
--- /dev/null
+++ b/arch/arm64/boot/dts/actions/Makefile
@@ -0,0 +1,5 @@
+dtb-$(CONFIG_ARCH_OWL) += s900-bubblegum96.dtb
+
+always		:= $(dtb-y)
+subdir-y	:= $(dts-dirs)
+clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/actions/s900-bubblegum96.dts b/arch/arm64/boot/dts/actions/s900-bubblegum96.dts
new file mode 100644
index 0000000..12843a9
--- /dev/null
+++ b/arch/arm64/boot/dts/actions/s900-bubblegum96.dts
@@ -0,0 +1,62 @@
+/*
+ * Copyright (c) 2017 Andreas F?rber
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This library is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This library is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+
+#include "s900.dtsi"
+
+/ {
+	compatible = "ucrobotics,bubblegum-96", "acts,s900";
+	model = "Bubblegum-96";
+
+	aliases {
+		serial5 = &uart5;
+	};
+
+	chosen {
+		stdout-path = "serial5:115200n8";
+	};
+};
+
+&uart5 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
new file mode 100644
index 0000000..d98d61a
--- /dev/null
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -0,0 +1,140 @@
+/*
+ * Copyright (c) 2017 Andreas F?rber
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This library is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This library is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "acts,s900";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+		};
+
+		cpu2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x2>;
+			enable-method = "psci";
+		};
+
+		cpu3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x3>;
+			enable-method = "psci";
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	arm-pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+		             <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+		             <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+		             <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gic: interrupt-controller at e00f1000 {
+			compatible = "arm,gic-400";
+			reg = <0x0 0xe00f1000 0x0 0x1000>,
+			      <0x0 0xe00f2000 0x0 0x1000>,
+			      <0x0 0xe00f4000 0x0 0x2000>,
+			      <0x0 0xe00f6000 0x0 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+
+		uart5: serial at e012a000 {
+			compatible = "acts,s900-uart", "acts,owl-uart";
+			reg = <0x0 0xe012a000 0x0 0x1000>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.10.2
