From: jagan@openedev.com (Jagan Teki)
Date: Mon,  2 Jan 2017 14:40:18 +0100
Subject: [PATCH v2 1/3] ARM: dts: imx6dl: Add Engicam i.CoreM6 DualLite/Solo
 RQS initial support
Message-ID: <1483364420-10012-1-git-send-email-jagan@openedev.com>
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
http://www.engicam.com/en/products/embedded/som/standard/i-core-rqs-m6s-dl-d-q

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- Update correct licenece notes

 arch/arm/boot/dts/Makefile             |  1 +
 arch/arm/boot/dts/imx6dl-icore-rqs.dts | 51 ++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-icore-rqs.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index cccdbcb..51f8dae 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -349,6 +349,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-gw553x.dtb \
 	imx6dl-hummingboard.dtb \
 	imx6dl-icore.dtb \
+	imx6dl-icore-rqs.dtb \
 	imx6dl-nit6xlite.dtb \
 	imx6dl-nitrogen6x.dtb \
 	imx6dl-phytec-pbab01.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-icore-rqs.dts b/arch/arm/boot/dts/imx6dl-icore-rqs.dts
new file mode 100644
index 0000000..cf42c2f
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-icore-rqs.dts
@@ -0,0 +1,51 @@
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
+
+#include "imx6q.dtsi"
+#include "imx6qdl-icore-rqs.dtsi"
+
+/ {
+	model = "Engicam i.CoreM6 DualLite/Solo RQS Starter Kit";
+	compatible = "engicam,imx6-icore-rqs", "fsl,imx6dl";
+};
-- 
1.9.1
