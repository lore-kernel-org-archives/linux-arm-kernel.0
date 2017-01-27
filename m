From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Fri, 27 Jan 2017 17:15:21 +0100
Subject: [PATCH 8/8] ARM: dts: stm32: create dedicated files for pinctrl
 definitions
In-Reply-To: <1485533721-9019-1-git-send-email-alexandre.torgue@st.com>
References: <1485533721-9019-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1485533721-9019-9-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create dedicated file by MCU for pinmuxing and gpio definitions.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 5436e88..7f22385 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -46,6 +46,7 @@
  */
 
 /dts-v1/;
+#include "stm32f429-pinctrl.dtsi"
 #include "stm32f429.dtsi"
 #include <dt-bindings/input/input.h>
 
diff --git a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
new file mode 100644
index 0000000..d349c59
--- /dev/null
+++ b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
@@ -0,0 +1,196 @@
+/*
+ * Copyright 2016 - Alexandre Torgue <alexandre.torgue@linaro.org>
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
+#include <dt-bindings/pinctrl/stm32f4-pinfunc.h>
+/ {
+	soc {
+		pinctrl: pin-controller {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x40020000 0x3000>;
+			interrupt-parent = <&exti>;
+			st,syscfg = <&syscfg 0x8>;
+			pins-are-numbered;
+
+			gpioa: gpio at 40020000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x0 0x400>;
+				clocks = <&rcc 0 0>;
+				st,bank-name = "GPIOA";
+			};
+
+			gpiob: gpio at 40020400 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x400 0x400>;
+				clocks = <&rcc 0 1>;
+				st,bank-name = "GPIOB";
+			};
+
+			gpioc: gpio at 40020800 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x800 0x400>;
+				clocks = <&rcc 0 2>;
+				st,bank-name = "GPIOC";
+			};
+
+			gpiod: gpio at 40020c00 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0xc00 0x400>;
+				clocks = <&rcc 0 3>;
+				st,bank-name = "GPIOD";
+			};
+
+			gpioe: gpio at 40021000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1000 0x400>;
+				clocks = <&rcc 0 4>;
+				st,bank-name = "GPIOE";
+			};
+
+			gpiof: gpio at 40021400 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1400 0x400>;
+				clocks = <&rcc 0 5>;
+				st,bank-name = "GPIOF";
+			};
+
+			gpiog: gpio at 40021800 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1800 0x400>;
+				clocks = <&rcc 0 6>;
+				st,bank-name = "GPIOG";
+			};
+
+			gpioh: gpio at 40021c00 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1c00 0x400>;
+				clocks = <&rcc 0 7>;
+				st,bank-name = "GPIOH";
+			};
+
+			gpioi: gpio at 40022000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x2000 0x400>;
+				clocks = <&rcc 0 8>;
+				st,bank-name = "GPIOI";
+			};
+
+			gpioj: gpio at 40022400 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x2400 0x400>;
+				clocks = <&rcc 0 9>;
+				st,bank-name = "GPIOJ";
+			};
+
+			gpiok: gpio at 40022800 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x2800 0x400>;
+				clocks = <&rcc 0 10>;
+				st,bank-name = "GPIOK";
+			};
+
+			usart1_pins_a: usart1 at 0 {
+				pins1 {
+					pinmux = <STM32F4_PA9_FUNC_USART1_TX>;
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+				pins2 {
+					pinmux = <STM32F4_PA10_FUNC_USART1_RX>;
+					bias-disable;
+				};
+			};
+
+			usbotg_hs_pins_a: usbotg_hs at 0 {
+				pins {
+					pinmux = <STM32F4_PH4_FUNC_OTG_HS_ULPI_NXT>,
+						 <STM32F4_PI11_FUNC_OTG_HS_ULPI_DIR>,
+						 <STM32F4_PC0_FUNC_OTG_HS_ULPI_STP>,
+						 <STM32F4_PA5_FUNC_OTG_HS_ULPI_CK>,
+						 <STM32F4_PA3_FUNC_OTG_HS_ULPI_D0>,
+						 <STM32F4_PB0_FUNC_OTG_HS_ULPI_D1>,
+						 <STM32F4_PB1_FUNC_OTG_HS_ULPI_D2>,
+						 <STM32F4_PB10_FUNC_OTG_HS_ULPI_D3>,
+						 <STM32F4_PB11_FUNC_OTG_HS_ULPI_D4>,
+						 <STM32F4_PB12_FUNC_OTG_HS_ULPI_D5>,
+						 <STM32F4_PB13_FUNC_OTG_HS_ULPI_D6>,
+						 <STM32F4_PB5_FUNC_OTG_HS_ULPI_D7>;
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <2>;
+				};
+			};
+
+			ethernet_mii: mii at 0 {
+				pins {
+					pinmux = <STM32F4_PG13_FUNC_ETH_MII_TXD0_ETH_RMII_TXD0>,
+						 <STM32F4_PG14_FUNC_ETH_MII_TXD1_ETH_RMII_TXD1>,
+						 <STM32F4_PC2_FUNC_ETH_MII_TXD2>,
+						 <STM32F4_PB8_FUNC_ETH_MII_TXD3>,
+						 <STM32F4_PC3_FUNC_ETH_MII_TX_CLK>,
+						 <STM32F4_PG11_FUNC_ETH_MII_TX_EN_ETH_RMII_TX_EN>,
+						 <STM32F4_PA2_FUNC_ETH_MDIO>,
+						 <STM32F4_PC1_FUNC_ETH_MDC>,
+						 <STM32F4_PA1_FUNC_ETH_MII_RX_CLK_ETH_RMII_REF_CLK>,
+						 <STM32F4_PA7_FUNC_ETH_MII_RX_DV_ETH_RMII_CRS_DV>,
+						 <STM32F4_PC4_FUNC_ETH_MII_RXD0_ETH_RMII_RXD0>,
+						 <STM32F4_PC5_FUNC_ETH_MII_RXD1_ETH_RMII_RXD1>,
+						 <STM32F4_PH6_FUNC_ETH_MII_RXD2>,
+						 <STM32F4_PH7_FUNC_ETH_MII_RXD3>;
+					slew-rate = <2>;
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
index 7d0415e..ddff78c 100644
--- a/arch/arm/boot/dts/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/stm32f429-disco.dts
@@ -46,6 +46,7 @@
  */
 
 /dts-v1/;
