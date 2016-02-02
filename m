From: ping.bai@nxp.com (Bai Ping)
Date: Tue, 2 Feb 2016 18:01:36 +0800
Subject: [PATCH V3 3/5] ARM: dts: imx: Add basic dts support for
 imx6qp-sabreauto
In-Reply-To: <1454407298-15545-1-git-send-email-ping.bai@nxp.com>
References: <1454407298-15545-1-git-send-email-ping.bai@nxp.com>
Message-ID: <1454407298-15545-3-git-send-email-ping.bai@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds basic dts file for i.MX6QP-Sbreauto board.

Signed-off-by: Bai Ping <ping.bai@nxp.com>
---

change for V3:
-- correct the dts list in alphabet order
-- update the copyright header for double license

 arch/arm/boot/dts/Makefile             |  3 +-
 arch/arm/boot/dts/imx6qp-sabreauto.dts | 93 ++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx6qp-sabreauto.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index c4f42a78..3801cbd 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -352,7 +352,8 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-tx6q-1110.dtb \
 	imx6q-udoo.dtb \
 	imx6q-wandboard.dtb \
-	imx6q-wandboard-revb1.dtb
+	imx6q-wandboard-revb1.dtb \
+	imx6qp-sabreauto.dtb
 dtb-$(CONFIG_SOC_IMX6SL) += \
 	imx6sl-evk.dtb \
 	imx6sl-warp.dtb
diff --git a/arch/arm/boot/dts/imx6qp-sabreauto.dts b/arch/arm/boot/dts/imx6qp-sabreauto.dts
new file mode 100644
index 0000000..5ce3840
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qp-sabreauto.dts
@@ -0,0 +1,93 @@
+/*
+ * Copyright 2016 Freescale Semiconductor, Inc.
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
+#include "imx6qdl-sabreauto.dtsi"
+
+/ {
+	model = "Freescale i.MX6 Quad Plus SABRE Automotive Board";
+	compatible = "fsl,imx6qp-sabreauto", "fsl,imx6qp";
+};
+
+&i2c2 {
+	max7322: gpio at 68 {
+		compatible = "maxim,max7322";
+		reg = <0x68>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&iomuxc {
+	imx6qdl-sabreauto {
+		pinctrl_enet: enetgrp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL1__ENET_MDIO          0x1b0b0
+				MX6QDL_PAD_KEY_COL2__ENET_MDC           0x1b0b0
+				MX6QDL_PAD_RGMII_TXC__RGMII_TXC         0x1b018
+				MX6QDL_PAD_RGMII_TD0__RGMII_TD0         0x1b018
+				MX6QDL_PAD_RGMII_TD1__RGMII_TD1         0x1b018
+				MX6QDL_PAD_RGMII_TD2__RGMII_TD2         0x1b018
+				MX6QDL_PAD_RGMII_TD3__RGMII_TD3         0x1b018
+				MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL   0x1b018
+				MX6QDL_PAD_RGMII_RXC__RGMII_RXC         0x1b018
+				MX6QDL_PAD_RGMII_RD0__RGMII_RD0         0x1b018
+				MX6QDL_PAD_RGMII_RD1__RGMII_RD1         0x1b018
+				MX6QDL_PAD_RGMII_RD2__RGMII_RD2         0x1b018
+				MX6QDL_PAD_RGMII_RD3__RGMII_RD3         0x1b018
+				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL   0x1b018
+				MX6QDL_PAD_GPIO_16__ENET_REF_CLK        0x4001b0a8
+				MX6QDL_PAD_GPIO_6__ENET_IRQ		0x000b1
+			>;
+		};
+	};
+};
+
+&pcie {
+	status = "disabled";
+};
+
+&vgen3_reg {
+	regulator-always-on;
+};
-- 
1.9.1
