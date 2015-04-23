From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 23 Apr 2015 12:36:26 +0900
Subject: [PATCH v5 3/4] ARM: dts: UniPhier: add support for UniPhier SoCs and
 boards
In-Reply-To: <1429760187-17333-1-git-send-email-yamada.masahiro@socionext.com>
References: <1429760187-17333-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1429760187-17333-4-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initial device trees for UniPhier SoCs: PH1-sLD3, PH1-LD4, PH1-Pro4,
and PH1-sLD8.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v5: None
Changes in v4:
  - Add system-bus-controller-misc node instead of uniphier-smp-reg node

Changes in v3:
  - License under GPL/X11
  - Drop "earlyprintk" kernel-parameter, add "stdout-path" property
  - Add syscon device for SMP boot support in order not to
    hard-code register address in platsmp.c

Changes in v2: None

 arch/arm/boot/dts/Makefile                   |   5 ++
 arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts   |  79 ++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi      | 111 +++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts  |  79 ++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi     | 118 +++++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts  |  80 ++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld3.dtsi     | 118 +++++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts  |  79 ++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi     | 111 +++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-support-card.dtsi |  66 +++++++++++++++
 10 files changed, 846 insertions(+)
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
 create mode 100644 arch/arm/boot/dts/uniphier-support-card.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 86217db..558b787 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -600,6 +600,11 @@ dtb-$(CONFIG_ARCH_U8500) += \
 	ste-hrefv60plus-tvk.dtb \
 	ste-ccu8540.dtb \
 	ste-ccu9540.dtb
+dtb-$(CONFIG_ARCH_UNIPHIER) += \
+	uniphier-ph1-sld3-ref.dtb \
+	uniphier-ph1-ld4-ref.dtb \
+	uniphier-ph1-pro4-ref.dtb \
+	uniphier-ph1-sld8-ref.dtb
 dtb-$(CONFIG_ARCH_VERSATILE) += \
 	versatile-ab.dtb \
 	versatile-pb.dtb
