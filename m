From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Tue, 31 Jan 2017 14:14:24 +0100
Subject: [PATCH 7/8] ARM: dts: stm32: Add STM32H743 MCU and STM32H743i-EVAL
 board
In-Reply-To: <1485868465-30446-1-git-send-email-alexandre.torgue@st.com>
References: <1485868465-30446-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1485868465-30446-8-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic support for STM32H743 MCU and his eval board.
The STMicrolectornics's STM32H743 MCU is based on  Cortex-M7 core
running up to @400MHz with 2MB internal flash and 1MB internal RAM.

For more details see:
Documentation/arm/stm32/stm32h743-overview.txt

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index cccdbcb..f38a845 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -746,7 +746,8 @@ dtb-$(CONFIG_ARCH_STM32)+= \
 	stm32f429-disco.dtb \
 	stm32f469-disco.dtb \
 	stm32429i-eval.dtb \
-	stm32746g-eval.dtb
+	stm32746g-eval.dtb \
+	stm32h743i-eval.dtb
 dtb-$(CONFIG_MACH_SUN4I) += \
 	sun4i-a10-a1000.dtb \
 	sun4i-a10-ba10-tvbox.dtb \
diff --git a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
new file mode 100644
index 0000000..fcc1e06
--- /dev/null
+++ b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
@@ -0,0 +1,156 @@
+/*
+ * Copyright 2017 - Alexandre Torgue <alexandre.torgue@st.com>
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
+#include <dt-bindings/pinctrl/stm32h7-pinfunc.h>
+
+/ {
+	soc {
+		pin-controller {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "st,stm32h743-pinctrl";
+			ranges = <0 0x58020000 0x3000>;
+			pins-are-numbered;
+
+			gpioa: gpio at 58020000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x0 0x400>;
+				clocks = <&timer_clk>;
+				st,bank-name = "GPIOA";
+			};
+
+			gpiob: gpio at 58020400 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x400 0x400>;
+				clocks = <&timer_clk>;
+				st,bank-name = "GPIOB";
+			};
+
+			gpioc: gpio at 58020800 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x800 0x400>;
+				clocks = <&timer_clk>;
+				st,bank-name = "GPIOC";
+			};
+
+			gpiod: gpio at 58020c00 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0xc00 0x400>;
+				clocks = <&timer_clk>;
+				st,bank-name = "GPIOD";
+			};
+
+			gpioe: gpio at 58021000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1000 0x400>;
+				clocks = <&timer_clk>;
+				st,bank-name = "GPIOE";
+			};
+
+			gpiof: gpio at 58021400 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1400 0x400>;
+				clocks = <&timer_clk>;
+				st,bank-name = "GPIOF";
+			};
+
+			gpiog: gpio at 58021800 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1800 0x400>;
+				clocks = <&timer_clk>;
+				st,bank-name = "GPIOG";
+			};
+
+			gpioh: gpio at 58021c00 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1c00 0x400>;
+				clocks = <&timer_clk>;
+				st,bank-name = "GPIOH";
+			};
+
+			gpioi: gpio at 58022000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x2000 0x400>;
+				clocks = <&timer_clk>;
+				st,bank-name = "GPIOI";
+			};
+
+			gpioj: gpio at 58022400 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x2400 0x400>;
+				clocks = <&timer_clk>;
+				st,bank-name = "GPIOJ";
+			};
+
+			gpiok: gpio at 58022800 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x2800 0x400>;
+				clocks = <&timer_clk>;
+				st,bank-name = "GPIOK";
+			};
+
+			usart1_pins: usart1 at 0 {
+				pins1 {
+					pinmux = <STM32H7_PB14_FUNC_USART1_TX>;
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+				pins2 {
+					pinmux = <STM32H7_PB15_FUNC_USART1_RX>;
+					bias-disable;
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
new file mode 100644
index 0000000..4685629
--- /dev/null
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -0,0 +1,83 @@
+/*
+ * Copyright 2017 - Alexandre Torgue <alexandre.torgue@st.com>
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
+#include "skeleton.dtsi"
+#include "armv7-m.dtsi"
+
+/ {
+	clocks {
+		clk_hse: clk-hse {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <0>;
+		};
+
+		timer_clk: timer-clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <125000000>;
+		};
+	};
+
+	soc {
+		usart1: serial at 40011000 {
+			compatible = "st,stm32f7-usart", "st,stm32f7-uart";
+			reg = <0x40011000 0x400>;
+			interrupts = <37>;
+			status = "disabled";
+			clocks = <&timer_clk>;
+
+		};
+
+		timer5: timer at 40000c00 {
+			compatible = "st,stm32-timer";
+			reg = <0x40000c00 0x400>;
+			interrupts = <50>;
+			clocks = <&timer_clk>;
+		};
+	};
+};
+
+&systick {
+	clock-frequency = <250000000>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/stm32h743i-eval.dts b/arch/arm/boot/dts/stm32h743i-eval.dts
new file mode 100644
index 0000000..c6effbb
--- /dev/null
+++ b/arch/arm/boot/dts/stm32h743i-eval.dts
@@ -0,0 +1,74 @@
+/*
+ * Copyright 2017 - Alexandre Torgue <alexandre.torgue@st.com>
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
+#include "stm32h743.dtsi"
+#include "stm32h743-pinctrl.dtsi"
+
+/ {
+	model = "STMicroelectronics STM32H743i-EVAL board";
+	compatible = "st,stm32h743i-eval", "st,stm32h743";
+
+	chosen {
+		bootargs = "root=/dev/ram";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory {
+		reg = <0xd0000000 0x2000000>;
+	};
+
+	aliases {
+		serial0 = &usart1;
+	};
+};
+
+&clk_hse {
+	clock-frequency = <125000000>;
+};
+
+&usart1 {
+	pinctrl-0 = <&usart1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
-- 
1.9.1