+#include "stm32f429-pinctrl.dtsi"
 #include "stm32f429.dtsi"
 #include <dt-bindings/input/input.h>
 
diff --git a/arch/arm/boot/dts/stm32f429-pinctrl.dtsi b/arch/arm/boot/dts/stm32f429-pinctrl.dtsi
new file mode 100644
index 0000000..54aa8e5
--- /dev/null
+++ b/arch/arm/boot/dts/stm32f429-pinctrl.dtsi
@@ -0,0 +1,106 @@
+/*
+ * Copyright 2016 - Alexandre Torgue <alexandre.torgue@linaro.org>
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
+#include "stm32f4-pinctrl.dtsi"
+
+/ {
+	soc {
+		pinctrl: pin-controller {
+			compatible = "st,stm32f429-pinctrl";
+
+			gpioa: gpio at 40020000 {
+				ngpios = <16>;
+				gpio-ranges = <&pinctrl 0 0 16>;
+			};
+
+			gpiob: gpio at 40020400 {
+				ngpios = <16>;
+				gpio-ranges = <&pinctrl 0 16 16>;
+			};
+
+			gpioc: gpio at 40020800 {
+				ngpios = <16>;
+				gpio-ranges = <&pinctrl 0 32 16>;
+			};
+
+			gpiod: gpio at 40020c00 {
+				ngpios = <16>;
+				gpio-ranges = <&pinctrl 0 48 16>;
+			};
+
+			gpioe: gpio at 40021000 {
+				ngpios = <16>;
+				gpio-ranges = <&pinctrl 0 64 16>;
+			};
+
+			gpiof: gpio at 40021400 {
+				ngpios = <16>;
+				gpio-ranges = <&pinctrl 0 80 16>;
+			};
+
+			gpiog: gpio at 40021800 {
+				ngpios = <16>;
+				gpio-ranges = <&pinctrl 0 96 16>;
+			};
+
+			gpioh: gpio at 40021c00 {
+				ngpios = <16>;
+				gpio-ranges = <&pinctrl 0 112 16>;
+			};
+
+			gpioi: gpio at 40022000 {
+				ngpios = <16>;
+				gpio-ranges = <&pinctrl 0 128 16>;
+			};
+
+			gpioj: gpio at 40022400 {
+				ngpios = <16>;
+				gpio-ranges = <&pinctrl 0 144 16>;
+			};
+
+			gpiok: gpio at 40022800 {
+				ngpios = <8>;
+				gpio-ranges = <&pinctrl 0 160 8>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index d585288..99ce8bb 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -47,8 +47,6 @@
 
 #include "skeleton.dtsi"
 #include "armv7-m.dtsi"
-#include <dt-bindings/pinctrl/stm32f4-pinfunc.h>
-
 / {
 	clocks {
 		clk_hse: clk-hse {
@@ -206,157 +204,6 @@
 			reg = <0x40007000 0x400>;
 		};
 
-		pin-controller {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "st,stm32f429-pinctrl";
-			ranges = <0 0x40020000 0x3000>;
-			interrupt-parent = <&exti>;
-			st,syscfg = <&syscfg 0x8>;
-			pins-are-numbered;
-
-			gpioa: gpio at 40020000 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x0 0x400>;
-				clocks = <&rcc 0 0>;
-				st,bank-name = "GPIOA";
-			};
-
-			gpiob: gpio at 40020400 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x400 0x400>;
-				clocks = <&rcc 0 1>;
-				st,bank-name = "GPIOB";
-			};
-
-			gpioc: gpio at 40020800 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x800 0x400>;
-				clocks = <&rcc 0 2>;
-				st,bank-name = "GPIOC";
-			};
-
-			gpiod: gpio at 40020c00 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0xc00 0x400>;
-				clocks = <&rcc 0 3>;
-				st,bank-name = "GPIOD";
-			};
-
-			gpioe: gpio at 40021000 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x1000 0x400>;
-				clocks = <&rcc 0 4>;
-				st,bank-name = "GPIOE";
-			};
-
-			gpiof: gpio at 40021400 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x1400 0x400>;
-				clocks = <&rcc 0 5>;
-				st,bank-name = "GPIOF";
-			};
-
-			gpiog: gpio at 40021800 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x1800 0x400>;
-				clocks = <&rcc 0 6>;
-				st,bank-name = "GPIOG";
-			};
-
-			gpioh: gpio at 40021c00 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x1c00 0x400>;
-				clocks = <&rcc 0 7>;
-				st,bank-name = "GPIOH";
-			};
-
-			gpioi: gpio at 40022000 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x2000 0x400>;
-				clocks = <&rcc 0 8>;
-				st,bank-name = "GPIOI";
-			};
-
-			gpioj: gpio at 40022400 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x2400 0x400>;
-				clocks = <&rcc 0 9>;
-				st,bank-name = "GPIOJ";
-			};
-
-			gpiok: gpio at 40022800 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x2800 0x400>;
-				clocks = <&rcc 0 10>;
-				st,bank-name = "GPIOK";
-			};
-
-			usart1_pins_a: usart1 at 0 {
-				pins1 {
-					pinmux = <STM32F4_PA9_FUNC_USART1_TX>;
-					bias-disable;
-					drive-push-pull;
-					slew-rate = <0>;
-				};
-				pins2 {
-					pinmux = <STM32F4_PA10_FUNC_USART1_RX>;
-					bias-disable;
-				};
-			};
-
-			usbotg_hs_pins_a: usbotg_hs at 0 {
-				pins {
-					pinmux = <STM32F4_PH4_FUNC_OTG_HS_ULPI_NXT>,
-						 <STM32F4_PI11_FUNC_OTG_HS_ULPI_DIR>,
-						 <STM32F4_PC0_FUNC_OTG_HS_ULPI_STP>,
-						 <STM32F4_PA5_FUNC_OTG_HS_ULPI_CK>,
-						 <STM32F4_PA3_FUNC_OTG_HS_ULPI_D0>,
-						 <STM32F4_PB0_FUNC_OTG_HS_ULPI_D1>,
-						 <STM32F4_PB1_FUNC_OTG_HS_ULPI_D2>,
-						 <STM32F4_PB10_FUNC_OTG_HS_ULPI_D3>,
-						 <STM32F4_PB11_FUNC_OTG_HS_ULPI_D4>,
-						 <STM32F4_PB12_FUNC_OTG_HS_ULPI_D5>,
-						 <STM32F4_PB13_FUNC_OTG_HS_ULPI_D6>,
-						 <STM32F4_PB5_FUNC_OTG_HS_ULPI_D7>;
-					bias-disable;
-					drive-push-pull;
-					slew-rate = <2>;
-				};
-			};
-
-			ethernet_mii: mii at 0 {
-				pins {
-					pinmux = <STM32F4_PG13_FUNC_ETH_MII_TXD0_ETH_RMII_TXD0>,
-						 <STM32F4_PG14_FUNC_ETH_MII_TXD1_ETH_RMII_TXD1>,
-						 <STM32F4_PC2_FUNC_ETH_MII_TXD2>,
-						 <STM32F4_PB8_FUNC_ETH_MII_TXD3>,
-						 <STM32F4_PC3_FUNC_ETH_MII_TX_CLK>,
-						 <STM32F4_PG11_FUNC_ETH_MII_TX_EN_ETH_RMII_TX_EN>,
-						 <STM32F4_PA2_FUNC_ETH_MDIO>,
-						 <STM32F4_PC1_FUNC_ETH_MDC>,
-						 <STM32F4_PA1_FUNC_ETH_MII_RX_CLK_ETH_RMII_REF_CLK>,
-						 <STM32F4_PA7_FUNC_ETH_MII_RX_DV_ETH_RMII_CRS_DV>,
-						 <STM32F4_PC4_FUNC_ETH_MII_RXD0_ETH_RMII_RXD0>,
-						 <STM32F4_PC5_FUNC_ETH_MII_RXD1_ETH_RMII_RXD1>,
-						 <STM32F4_PH6_FUNC_ETH_MII_RXD2>,
-						 <STM32F4_PH7_FUNC_ETH_MII_RXD3>;
-					slew-rate = <2>;
-				};
-			};
-		};
-
 		rcc: rcc at 40023810 {
 			#reset-cells = <1>;
 			#clock-cells = <2>;
diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index 8877c00..8629a78 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -46,6 +46,7 @@
  */
 
 /dts-v1/;
