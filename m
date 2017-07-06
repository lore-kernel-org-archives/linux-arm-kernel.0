From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Thu, 6 Jul 2017 11:35:28 +0300
Subject: [PATCH v3 4/5] ARM: dts: at91: at91-sama5d27_som1: add sama5d27 SoM1
 support
In-Reply-To: <1499330129-29319-1-git-send-email-claudiu.beznea@microchip.com>
References: <1499330129-29319-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1499330129-29319-5-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add specific DTS file and bindings for sama5d27 SoM1 board.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_som1.dtsi | 102 ++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-sama5d27_som1.dtsi

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1.dtsi b/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
new file mode 100644
index 0000000..63a5af8
--- /dev/null
+++ b/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
@@ -0,0 +1,102 @@
+/*
+ * at91-sama5d27_som1.dtsi - Device Tree file for SAMA5D27 SoM1 board
+ *
+ *  Copyright (c) 2017, Microchip Technology Inc.
+ *                2017 Cristian Birsan <cristian.birsan@microchip.com>
+ *                2017 Claudiu Beznea <claudiu.beznea@microchip.com>
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
+#include "sama5d2.dtsi"
+#include "sama5d2-pinfunc.h"
+
+/ {
+	model = "Atmel SAMA5D27 SoM1";
+	compatible = "atmel,sama5d27-som1", "atmel,sama5d27", "atmel,sama5d2", "atmel,sama5";
+
+	clocks {
+		slow_xtal {
+			clock-frequency = <32768>;
+		};
+
+		main_xtal {
+			clock-frequency = <24000000>;
+		};
+	};
+
+	ahb {
+		apb {
+			macb0: ethernet at f8008000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_macb0_default>;
+				phy-mode = "rmii";
+
+				ethernet-phy at 1 {
+					reg = <0x1>;
+					interrupt-parent = <&pioA>;
+					interrupts = <PIN_PD31 IRQ_TYPE_LEVEL_LOW>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_macb0_phy_irq>;
+				};
+			};
+
+			pinctrl at fc038000 {
+
+				pinctrl_macb0_default: macb0_default {
+					pinmux = <PIN_PD9__GTXCK>,
+						 <PIN_PD10__GTXEN>,
+						 <PIN_PD11__GRXDV>,
+						 <PIN_PD12__GRXER>,
+						 <PIN_PD13__GRX0>,
+						 <PIN_PD14__GRX1>,
+						 <PIN_PD15__GTX0>,
+						 <PIN_PD16__GTX1>,
+						 <PIN_PD17__GMDC>,
+						 <PIN_PD18__GMDIO>;
+					bias-disable;
+				};
+
+				pinctrl_macb0_phy_irq: macb0_phy_irq {
+					pinmux = <PIN_PD31__GPIO>;
+					bias-disable;
+				};
+			};
+		};
+	};
+};
-- 
2.7.4
