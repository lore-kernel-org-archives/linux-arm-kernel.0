From: carlo@caione.org (Carlo Caione)
Date: Mon,  8 Jun 2015 10:52:24 +0200
Subject: [PATCH 3/4] ARM: meson: Add DTS for Odroid-C1 and Tronfy MXQ boards
In-Reply-To: <1433753545-7980-1-git-send-email-carlo@caione.org>
References: <1433753545-7980-1-git-send-email-carlo@caione.org>
Message-ID: <1433753545-7980-4-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 arch/arm/boot/dts/Makefile             |   3 +
 arch/arm/boot/dts/meson8b-mxq.dts      |  65 ++++++++++++++
 arch/arm/boot/dts/meson8b-odroidc1.dts |  65 ++++++++++++++
 arch/arm/boot/dts/meson8b.dtsi         | 151 +++++++++++++++++++++++++++++++++
 4 files changed, 284 insertions(+)
 create mode 100644 arch/arm/boot/dts/meson8b-mxq.dts
 create mode 100644 arch/arm/boot/dts/meson8b-odroidc1.dts
 create mode 100644 arch/arm/boot/dts/meson8b.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 992736b..10b3dc5 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -211,6 +211,9 @@ dtb-$(CONFIG_ARCH_MMP) += \
 	pxa168-aspenite.dtb \
 	pxa910-dkb.dtb \
 	mmp2-brownstone.dtb
+dtb-$(CONFIG_MACH_MESON8B) += \
+	meson8b-mxq.dtb \
+	meson8b-odroidc1.dtb
 dtb-$(CONFIG_ARCH_MOXART) += \
 	moxart-uc7112lx.dtb
 dtb-$(CONFIG_SOC_IMX1) += \
diff --git a/arch/arm/boot/dts/meson8b-mxq.dts b/arch/arm/boot/dts/meson8b-mxq.dts
new file mode 100644
index 0000000..4730b94
--- /dev/null
+++ b/arch/arm/boot/dts/meson8b-mxq.dts
@@ -0,0 +1,65 @@
+/*
+ * Copyright 2015 Endless Mobile, Inc.
+ * Author: Carlo Caione <carlo@endlessm.com>
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
+ *     You should have received a copy of the GNU General Public License
+ *     along with this program. If not, see <http://www.gnu.org/licenses/>.
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
+#include "meson8b.dtsi"
+
+/ {
+	model = "TRONFY MXQ S805";
+	compatible = "tronfy,mxq", "amlogic,meson8b";
+
+	aliases {
+		serial0 = &uart_AO;
+	};
+
+	memory {
+		reg = <0x40000000 0x40000000>;
+	};
+};
+
+&uart_AO {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
new file mode 100644
index 0000000..09a9533
--- /dev/null
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -0,0 +1,65 @@
+/*
+ * Copyright 2015 Endless Mobile, Inc.
+ * Author: Carlo Caione <carlo@endlessm.com>
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
+ *     You should have received a copy of the GNU General Public License
+ *     along with this program. If not, see <http://www.gnu.org/licenses/>.
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
+#include "meson8b.dtsi"
+
+/ {
+	model = "Hardkernel ODROID-C1";
+	compatible = "hardkernel,odroid-c1", "amlogic,meson8b";
+
+	aliases {
+		serial0 = &uart_AO;
+	};
+
+	memory {
+		reg = <0x40000000 0x40000000>;
+	};
+};
+
+&uart_AO {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
new file mode 100644
index 0000000..37fdf46
--- /dev/null
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -0,0 +1,151 @@
+/*
+ * Copyright 2015 Endless Mobile, Inc.
+ * Author: Carlo Caione <carlo@endlessm.com>
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
+ *     You should have received a copy of the GNU General Public License
+ *     along with this program. If not, see <http://www.gnu.org/licenses/>.
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
+#include <dt-bindings/clock/meson8b-clkc.h>
+#include "skeleton.dtsi"
+
+/ {
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a5";
+			next-level-cache = <&L2>;
+			reg = <0x200>;
+		};
+
+		cpu at 201 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a5";
+			next-level-cache = <&L2>;
+			reg = <0x201>;
+		};
+
+		cpu at 202 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a5";
+			next-level-cache = <&L2>;
+			reg = <0x202>;
+		};
+
+		cpu at 203 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a5";
+			next-level-cache = <&L2>;
+			reg = <0x203>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		L2: l2-cache-controller at c4200000 {
+			compatible = "arm,pl310-cache";
+			reg = <0xc4200000 0x1000>;
+			cache-unified;
+			cache-level = <2>;
+		};
+
+		gic: interrupt-controller at c4301000 {
+			compatible = "arm,cortex-a9-gic";
+			reg = <0xc4301000 0x1000>,
+			      <0xc4300100 0x0100>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+
+		timer at c1109940 {
+			compatible = "amlogic,meson6-timer";
+			reg = <0xc1109940 0x14>;
+			interrupts = <0 10 1>;
+		};
+
+		uart_AO: serial at c81004c0 {
+			compatible = "amlogic,meson-uart";
+			reg = <0xc81004c0 0x14>;
+			interrupts = <0 90 1>;
+			clocks = <&clkc CLKID_CLK81>;
+			status = "disabled";
+		};
+
+		uart_A: serial at c81084c0 {
+			compatible = "amlogic,meson-uart";
+			reg = <0xc81084c0 0x14>;
+			interrupts = <0 90 1>;
+			clocks = <&clkc CLKID_CLK81>;
+			status = "disabled";
+		};
+
+		uart_B: serial at c81084dc {
+			compatible = "amlogic,meson-uart";
+			reg = <0xc81084dc 0x14>;
+			interrupts = <0 90 1>;
+			clocks = <&clkc CLKID_CLK81>;
+			status = "disabled";
+		};
+
+		uart_C: serial at c8108700 {
+			compatible = "amlogic,meson-uart";
+			reg = <0xc8108700 0x14>;
+			interrupts = <0 90 1>;
+			clocks = <&clkc CLKID_CLK81>;
+			status = "disabled";
+		};
+
+		clkc: clock-controller at c1104000 {
+			#clock-cells = <1>;
+			compatible = "amlogic,meson8b-clkc";
+			reg = <0xc1108000 0x4>, <0xc1104000 0x460>;
+		};
+	};
+}; /* end of / */
-- 
1.9.1
