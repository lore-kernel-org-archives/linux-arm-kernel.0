From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 11 Oct 2017 13:50:34 +0200
Subject: [PATCH 11/12] ARM: dts: imx: add support for TX6QP
In-Reply-To: <1507722635-30801-1-git-send-email-LW@KARO-electronics.de>
References: <1507722635-30801-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1507722635-30801-12-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TX6QP-8037 is a Computer On Module manufactured by
  Ka-Ro electronics GmbH with the following characteristics:
  Processor    Freescale i.MX 6QuadPlus MCIMX6QP7, 1 GHz
  RAM          1GiB 64-bit DDR3 SDRAM
  ROM          4GB HiRel eMMC
  Power supply Single 3.3 to 5V
  Size         26mm SO-DIMM
  Temp. Range  -40?C to 105?C

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/Makefile              |  2 +
 arch/arm/boot/dts/imx6qp-tx6qp-8037.dts | 86 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qp-tx6qp-8137.dts | 90 +++++++++++++++++++++++++++++++++
 3 files changed, 178 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6qp-tx6qp-8037.dts
 create mode 100644 arch/arm/boot/dts/imx6qp-tx6qp-8137.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4b17f35..0672369 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -451,6 +451,8 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6qp-nitrogen6_som2.dtb \
 	imx6qp-sabreauto.dtb \
 	imx6qp-sabresd.dtb \
+	imx6qp-tx6qp-8037.dtb \
+	imx6qp-tx6qp-8137.dtb \
 	imx6qp-zii-rdu2.dtb
 dtb-$(CONFIG_SOC_IMX6SL) += \
 	imx6sl-evk.dtb \
diff --git a/arch/arm/boot/dts/imx6qp-tx6qp-8037.dts b/arch/arm/boot/dts/imx6qp-tx6qp-8037.dts
new file mode 100644
index 0000000..ffc0f2e
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qp-tx6qp-8037.dts
@@ -0,0 +1,86 @@
+/*
+ * Copyright 2017 Lothar Wa?mann <LW@KARO-electronics.de>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License
+ *     version 2 as published by the Free Software Foundation.
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
+#include "imx6qp.dtsi"
+#include "imx6qdl-tx6.dtsi"
+#include "imx6qdl-tx6-lcd.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TX6QP-8037 Module";
+	compatible = "karo,imx6qp-tx6qp", "fsl,imx6qp";
+};
+
+&ds1339 {
+	status = "disabled";
+};
+
+&gpmi {
+	status = "disabled";
+};
+
+&ipu2 {
+	status = "disabled";
+};
+
+&usdhc4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc4>;
+	bus-width = <4>;
+	non-removable;
+	no-1-8-v;
+	fsl,wp-controller;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_usdhc4: usdhc4grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_CMD__SD4_CMD		0x070b1
+			MX6QDL_PAD_SD4_CLK__SD4_CLK		0x070b1
+			MX6QDL_PAD_SD4_DAT0__SD4_DATA0		0x070b1
+			MX6QDL_PAD_SD4_DAT1__SD4_DATA1		0x070b1
+			MX6QDL_PAD_SD4_DAT2__SD4_DATA2		0x070b1
+			MX6QDL_PAD_SD4_DAT3__SD4_DATA3		0x070b1
+			MX6QDL_PAD_NANDF_ALE__SD4_RESET		0x0b0b1
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6qp-tx6qp-8137.dts b/arch/arm/boot/dts/imx6qp-tx6qp-8137.dts
new file mode 100644
index 0000000..dd494d5
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qp-tx6qp-8137.dts
@@ -0,0 +1,90 @@
+/*
+ * Copyright 2017 Lothar Wa?mann <LW@KARO-electronics.de>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License
+ *     version 2 as published by the Free Software Foundation.
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
+#include "imx6qp.dtsi"
+#include "imx6qdl-tx6.dtsi"
+#include "imx6qdl-tx6-lvds.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TX6QP-8137 Module";
+	compatible = "karo,imx6qp-tx6qp", "fsl,imx6qp";
+};
+
+&ds1339 {
+	status = "disabled";
+};
+
+&gpmi {
+	status = "disabled";
+};
+
+&ipu2 {
+	status = "disabled";
+};
+
+&sata {
+	status = "okay";
+};
+
+&usdhc4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc4>;
+	bus-width = <4>;
+	non-removable;
+	no-1-8-v;
+	fsl,wp-controller;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_usdhc4: usdhc4grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_CMD__SD4_CMD		0x070b1
+			MX6QDL_PAD_SD4_CLK__SD4_CLK		0x070b1
+			MX6QDL_PAD_SD4_DAT0__SD4_DATA0		0x070b1
+			MX6QDL_PAD_SD4_DAT1__SD4_DATA1		0x070b1
+			MX6QDL_PAD_SD4_DAT2__SD4_DATA2		0x070b1
+			MX6QDL_PAD_SD4_DAT3__SD4_DATA3		0x070b1
+			MX6QDL_PAD_NANDF_ALE__SD4_RESET		0x0b0b1
+		>;
+	};
+};
-- 
2.1.4