+#include "stm32f469-pinctrl.dtsi"
 #include "stm32f429.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/stm32f469-pinctrl.dtsi b/arch/arm/boot/dts/stm32f469-pinctrl.dtsi
new file mode 100644
index 0000000..523459f
--- /dev/null
+++ b/arch/arm/boot/dts/stm32f469-pinctrl.dtsi
@@ -0,0 +1,107 @@
+/*
+ * Copyright 2016 - Alexandre Torgue <alexandre.torgue@linaro.org>
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
+#include "stm32f4-pinctrl.dtsi"
+
+/ {
+	soc {
+		pinctrl: pin-controller {
+			compatible = "st,stm32f469-pinctrl";
+
+			gpioa: gpio at 40020000 {
+				ngpios = <16>;
+				gpio-ranges = <&pinctrl 0 0 16>;
+			};
+
+			gpiob: gpio at 40020400 {
+				ngpios = <16>;
+				gpio-ranges = <&pinctrl 0 16 16>;
+			};
+
+			gpioc: gpio at 40020800 {
+				ngpios = <16>;
+				gpio-ranges = <&pinctrl 0 32 16>;
+			};
+
+			gpiod: gpio at 40020c00 {
+				ngpios = <16>;
+				gpio-ranges = <&pinctrl 0 48 16>;
+			};
+
+			gpioe: gpio at 40021000 {
+				ngpios = <16>;
+				gpio-ranges = <&pinctrl 0 64 16>;
+			};
+
+			gpiof: gpio at 40021400 {
+				ngpios = <16>;
+				gpio-ranges = <&pinctrl 0 80 16>;
+			};
+
+			gpiog: gpio at 40021800 {
+				ngpios = <16>;
+				gpio-ranges = <&pinctrl 0 96 16>;
+			};
+
+			gpioh: gpio at 40021c00 {
+				ngpios = <16>;
+				gpio-ranges = <&pinctrl 0 112 16>;
+			};
+
+			gpioi: gpio at 40022000 {
+				ngpios = <16>;
+				gpio-ranges = <&pinctrl 0 128 16>;
+			};
+
+			gpioj: gpio at 40022400 {
+				ngpios = <10>;
+				gpio-ranges = <&pinctrl 0 144 6>,
+					      <&pinctrl 12 156 4>;
+			};
+
+			gpiok: gpio at 40022800 {
+				ngpios = <5>;
+				gpio-ranges = <&pinctrl 3 163 5>;
+			};
+		};
+	};
+};
-- 
1.9.1
