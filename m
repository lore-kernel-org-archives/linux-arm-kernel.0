From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Sun, 25 Oct 2015 23:20:56 +0530
Subject: [PATCH] ARM: dts: vf6xx: Cosmic+: M4(nommu) initial support
Message-ID: <1445795456-6698-1-git-send-email-afzal.mohd.ma@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Minimal Cortex-M4 device tree to boot Linux to shell. M4 is booted via
Cortex-A5 running Linux using Stefan Agner's <stefan@agner.ch> "m4boot"
utility.

Signed-off-by: Afzal Mohammed <afzal.mohd.ma@gmail.com>
---
 arch/arm/boot/dts/Makefile           |  1 +
 arch/arm/boot/dts/vf610m4-cosmic.dts | 90 ++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 arch/arm/boot/dts/vf610m4-cosmic.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index bb8fa023d574..06a1a7a1d104 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -347,6 +347,7 @@ dtb-$(CONFIG_SOC_VF610) += \
 	vf610-colibri-eval-v3.dtb \
 	vf610m4-colibri.dtb \
 	vf610-cosmic.dtb \
+	vf610m4-cosmic.dtb \
 	vf610-twr.dtb
 dtb-$(CONFIG_ARCH_MXS) += \
 	imx23-evk.dtb \
diff --git a/arch/arm/boot/dts/vf610m4-cosmic.dts b/arch/arm/boot/dts/vf610m4-cosmic.dts
new file mode 100644
index 000000000000..8944a2d2054c
--- /dev/null
+++ b/arch/arm/boot/dts/vf610m4-cosmic.dts
@@ -0,0 +1,90 @@
+/*
+ * Device tree for Cosmic+ VF6xx Cortex-M4 support
+ *
+ * Copyright (C) 2015
+ *
+ * Based on vf610m4 Colibri
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
+ *     This file is distributed in the hope that it will be useful
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "vf610m4.dtsi"
+
+/ {
+	model = "VF610 Cortex-M4";
+	compatible = "fsl,vf610m4";
+};
+
+&gpio0 {
+	status = "disabled";
+};
+
+&gpio1 {
+	status = "disabled";
+};
+
+&gpio2 {
+	status = "disabled";
+};
+
+&gpio3 {
+	status = "disabled";
+};
+
+&gpio4 {
+	status = "disabled";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	status = "okay";
+};
+
+&iomuxc {
+	vf610-cosmic {
+		pinctrl_uart3: uart3grp {
+			fsl,pins = <
+				VF610_PAD_PTA20__UART3_TX		0x21a2
+				VF610_PAD_PTA21__UART3_RX		0x21a1
+			>;
+		};
+	};
+};
-- 
2.5.1
