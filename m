From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Fri, 13 Oct 2017 12:42:59 +0200
Subject: [PATCH 3/7] ARM: dts: imx6ul: add support for TXUL-8013
In-Reply-To: <1507891383-15452-1-git-send-email-LW@KARO-electronics.de>
References: <1507891383-15452-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1507891383-15452-4-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TXUL-8013 is a Computer On Module manufactured by
  Ka-Ro electronics GmbH with the following characteristics:
  Processor    Freescale i.MX 6ULL MCIMX6Y2, 528 MHz
  RAM          256MB 16-bit DDR3 SDRAM
  ROM          4GB eMMC
  Power supply Single 3.3 to 5V
  Size         26mm SO-DIMM
  Temp. Range  -40?C to 85?C

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/Makefile              |  3 +-
 arch/arm/boot/dts/imx6ull-txul-8013.dts | 69 +++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx6ull-txul-8013.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4b17f35..6d25253 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -475,7 +475,8 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-tx6ul-0010.dtb \
 	imx6ul-tx6ul-0011.dtb \
 	imx6ul-tx6ul-mainboard.dtb \
-	imx6ull-14x14-evk.dtb
+	imx6ull-14x14-evk.dtb \
+	imx6ull-txul-8013.dtb
 dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-cl-som-imx7.dtb \
 	imx7d-colibri-eval-v3.dtb \
diff --git a/arch/arm/boot/dts/imx6ull-txul-8013.dts b/arch/arm/boot/dts/imx6ull-txul-8013.dts
new file mode 100644
index 0000000..34af49b
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-txul-8013.dts
@@ -0,0 +1,69 @@
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
+#include "imx6ull.dtsi"
+#include "imx6ul-tx6ul.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TXUL-8013 Module";
+	compatible = "karo,imx6ull-txul", "fsl,imx6ull";
+
+	aliases {
+		/* make eMMC first mmc block device */
+		mmc0 = &usdhc2;
+		mmc1 = &usdhc1;
+	};
+};
+
+&gpmi {
+	status = "disabled";
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	bus-width = <4>;
+	no-1-8-v;
+	non-removable;
+	fsl,wp-controller;
+	status = "okay";
+};
-- 
2.1.4
