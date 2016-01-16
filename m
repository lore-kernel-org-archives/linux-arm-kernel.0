From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 17 Jan 2016 00:24:57 +0800
Subject: [PATCH 3/3] ARM: dts: sun8i: Add device tree for Cubietruck Plus
In-Reply-To: <1452961497-10804-1-git-send-email-wens@csie.org>
References: <1452961497-10804-1-git-send-email-wens@csie.org>
Message-ID: <1452961497-10804-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cubietruck Plus is a A83T/H8 based development board. The board has
standard DDR3 SDRAM, AXP818 PMIC/codec, SD/MMC, eMMC, USB 2.0 host
via HSIC USB Hub, USB OTG, SATA via USB bridge, gigabit ethernet,
WiFi, headphone out / mic in, and various GPIO headers.

The board also has an EEPROM on i2c0 which holds the MAC address.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/Makefile                       |  1 +
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts | 65 ++++++++++++++++++++++++
 2 files changed, 66 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5dbb67b26318..de9b2f1fd272 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -664,6 +664,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-a33-q8-tablet.dtb \
 	sun8i-a33-sinlinx-sina33.dtb \
 	sun8i-a83t-allwinner-h8homlet-v2.dtb \
+	sun8i-a83t-cubietruck-plus.dtb \
 	sun8i-h3-orangepi-plus.dtb
 dtb-$(CONFIG_MACH_SUN9I) += \
 	sun9i-a80-optimus.dtb \
diff --git a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
new file mode 100644
index 000000000000..88b1e0970b8d
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
@@ -0,0 +1,65 @@
+/*
+ * Copyright 2015 Chen-Yu Tsai
+ *
+ * Chen-Yu Tsai <wens@csie.org>
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
+#include "sun8i-a83t.dtsi"
+
+/ {
+	model = "Cubietech Cubietruck Plus";
+	compatible = "cubietech,cubietruck-plus", "allwinner,sun8i-a83t";
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
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_b>;
+	status = "okay";
+};
-- 
2.7.0.rc3
