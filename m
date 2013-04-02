From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 2 Apr 2013 22:31:19 +0800
Subject: [PATCH 6/6] ARM: dts: imx: add initial imx6dl-sabreauto support
In-Reply-To: <1364913079-26039-1-git-send-email-shawn.guo@linaro.org>
References: <1364913079-26039-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364913079-26039-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial imx6dl-sabreauto support based on the common stuff already
in imx6qdl-sabreauto.dtsip.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/Makefile              |    1 +
 arch/arm/boot/dts/imx6dl-sabreauto.dtsp |   31 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6dl.dtsip          |   29 +++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-sabreauto.dtsp

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 38d19b0..5345ac1 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -98,6 +98,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx53-mba53.dtb \
 	imx53-qsb.dtb \
 	imx53-smd.dtb \
+	imx6dl-sabreauto.dtb \
 	imx6dl-sabresd.dtb \
 	imx6q-arm2.dtb \
 	imx6q-sabreauto.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-sabreauto.dtsp b/arch/arm/boot/dts/imx6dl-sabreauto.dtsp
new file mode 100644
index 0000000..53033be
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-sabreauto.dtsp
@@ -0,0 +1,31 @@
+/*
+ * Copyright (C) 2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+
+#include "imx6dl.dtsip"
+#include "imx6qdl-sabreauto.dtsip"
+
+/ {
+	model = "Freescale i.MX6 DualLite/Solo SABRE Automotive Board";
+	compatible = "fsl,imx6dl-sabreauto", "fsl,imx6dl";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	hog {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				MX6DL_PAD_NANDF_CS2__GPIO6_IO15 0x80000000
+				MX6DL_PAD_SD2_DAT2__GPIO1_IO13  0x80000000
+			>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx6dl.dtsip b/arch/arm/boot/dts/imx6dl.dtsip
index b9112677..951ba53 100644
--- a/arch/arm/boot/dts/imx6dl.dtsip
+++ b/arch/arm/boot/dts/imx6dl.dtsip
@@ -56,6 +56,26 @@
 							MX6DL_PAD_GPIO_16__ENET_REF_CLK      0x4001b0a8
 						>;
 					};
+
+					pinctrl_enet_2: enetgrp-2 {
+						fsl,pins = <
+							MX6DL_PAD_KEY_COL1__ENET_MDIO        0x1b0b0
+							MX6DL_PAD_KEY_COL2__ENET_MDC         0x1b0b0
+							MX6DL_PAD_RGMII_TXC__RGMII_TXC       0x1b0b0
+							MX6DL_PAD_RGMII_TD0__RGMII_TD0       0x1b0b0
+							MX6DL_PAD_RGMII_TD1__RGMII_TD1       0x1b0b0
+							MX6DL_PAD_RGMII_TD2__RGMII_TD2       0x1b0b0
+							MX6DL_PAD_RGMII_TD3__RGMII_TD3       0x1b0b0
+							MX6DL_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x1b0b0
+							MX6DL_PAD_ENET_REF_CLK__ENET_TX_CLK  0x1b0b0
+							MX6DL_PAD_RGMII_RXC__RGMII_RXC       0x1b0b0
+							MX6DL_PAD_RGMII_RD0__RGMII_RD0       0x1b0b0
+							MX6DL_PAD_RGMII_RD1__RGMII_RD1       0x1b0b0
+							MX6DL_PAD_RGMII_RD2__RGMII_RD2       0x1b0b0
+							MX6DL_PAD_RGMII_RD3__RGMII_RD3       0x1b0b0
+							MX6DL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
+						>;
+					};
 				};
 
 				uart1 {
@@ -67,6 +87,15 @@
 					};
 				};
 
+				uart4 {
+					pinctrl_uart4_1: uart4grp-1 {
+						fsl,pins = <
+							MX6DL_PAD_KEY_COL0__UART4_TX_DATA 0x1b0b1
+							MX6DL_PAD_KEY_ROW0__UART4_RX_DATA 0x1b0b1
+						>;
+					};
+				};
+
 				usbotg {
 					pinctrl_usbotg_2: usbotggrp-2 {
 						fsl,pins = <
-- 
1.7.9.5
