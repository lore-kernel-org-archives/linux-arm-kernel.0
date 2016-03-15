From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Tue, 15 Mar 2016 11:30:22 +0100
Subject: [PATCH 5/9] ARM: dts: imx: add Boundary Devices Nitrogen6_MAX QP board
In-Reply-To: <1458037826-19375-1-git-send-email-gary.bisson@boundarydevices.com>
References: <1458037826-19375-1-git-send-email-gary.bisson@boundarydevices.com>
Message-ID: <1458037826-19375-6-git-send-email-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on i.MX6 Quad Plus with 4GB of RAM.

https://boundarydevices.com/product/nitrogen6max/

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
 arch/arm/boot/dts/Makefile                 |  1 +
 arch/arm/boot/dts/imx6qp-nitrogen6_max.dts | 55 ++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6qp-nitrogen6_max.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index fd67d8d..279ec61 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -356,6 +356,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-udoo.dtb \
 	imx6q-wandboard.dtb \
 	imx6q-wandboard-revb1.dtb \
+	imx6qp-nitrogen6_max.dtb \
 	imx6qp-sabreauto.dtb \
 	imx6qp-sabresd.dtb
 dtb-$(CONFIG_SOC_IMX6SL) += \
diff --git a/arch/arm/boot/dts/imx6qp-nitrogen6_max.dts b/arch/arm/boot/dts/imx6qp-nitrogen6_max.dts
new file mode 100644
index 0000000..2dee1d8
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qp-nitrogen6_max.dts
@@ -0,0 +1,55 @@
+/*
+ * Copyright 2016 Boundary Devices, Inc.
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
+
+#include "imx6qp.dtsi"
+#include "imx6qdl-nitrogen6_max.dtsi"
+
+/ {
+	model = "Boundary Devices i.MX6 Quad Plus Nitrogen6_MAX Board";
+	compatible = "boundary,imx6qp-nitrogen6_max", "fsl,imx6qp";
+};
+
+&sata {
+	status = "okay";
+};
-- 
2.7.0
