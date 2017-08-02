From: embed3d@gmail.com (Philipp Rossak)
Date: Thu,  3 Aug 2017 01:25:02 +0200
Subject: [PATCH] This patch adds support for Sinovoip BPI-M3 A83T based board.
Message-ID: <1501716302-1009-1-git-send-email-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Rossak <embed3d@gmail.com>

It has 2G LPDDR3, UART, ethernet, USB, HDMI, USB Sata, MIPI DSI,
mic, AP6212 Wifi, etc on it.
It is paired with AXP813 PMIC which is almost same as AXP818.

Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>

This Patch got somehow lost. This is a resubmit! The original patch
could be found here: https://patchwork.ozlabs.org/patch/598497/

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/Makefile                       |  1 +
 arch/arm/boot/dts/sun8i-a83t-sinovoip-bpi-m3.dts | 65 ++++++++++++++++++++++++
 2 files changed, 66 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-a83t-sinovoip-bpi-m3.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4b17f35..24cd10e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -904,6 +904,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-a33-sinlinx-sina33.dtb \
 	sun8i-a83t-allwinner-h8homlet-v2.dtb \
 	sun8i-a83t-cubietruck-plus.dtb \
+	sun8i-a83t-sinovoip-bpi-m3.dtb \
 	sun8i-h2-plus-orangepi-zero.dtb \
 	sun8i-h3-bananapi-m2-plus.dtb \
 	sun8i-h3-beelink-x2.dtb \
diff --git a/arch/arm/boot/dts/sun8i-a83t-sinovoip-bpi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-sinovoip-bpi-m3.dts
new file mode 100644
index 0000000..3c8a261
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-a83t-sinovoip-bpi-m3.dts
@@ -0,0 +1,65 @@
+/*
+ * Copyright 2016 Vishnu Patekar
+ * Vishnu Patekar <vishnupatekar0510@gmail.com>
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
+#include "sunxi-common-regulators.dtsi"
+
+/ {
+	model = "Sinovoip BananaPi M3 v1.2";
+	compatible = "sinovoip,bpi-m3", "allwinner,sun8i-a83t";
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
+	pinctrl-0 = <&uart0_pb_pins>;
+	status = "okay";
+};
-- 
2.7.4
