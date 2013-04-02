From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 2 Apr 2013 22:31:18 +0800
Subject: [PATCH 5/6] ARM: dts: imx: add initial imx6dl-sabresd support
In-Reply-To: <1364913079-26039-1-git-send-email-shawn.guo@linaro.org>
References: <1364913079-26039-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364913079-26039-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial imx6dl-sabresd support based on the common stuff already in
imx6qdl-sabresd.dtsip.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/Makefile            |    1 +
 arch/arm/boot/dts/imx6dl-sabresd.dtsp |   35 ++++++++++++++
 arch/arm/boot/dts/imx6dl.dtsip        |   85 ++++++++++++++++++++++++++++++++-
 3 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-sabresd.dtsp

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0254495..38d19b0 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -98,6 +98,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx53-mba53.dtb \
 	imx53-qsb.dtb \
 	imx53-smd.dtb \
+	imx6dl-sabresd.dtb \
 	imx6q-arm2.dtb \
 	imx6q-sabreauto.dtb \
 	imx6q-sabrelite.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-sabresd.dtsp b/arch/arm/boot/dts/imx6dl-sabresd.dtsp
new file mode 100644
index 0000000..77ef55c
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-sabresd.dtsp
@@ -0,0 +1,35 @@
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
+#include "imx6qdl-sabresd.dtsip"
+
+/ {
+	model = "Freescale i.MX6 DualLite SABRE Smart Device Board";
+	compatible = "fsl,imx6dl-sabresd", "fsl,imx6dl";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	hog {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				MX6DL_PAD_GPIO_4__GPIO1_IO04   0x80000000
+				MX6DL_PAD_GPIO_5__GPIO1_IO05   0x80000000
+				MX6DL_PAD_NANDF_D0__GPIO2_IO00 0x80000000
+				MX6DL_PAD_NANDF_D1__GPIO2_IO01 0x80000000
+				MX6DL_PAD_NANDF_D2__GPIO2_IO02 0x80000000
+				MX6DL_PAD_NANDF_D3__GPIO2_IO03 0x80000000
+			>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx6dl.dtsip b/arch/arm/boot/dts/imx6dl.dtsip
index 63fafe2..b9112677 100644
--- a/arch/arm/boot/dts/imx6dl.dtsip
+++ b/arch/arm/boot/dts/imx6dl.dtsip
@@ -1,3 +1,4 @@
+
 /*
  * Copyright 2013 Freescale Semiconductor, Inc.
  *
@@ -7,7 +8,8 @@
  *
  */
 
-/include/ "imx6qdl.dtsi"
+#include "imx6qdl.dtsip"
+#include "imx6dl-pinfunc.h"
 
 / {
 	cpus {
@@ -29,6 +31,87 @@
 
 	soc {
 		aips1: aips-bus at 02000000 {
+			iomuxc: iomuxc at 020e0000 {
+				compatible = "fsl,imx6dl-iomuxc";
+				reg = <0x020e0000 0x4000>;
+
+				enet {
+					pinctrl_enet_1: enetgrp-1 {
+						fsl,pins = <
+							MX6DL_PAD_ENET_MDIO__ENET_MDIO       0x1b0b0
+							MX6DL_PAD_ENET_MDC__ENET_MDC         0x1b0b0
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
+							MX6DL_PAD_GPIO_16__ENET_REF_CLK      0x4001b0a8
+						>;
+					};
+				};
+
+				uart1 {
+					pinctrl_uart1_1: uart1grp-1 {
+						fsl,pins = <
+							MX6DL_PAD_CSI0_DAT10__UART1_TX_DATA 0x1b0b1
+							MX6DL_PAD_CSI0_DAT11__UART1_RX_DATA 0x1b0b1
+						>;
+					};
+				};
+
+				usbotg {
+					pinctrl_usbotg_2: usbotggrp-2 {
+						fsl,pins = <
+							MX6DL_PAD_ENET_RX_ER__USB_OTG_ID 0x17059
+						>;
+					};
+				};
+
+				usdhc2 {
+					pinctrl_usdhc2_1: usdhc2grp-1 {
+						fsl,pins = <
+							MX6DL_PAD_SD2_CMD__SD2_CMD    0x17059
+							MX6DL_PAD_SD2_CLK__SD2_CLK    0x10059
+							MX6DL_PAD_SD2_DAT0__SD2_DATA0 0x17059
+							MX6DL_PAD_SD2_DAT1__SD2_DATA1 0x17059
+							MX6DL_PAD_SD2_DAT2__SD2_DATA2 0x17059
+							MX6DL_PAD_SD2_DAT3__SD2_DATA3 0x17059
+							MX6DL_PAD_NANDF_D4__SD2_DATA4 0x17059
+							MX6DL_PAD_NANDF_D5__SD2_DATA5 0x17059
+							MX6DL_PAD_NANDF_D6__SD2_DATA6 0x17059
+							MX6DL_PAD_NANDF_D7__SD2_DATA7 0x17059
+						>;
+					};
+				};
+
+				usdhc3 {
+					pinctrl_usdhc3_1: usdhc3grp-1 {
+						fsl,pins = <
+							MX6DL_PAD_SD3_CMD__SD3_CMD    0x17059
+							MX6DL_PAD_SD3_CLK__SD3_CLK    0x10059
+							MX6DL_PAD_SD3_DAT0__SD3_DATA0 0x17059
+							MX6DL_PAD_SD3_DAT1__SD3_DATA1 0x17059
+							MX6DL_PAD_SD3_DAT2__SD3_DATA2 0x17059
+							MX6DL_PAD_SD3_DAT3__SD3_DATA3 0x17059
+							MX6DL_PAD_SD3_DAT4__SD3_DATA4 0x17059
+							MX6DL_PAD_SD3_DAT5__SD3_DATA5 0x17059
+							MX6DL_PAD_SD3_DAT6__SD3_DATA6 0x17059
+							MX6DL_PAD_SD3_DAT7__SD3_DATA7 0x17059
+						>;
+					};
+				};
+
+
+			};
+
 			pxp: pxp at 020f0000 {
 				reg = <0x020f0000 0x4000>;
 				interrupts = <0 98 0x04>;
-- 
1.7.9.5
