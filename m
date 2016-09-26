From: jteki@openedev.com (Jagan Teki)
Date: Tue, 27 Sep 2016 00:55:33 +0530
Subject: [PATCH v6 3/6] ARM: dts: imx6q: Add Engicam i.CoreM6 DualLite/Solo
 initial support
In-Reply-To: <1474917937-29336-1-git-send-email-jteki@openedev.com>
References: <1474917937-29336-1-git-send-email-jteki@openedev.com>
Message-ID: <1474917937-29336-3-git-send-email-jteki@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

i.CoreM6 DualLite/Solo modules are system on module solutions manufactured
by Engicam with following characteristics:
CPU           NXP i.MX6 DL, 800MHz
RAM           1GB, 32, 64 bit, DDR3-800/1066
NAND          SLC,512MB
Power supply  Single 5V
MAX LCD RES   FULLHD

and more info at
http://www.engicam.com/en/products/embedded/som/sodimm/i-core-m6s-dl-d-q

Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v6:
        - none
Changes for v5:
        - none
Changes for v4:
        - new patch
Changes for v3:
        - Use compatible as engicam,imx6-icore instead of fsl,imx6-icore
Changes for v2:
        - s/oaky/okay/g

 arch/arm/boot/dts/Makefile         |  1 +
 arch/arm/boot/dts/imx6dl-icore.dts | 59 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-icore.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 511510d..6175f44 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -333,6 +333,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-gw552x.dtb \
 	imx6dl-gw553x.dtb \
 	imx6dl-hummingboard.dtb \
+	imx6dl-icore.dtb \
 	imx6dl-nit6xlite.dtb \
 	imx6dl-nitrogen6x.dtb \
 	imx6dl-phytec-pbab01.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-icore.dts b/arch/arm/boot/dts/imx6dl-icore.dts
new file mode 100644
index 0000000..aec332c
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-icore.dts
@@ -0,0 +1,59 @@
+/*
+ * Copyright (C) 2016 Amarula Solutions B.V.
+ * Copyright (C) 2016 Engicam S.r.l.
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
+
+#include "imx6dl.dtsi"
+#include "imx6qdl-icore.dtsi"
+
+/ {
+	model = "Engicam i.CoreM6 DualLite/Solo Starter Kit";
+	compatible = "engicam,imx6-icore", "fsl,imx6dl";
+};
+
+&can1 {
+	status = "okay";
+};
+
+&can2 {
+	status = "okay";
+};
-- 
2.7.4
