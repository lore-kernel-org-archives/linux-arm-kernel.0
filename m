From: marco.franchi@nxp.com (Marco Franchi)
Date: Wed, 15 Mar 2017 13:43:58 -0300
Subject: [PATCH] ARM: dts: imx7d-sdb: Add thermo 2 Click Board support
Message-ID: <1489596238-31669-1-git-send-email-marco.franchi@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx7d-sdb has a mickro bus connector that can be connected to a
Dallas Semiconductor Thermo 2 click board (DS1825 one wire temperature sensor):

https://shop.mikroe.com/click/sensors/thermo-2

Add a new device tree file to describe such hardware.

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
 arch/arm/boot/dts/Makefile             |  1 +
 arch/arm/boot/dts/imx7d-sdb-ds1825.dts | 60 ++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx7d-sdb-ds1825.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7009856..d90c6c2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -458,6 +458,7 @@ dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-nitrogen7.dtb \
 	imx7d-sbc-imx7.dtb \
 	imx7d-sdb.dtb \
+	imx7d-sdb-ds1825.dtb \
 	imx7d-sdb-sht11.dtb \
 	imx7s-colibri-eval-v3.dtb \
 	imx7s-warp.dtb
diff --git a/arch/arm/boot/dts/imx7d-sdb-ds1825.dts b/arch/arm/boot/dts/imx7d-sdb-ds1825.dts
new file mode 100644
index 0000000..bd1cd20
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-sdb-ds1825.dts
@@ -0,0 +1,60 @@
+/*
+ * Copyright (C) 2015 Freescale Semiconductor, Inc.
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
+#include "imx7d-sdb.dts"
+
+/ {
+	onewire_device {
+		compatible = "w1-gpio";
+		gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_w1>;
+	};
+};
+
+&iomuxc_lpsr {
+	pinctrl_w1: w1grp {
+    	fsl,pins = <
+			MX7D_PAD_LPSR_GPIO1_IO02__GPIO1_IO2		0x14
+		>;
+    };
+};
-- 
2.7.4
