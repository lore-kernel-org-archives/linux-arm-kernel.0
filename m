From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Wed, 29 Mar 2017 10:45:23 +0200
Subject: [REPOST PATCH] ARM: dts: imx6qp-nitrogen6_som2: add Quad Plus variant
 of the SOM
In-Reply-To: <20170327160601.12871-1-gary.bisson@boundarydevices.com>
References: <20170327160601.12871-1-gary.bisson@boundarydevices.com>
Message-ID: <20170329084523.8065-1-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

https://boundarydevices.com/product/nit6x-som-v2/

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
Hi,

This is just a re-post to LAKML as suggested by Shawn [1].

Also include the Review tag from Fabio [2].

Regards,
Gary

[1] http://www.spinics.net/lists/devicetree/msg170732.html
[2] http://www.spinics.net/lists/devicetree/msg170354.html
---
 arch/arm/boot/dts/Makefile                  |  1 +
 arch/arm/boot/dts/imx6qp-nitrogen6_som2.dts | 55 +++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6qp-nitrogen6_som2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 011808490fed..6190afe94371 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -426,6 +426,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-wandboard.dtb \
 	imx6q-wandboard-revb1.dtb \
 	imx6qp-nitrogen6_max.dtb \
+	imx6qp-nitrogen6_som2.dtb \
 	imx6qp-sabreauto.dtb \
 	imx6qp-sabresd.dtb
 dtb-$(CONFIG_SOC_IMX6SL) += \
diff --git a/arch/arm/boot/dts/imx6qp-nitrogen6_som2.dts b/arch/arm/boot/dts/imx6qp-nitrogen6_som2.dts
new file mode 100644
index 000000000000..011726c836cd
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qp-nitrogen6_som2.dts
@@ -0,0 +1,55 @@
+/*
+ * Copyright 2017 Boundary Devices, Inc.
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
+#include "imx6qdl-nitrogen6_som2.dtsi"
+
+/ {
+	model = "Boundary Devices i.MX6 Quad Plus Nitrogen6_SOM2 Board";
+	compatible = "boundary,imx6qp-nitrogen6_som2", "fsl,imx6qp";
+};
+
+&sata {
+	status = "okay";
+};
-- 
2.11.0
