From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 15 Feb 2017 17:55:25 +0100
Subject: [PATCH 08/11] ARM: dts: Prepare Actions Semi S500 and LeMaker Guitar
In-Reply-To: <20170215165528.10052-1-afaerber@suse.de>
References: <20170215165528.10052-1-afaerber@suse.de>
Message-ID: <20170215165528.10052-9-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/Makefile                 |   2 +
 arch/arm/boot/dts/s500-guitar-bb-rev-b.dts |  63 ++++++++++++++++
 arch/arm/boot/dts/s500-guitar.dtsi         |  49 ++++++++++++
 arch/arm/boot/dts/s500.dtsi                | 116 +++++++++++++++++++++++++++++
 4 files changed, 230 insertions(+)
 create mode 100644 arch/arm/boot/dts/s500-guitar-bb-rev-b.dts
 create mode 100644 arch/arm/boot/dts/s500-guitar.dtsi
 create mode 100644 arch/arm/boot/dts/s500.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0118084..15a195f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -638,6 +638,8 @@ dtb-$(CONFIG_ARCH_ORION5X) += \
 	orion5x-maxtor-shared-storage-2.dtb \
 	orion5x-netgear-wnr854t.dtb \
 	orion5x-rd88f5182-nas.dtb
+dtb-$(CONFIG_ARCH_OWL) += \
+	s500-guitar-bb-rev-b.dtb
 dtb-$(CONFIG_ARCH_PRIMA2) += \
 	prima2-evb.dtb
 dtb-$(CONFIG_ARCH_OXNAS) += \
diff --git a/arch/arm/boot/dts/s500-guitar-bb-rev-b.dts b/arch/arm/boot/dts/s500-guitar-bb-rev-b.dts
new file mode 100644
index 0000000..3d70cb8
--- /dev/null
+++ b/arch/arm/boot/dts/s500-guitar-bb-rev-b.dts
@@ -0,0 +1,63 @@
+/*
+ * Copyright (c) 2016-2017 Andreas F?rber
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
+#include "s500-guitar.dtsi"
+
+/ {
+	compatible = "lemaker,guitar-bb-rev-b", "lemaker,guitar", "acts,s500";
+	model = "LeMaker Guitar Base Board rev. B";
+
+	aliases {
+		serial3 = &uart3;
+	};
+
+	chosen {
+		stdout-path = "serial3:115200n8";
+	};
+};
+
+&uart3 {
+	clock-frequency = <48000000>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/s500-guitar.dtsi b/arch/arm/boot/dts/s500-guitar.dtsi
new file mode 100644
index 0000000..44d1e40
--- /dev/null
+++ b/arch/arm/boot/dts/s500-guitar.dtsi
@@ -0,0 +1,49 @@
+/*
+ * LeMaker Guitar SoM
+ *
+ * Copyright (c) 2016-2017 Andreas F?rber
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
+#include "s500.dtsi"
+
+/ {
+	compatible = "lemaker,guitar", "acts,s500";
+};
diff --git a/arch/arm/boot/dts/s500.dtsi b/arch/arm/boot/dts/s500.dtsi
new file mode 100644
index 0000000..ee93984
--- /dev/null
+++ b/arch/arm/boot/dts/s500.dtsi
@@ -0,0 +1,116 @@
+/*
+ * Actions Semi S500 SoC
+ *
+ * Copyright (c) 2016-2017 Andreas F?rber
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
+#include "skeleton.dtsi"
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "acts,s500";
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			compatible = "arm,cortex-a9";
+			reg = <0x0>;
+		};
+
+		cpu1: cpu at 1 {
+			compatible = "arm,cortex-a9";
+			reg = <0x1>;
+		};
+
+		cpu2: cpu at 2 {
+			compatible = "arm,cortex-a9";
+			reg = <0x2>;
+		};
+
+		cpu3: cpu at 3 {
+			compatible = "arm,cortex-a9";
+			reg = <0x3>;
+		};
+	};
+
+	arm-pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+		             <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+		             <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+		             <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+        };
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		gic: interrupt-controller at b0021000 {
+			compatible = "arm,cortex-a9-gic";
+			reg = <0xb0021000 0x1000>,
+			      <0xb0020100 0x0100>;
+		};
+
+		l2: cache-controller at b0022000 {
+			compatible = "arm,pl310-cache";
+			reg = <0xb0022000 0x1000>;
+			cache-unified;
+			cache-level = <2>;
+			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+			arm,tag-latency = <3 3 2>;
+			arm,data-latency = <5 3 3>;
+		};
+
+		uart3: serial at b0126000 {
+			compatible = "acts,s500-uart", "acts,owl-uart";
+			reg = <0xb0126000 0x1000>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.10.2
