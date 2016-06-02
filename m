From: luoyi.ly@gmail.com (luoyi.ly at gmail.com)
Date: Thu,  2 Jun 2016 10:36:23 +0800
Subject: [PATCH] [V2] ARM: dts: sun7i: Add dts file for Bananapi M1 Plus board
Message-ID: <20160602023623.5761-1-luoyi.ly@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Luo Yi <luoyi.ly@gmail.com>

Add support for the Bananapi M1 Plus A20 development board from
sinovoip.com.cn . This board is nearly a clone of the Lemaker's
Bananapro, but differ with the wlan chipset connection and i2s pinout.
And I also enable the integrated audio codec on default.
---
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts | 72 ++++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
new file mode 100644
index 0000000..6fd55d7
--- /dev/null
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
@@ -0,0 +1,72 @@
+/*
+ * Copyright 2016 Luo Yi <luoyi.ly@gmail.com>
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
+#include "sun7i-a20-bananapro.dts"
+
+/ {
+	model = "Banana Pi BPI-M1-Plus";
+	compatible = "sinovoip,bpi-m1-plus", "allwinner,sun7i-a20";
+};
+
+
+&codec {
+	status = "okay";
+};
+
+&mmc3 {
+	enable-sdio-wakeup;
+
+	brcmf: bcrmf at 1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&pio>;
+		interrupts = <7 15 IRQ_TYPE_LEVEL_LOW>; 
+		interrupt-names = "host-wake";
+	};
+
+};
+
+&mmc3_pins_a {
+    /* AP6210 requires pull-up */
+	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+};
+
-- 
2.8.3