diff --git a/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts b/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
new file mode 100644
index 0000000..200b0c9
--- /dev/null
+++ b/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
@@ -0,0 +1,79 @@
+/*
+ * Device Tree Source for UniPhier PH1-LD4 Reference Board
+ *
+ * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
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
+/include/ "uniphier-ph1-ld4.dtsi"
+/include/ "uniphier-support-card.dtsi"
+
+/ {
+	model = "UniPhier PH1-LD4 Reference Board";
+	compatible = "socionext,ph1-ld4-ref", "socionext,ph1-ld4";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+		stdout-path = &serialsc;
+	};
+
+	aliases {
+		serial0 = &serialsc;
+	};
+};
+
+&extbus {
+	ranges = <0 0x00000000 0x0f000000 0x01000000
+		  1 0x00000000 0x00000000 0x08000000>;
+};
+
+&support_card {
+	ranges = <0x00000000 1 0x03f00000 0x00100000>;
+};
+
+&serialsc {
+	interrupts = <0 49 4>;
+};
diff --git a/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
new file mode 100644
index 0000000..4d80334
--- /dev/null
+++ b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
@@ -0,0 +1,111 @@
+/*
+ * Device Tree Source for UniPhier PH1-LD4 SoC
+ *
+ * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
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
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "socionext,ph1-ld4";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+		};
+	};
+
+	clocks {
+		arm_timer_clk: arm_timer_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <50000000>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		interrupt-parent = <&intc>;
+
+		extbus: extbus {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <1>;
+		};
+
+		system-bus-controller-misc at 59800000 {
+			compatible = "socionext,uniphier-system-bus-controller-misc",
+				     "syscon";
+			reg = <0x59800000 0x2000>;
+		};
+
+		timer at 60000200 {
+			compatible = "arm,cortex-a9-global-timer";
+			reg = <0x60000200 0x20>;
+			interrupts = <1 11 0x104>;
+			interrupt-parent = <&intc>;
+			clocks = <&arm_timer_clk>;
+		};
+
+		timer at 60000600 {
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = <0x60000600 0x20>;
+			interrupts = <1 13 0x104>;
+			clocks = <&arm_timer_clk>;
+		};
+
+		intc: interrupt-controller at 60001000 {
+			compatible = "arm,cortex-a9-gic";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x60001000 0x1000>,
+			      <0x60000100 0x100>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts b/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
new file mode 100644
index 0000000..d891135
--- /dev/null
+++ b/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
@@ -0,0 +1,79 @@
+/*
+ * Device Tree Source for UniPhier PH1-Pro4 Reference Board
+ *
+ * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
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
+/include/ "uniphier-ph1-pro4.dtsi"
+/include/ "uniphier-support-card.dtsi"
+
+/ {
+	model = "UniPhier PH1-Pro4 Reference Board";
+	compatible = "socionext,ph1-pro4-ref", "socionext,ph1-pro4";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+		stdout-path = &serialsc;
+	};
+
+	aliases {
+		serial0 = &serialsc;
+	};
+};
+
+&extbus {
+	ranges = <0 0x00000000 0x0f000000 0x01000000
+		  1 0x00000000 0x00000000 0x08000000>;
+};
+
+&support_card {
+	ranges = <0x00000000 1 0x03f00000 0x00100000>;
+};
+
+&serialsc {
+	interrupts = <0 50 4>;
+};
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi b/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
new file mode 100644
index 0000000..cc090ad
--- /dev/null
+++ b/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
@@ -0,0 +1,118 @@
+/*
+ * Device Tree Source for UniPhier PH1-Pro4 SoC
+ *
+ * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
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
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "socionext,ph1-pro4";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		enable-method = "socionext,uniphier-smp";
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <1>;
+		};
+	};
+
+	clocks {
+		arm_timer_clk: arm_timer_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <50000000>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		interrupt-parent = <&intc>;
+
+		extbus: extbus {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <1>;
+		};
+
+		system-bus-controller-misc at 59800000 {
+			compatible = "socionext,uniphier-system-bus-controller-misc",
+				     "syscon";
+			reg = <0x59800000 0x2000>;
+		};
+
+		timer at 60000200 {
+			compatible = "arm,cortex-a9-global-timer";
+			reg = <0x60000200 0x20>;
+			interrupts = <1 11 0x304>;
+			interrupt-parent = <&intc>;
+			clocks = <&arm_timer_clk>;
+		};
+
+		timer at 60000600 {
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = <0x60000600 0x20>;
+			interrupts = <1 13 0x304>;
+			clocks = <&arm_timer_clk>;
+		};
+
+		intc: interrupt-controller at 60001000 {
+			compatible = "arm,cortex-a9-gic";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x60001000 0x1000>,
+			      <0x60000100 0x100>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts b/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
new file mode 100644
index 0000000..3ea64ae
--- /dev/null
+++ b/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
@@ -0,0 +1,80 @@
+/*
+ * Device Tree Source for UniPhier PH1-sLD3 Reference Board
+ *
+ * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
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
+/include/ "uniphier-ph1-sld3.dtsi"
+/include/ "uniphier-support-card.dtsi"
+
+/ {
+	model = "UniPhier PH1-sLD3 Reference Board";
+	compatible = "socionext,ph1-sld3-ref", "socionext,ph1-sld3";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000
+		       0xc0000000 0x20000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+		stdout-path = &serialsc;
+	};
+
+	aliases {
+		serial0 = &serialsc;
+	};
+};
+
+&extbus {
+	ranges = <0 0x00000000 0x0f000000 0x01000000
+		  1 0x00000000 0x00000000 0x08000000>;
+};
+
+&support_card {
+	ranges = <0x00000000 1 0x03f00000 0x00100000>;
+};
+
+&serialsc {
+	interrupts = <0 49 4>;
+};
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi b/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
new file mode 100644
index 0000000..271f94f
--- /dev/null
+++ b/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
@@ -0,0 +1,118 @@
+/*
+ * Device Tree Source for UniPhier PH1-sLD3 SoC
+ *
+ * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
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
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "socionext,ph1-sld3";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		enable-method = "socionext,uniphier-smp";
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <1>;
+		};
+	};
+
+	clocks {
+		arm_timer_clk: arm_timer_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <50000000>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		interrupt-parent = <&intc>;
+
+		extbus: extbus {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <1>;
+		};
+
+		timer at 20000200 {
+			compatible = "arm,cortex-a9-global-timer";
+			reg = <0x20000200 0x20>;
+			interrupts = <1 11 0x304>;
+			interrupt-parent = <&intc>;
+			clocks = <&arm_timer_clk>;
+		};
+
+		timer at 20000600 {
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = <0x20000600 0x20>;
+			interrupts = <1 13 0x304>;
+			clocks = <&arm_timer_clk>;
+		};
+
+		intc: interrupt-controller at 20001000 {
+			compatible = "arm,cortex-a9-gic";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x20001000 0x1000>,
+			      <0x20000100 0x100>;
+		};
+
+		system-bus-controller-misc at 59800000 {
+			compatible = "socionext,uniphier-system-bus-controller-misc",
+				     "syscon";
+			reg = <0x59800000 0x2000>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts b/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
new file mode 100644
index 0000000..dcdc4f7
--- /dev/null
+++ b/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
@@ -0,0 +1,79 @@
+/*
+ * Device Tree Source for UniPhier PH1-sLD8 Reference Board
+ *
+ * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
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
+/include/ "uniphier-ph1-sld8.dtsi"
+/include/ "uniphier-support-card.dtsi"
+
+/ {
+	model = "UniPhier PH1-sLD8 Reference Board";
+	compatible = "socionext,ph1-sld8-ref", "socionext,ph1-sld8";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+		stdout-path = &serialsc;
+	};
+
+	aliases {
+		serial0 = &serialsc;
+	};
+};
+
+&extbus {
+	ranges = <0 0x00000000 0x0f000000 0x01000000
+		  1 0x00000000 0x00000000 0x08000000>;
+};
+
+&support_card {
+	ranges = <0x00000000 1 0x03f00000 0x00100000>;
+};
+
+&serialsc {
+	interrupts = <0 48 4>;
+};
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi b/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
new file mode 100644
index 0000000..666c9fd
--- /dev/null
+++ b/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
@@ -0,0 +1,111 @@
+/*
+ * Device Tree Source for UniPhier PH1-sLD8 SoC
+ *
+ * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
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
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "socionext,ph1-sld8";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+		};
+	};
+
+	clocks {
+		arm_timer_clk: arm_timer_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <50000000>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		interrupt-parent = <&intc>;
+
+		extbus: extbus {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <1>;
+		};
+
+		system-bus-controller-misc at 59800000 {
+			compatible = "socionext,uniphier-system-bus-controller-misc",
+				     "syscon";
+			reg = <0x59800000 0x2000>;
+		};
+
+		timer at 60000200 {
+			compatible = "arm,cortex-a9-global-timer";
+			reg = <0x60000200 0x20>;
+			interrupts = <1 11 0x104>;
+			interrupt-parent = <&intc>;
+			clocks = <&arm_timer_clk>;
+		};
+
+		timer at 60000600 {
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = <0x60000600 0x20>;
+			interrupts = <1 13 0x104>;
+			clocks = <&arm_timer_clk>;
+		};
+
+		intc: interrupt-controller at 60001000 {
+			compatible = "arm,cortex-a9-gic";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x60001000 0x1000>,
+			      <0x60000100 0x100>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/uniphier-support-card.dtsi b/arch/arm/boot/dts/uniphier-support-card.dtsi
new file mode 100644
index 0000000..443013f
--- /dev/null
+++ b/arch/arm/boot/dts/uniphier-support-card.dtsi
@@ -0,0 +1,66 @@
+/*
+ * Device Tree Source for UniPhier Support Card (Expansion Board)
+ *
+ * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
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
+&extbus {
+	support_card: support_card {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		ethsc: ethernet at 00000000 {
+			compatible = "smsc,lan9118", "smsc,lan9115";
+			reg = <0x00000000 0x1000>;
+			phy-mode = "mii";
+			reg-io-width = <4>;
+		};
+
+		serialsc: uart at 000b0000 {
+			compatible = "ns16550a";
+			reg = <0x000b0000 0x20>;
+			clock-frequency = <12288000>;
+			reg-shift = <1>;
+			fifo-size = <16>;
+		};
+	};
+};
-- 
1.9.1
