From: jagan@openedev.com (Jagan Teki)
Date: Mon, 20 Feb 2017 12:33:00 +0530
Subject: [PATCH 2/2] arm: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual OpenFrame
 Cap 10.1 initial support
In-Reply-To: <1487574180-5182-1-git-send-email-jagan@openedev.com>
References: <1487574180-5182-1-git-send-email-jagan@openedev.com>
Message-ID: <1487574180-5182-2-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

i.CoreM6 Quad/Dual OpenFrame modules are "system on modules plus
openframe display carriers" which are good solution for develop
user friendly graphic user interface.

General features:
CPU           NXP i.MX6Q rev1.2 at 792 MHz
RAM           1GB, 32, 64 bit, DDR3-800/1066
NAND          SLC,512MB
LVDS Display  TFT 10.1" industrial, 1280x800 resolution
Backlight     LED backlight, brightness 350 Cd/m2
Power supply  15 to 30 Vdc

Cc: Domenico Acri <domenico.acri@engicam.com>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/Makefile                |  1 +
 arch/arm/boot/dts/imx6q-icore-ofcap10.dts | 76 +++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-icore-ofcap10.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0118084..458ec09 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -398,6 +398,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-h100.dtb \
 	imx6q-hummingboard.dtb \
 	imx6q-icore.dtb \
+	imx6q-icore-ofcap10.dtb \
 	imx6q-icore-rqs.dtb \
 	imx6q-marsboard.dtb \
 	imx6q-mccmon6.dtb \
diff --git a/arch/arm/boot/dts/imx6q-icore-ofcap10.dts b/arch/arm/boot/dts/imx6q-icore-ofcap10.dts
new file mode 100644
index 0000000..70600e2
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-icore-ofcap10.dts
@@ -0,0 +1,76 @@
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
+#include "imx6qdl-icore.dtsi"
+
+/ {
+	model = "Engicam i.CoreM6 Quad/Dual OpenFrame Capacitive touch 10.1 Kit";
+	compatible = "engicam,imx6-icore", "fsl,imx6q";
+};
+
+&ldb {
+	status = "okay";
+
+	lvds-channel at 0 {
+		fsl,data-mapping = "spwg";
+		fsl,data-width = <24>;
+		status = "okay";
+
+		display-timings {
+                        native-mode = <&timing1>;
+                        timing1: hsd100pxn1 {
+                                clock-frequency = <60000000>;
+                                hactive = <1280>;
+                                vactive = <800>;
+                                hback-porch = <40>;
+                                hfront-porch = <40>;
+                                vback-porch = <10>;
+                                vfront-porch = <3>;
+                                hsync-len = <80>;
+                                vsync-len = <10>;
+                        };
+                };
+	};
+};
-- 
1.9.1
