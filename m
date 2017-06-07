From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Wed, 7 Jun 2017 09:16:23 +0200
Subject: [PATCH 3/3] ARM: dts: stm32: Add stm32h743i-disco board
In-Reply-To: <1496819783-5113-1-git-send-email-patrice.chotard@st.com>
References: <1496819783-5113-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1496819783-5113-4-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Add basic support for stm32h743i-discovery board

This board offers :
  _ 2MBytes Flash
  _ 1 x micro USB OTG port
  _ 1 x STLink connector (micro USB)
  _ 1 x micro SD card slot
  _ 1 x RJ45 connector
  _ 1 x RCA connector
  _ 2 x Audio jack connectors (in and out)
  _ 2 x speaker connectors (left and right)
  _ 1 x joystick
  _ 1 x DCMI connector (Digital camera interface)
  _ 1 x 4 inch DSI LCD (Display Serial Interface)
  _ Arduino Uno Connectors
  _ 2 x PIO connectors (PMOD and PMOD+)
  _ 1 x wakeup button
  _ 1 x reset button

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/Makefile             |  3 +-
 arch/arm/boot/dts/stm32h743i-disco.dts | 73 ++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/stm32h743i-disco.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9c5e1d9..52839d0 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -792,7 +792,8 @@ dtb-$(CONFIG_ARCH_STM32)+= \
 	stm32f469-disco.dtb \
 	stm32429i-eval.dtb \
 	stm32746g-eval.dtb \
-	stm32h743i-eval.dtb
+	stm32h743i-eval.dtb \
+	stm32h743i-disco.dtb
 dtb-$(CONFIG_MACH_SUN4I) += \
 	sun4i-a10-a1000.dtb \
 	sun4i-a10-ba10-tvbox.dtb \
diff --git a/arch/arm/boot/dts/stm32h743i-disco.dts b/arch/arm/boot/dts/stm32h743i-disco.dts
new file mode 100644
index 0000000..79e841d
--- /dev/null
+++ b/arch/arm/boot/dts/stm32h743i-disco.dts
@@ -0,0 +1,73 @@
+/*
+ * Copyright 2017 - Patrice Chotard <patrice.chotard@st.com>
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
+	model = "STMicroelectronics STM32H743i-Discovery board";
+	compatible = "st,stm32h743i-disco", "st,stm32h743";
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
+		serial0 = &usart2;
+	};
+};
+
+&clk_hse {
+	clock-frequency = <125000000>;
+};
+
+&usart2 {
+	pinctrl-0 = <&usart2_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
-- 
1.9.1
