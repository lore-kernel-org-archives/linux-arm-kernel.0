From: woogyom.kim@gmail.com (Milo Kim)
Date: Wed,  4 Jan 2017 16:04:36 +0900
Subject: [PATCH resend v4 2/3] ARM: dts: imx6: Support Savageboard dual
Message-ID: <20170104070436.3425-1-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Common savageboard DT file is used for board support.
Add the vendor name and specify the dtb file for i.MX6Q build.

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 arch/arm/boot/dts/Makefile                         |  1 +
 arch/arm/boot/dts/imx6dl-savageboard.dts           | 51 ++++++++++++++++++++++
 3 files changed, 53 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-savageboard.dts

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 16d3b5e7f5d1..552b63651ab9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -227,6 +227,7 @@ pine64	Pine64
 pixcir  PIXCIR MICROELECTRONICS Co., Ltd
 plathome	Plat'Home Co., Ltd.
 plda	PLDA
+poslab	Poslab Technology Co., Ltd.
 powervr	PowerVR (deprecated, use img)
 pulsedlight	PulsedLight, Inc
 qca	Qualcomm Atheros, Inc.
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index cccdbcb557b6..fb7f904a5235 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -357,6 +357,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-sabreauto.dtb \
 	imx6dl-sabrelite.dtb \
 	imx6dl-sabresd.dtb \
+	imx6dl-savageboard.dtb \
 	imx6dl-ts4900.dtb \
 	imx6dl-tx6dl-comtft.dtb \
 	imx6dl-tx6s-8034.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-savageboard.dts b/arch/arm/boot/dts/imx6dl-savageboard.dts
new file mode 100644
index 000000000000..b95469c520a4
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-savageboard.dts
@@ -0,0 +1,51 @@
+/*
+ * Copyright (C) 2017 Milo Kim <woogyom.kim@gmail.com>
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
+#include "imx6dl.dtsi"
+#include "imx6qdl-savageboard.dtsi"
+
+/ {
+	model = "Poslab SavageBoard Dual";
+	compatible = "poslab,imx6dl-savageboard", "fsl,imx6dl";
+};
-- 
2.11.0
