From: uwe@kleine-koenig.org (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sun, 10 Jul 2016 12:07:46 +0200
Subject: [PATCH 6/6] ARM: dts: imx6-wandboard: substitute NO_PAD_CTL by the
 respective reset value
In-Reply-To: <1468145266-7567-1-git-send-email-uwe@kleine-koenig.org>
References: <1468145266-7567-1-git-send-email-uwe@kleine-koenig.org>
Message-ID: <1468145266-7567-7-git-send-email-uwe@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When 0x80000000 (aka NO_PAD_CTL) is used as pad config value, the
SW_PAD_CTL register isn't modified. Instead be more explicit here
and specify the reset default value.

If the machines don't depend on bootloader modifications to these
registers (and the tables in the reference manual are right) this commit
doesn't result in different behaviour of the affected machines.

Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
---
 arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi | 16 ++++++++--------
 arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi | 18 +++++++++---------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi
index d92c5a4f07d9..73f31ede9aba 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi
@@ -17,17 +17,17 @@
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x130b0		/* GPIO_0_CLKO */
-			MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x80000000	/* uSDHC1 CD */
-			MX6QDL_PAD_EIM_DA9__GPIO3_IO09		0x80000000	/* uSDHC3 CD */
+			MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x1b0b0		/* uSDHC1 CD */
+			MX6QDL_PAD_EIM_DA9__GPIO3_IO09		0x0b0b1		/* uSDHC3 CD */
 			MX6QDL_PAD_EIM_EB1__GPIO2_IO29		0x0f0b0		/* WL_REF_ON */
 			MX6QDL_PAD_EIM_A25__GPIO5_IO02		0x0f0b0		/* WL_RST_N */
 			MX6QDL_PAD_ENET_RXD1__GPIO1_IO26	0x000b0		/* WL_REG_ON */
-			MX6QDL_PAD_ENET_TXD1__GPIO1_IO29	0x80000000	/* WL_HOST_WAKE */
-			MX6QDL_PAD_ENET_TXD0__GPIO1_IO30	0x80000000	/* WL_WAKE */
-			MX6QDL_PAD_EIM_D29__GPIO3_IO29		0x80000000	/* RGMII_nRST */
-			MX6QDL_PAD_EIM_DA13__GPIO3_IO13		0x80000000	/* BT_ON */
-			MX6QDL_PAD_EIM_DA14__GPIO3_IO14		0x80000000	/* BT_WAKE */
-			MX6QDL_PAD_EIM_DA15__GPIO3_IO15		0x80000000	/* BT_HOST_WAKE */				
+			MX6QDL_PAD_ENET_TXD1__GPIO1_IO29	0x1b0b0		/* WL_HOST_WAKE */
+			MX6QDL_PAD_ENET_TXD0__GPIO1_IO30	0x1b0b0		/* WL_WAKE */
+			MX6QDL_PAD_EIM_D29__GPIO3_IO29		0x1b0b0		/* RGMII_nRST */
+			MX6QDL_PAD_EIM_DA13__GPIO3_IO13		0x0b0b1		/* BT_ON */
+			MX6QDL_PAD_EIM_DA14__GPIO3_IO14		0x0b0b1		/* BT_WAKE */
+			MX6QDL_PAD_EIM_DA15__GPIO3_IO15		0x0b0b1		/* BT_HOST_WAKE */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi
index ca4bfb2aa218..8a76601e931a 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi
@@ -1,4 +1,4 @@
-/*
+	/*
  * Copyright 2013 Freescale Semiconductor, Inc.
  *
  * Author: Fabio Estevam <fabio.estevam@freescale.com>
@@ -17,17 +17,17 @@
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x130b0		/* GPIO_0_CLKO */
-			MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x80000000	/* uSDHC1 CD */
-			MX6QDL_PAD_EIM_DA9__GPIO3_IO09		0x80000000	/* uSDHC3 CD */
+			MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x1b0b0		/* uSDHC1 CD */
+			MX6QDL_PAD_EIM_DA9__GPIO3_IO09		0x0b0b1		/* uSDHC3 CD */
 			MX6QDL_PAD_CSI0_DAT14__GPIO6_IO00	0x0f0b0		/* WIFI_ON (reset, active low) */
 			MX6QDL_PAD_ENET_RXD1__GPIO1_IO26	0x000b0		/* WL_REG_ON (unused) */
-			MX6QDL_PAD_ENET_TXD1__GPIO1_IO29	0x80000000	/* WL_HOST_WAKE, input */
+			MX6QDL_PAD_ENET_TXD1__GPIO1_IO29	0x1b0b0		/* WL_HOST_WAKE, input */
 			MX6QDL_PAD_CSI0_DAT13__GPIO5_IO31	0x0f0b0		/* GPIO5_IO31 (Wifi Power Enable) */
-			MX6QDL_PAD_ENET_TXD0__GPIO1_IO30	0x80000000	/* WL_WAKE (unused) */
-			MX6QDL_PAD_CSI0_VSYNC__GPIO5_IO21	0x80000000	/* BT_ON */
-			MX6QDL_PAD_CSI0_DAT12__GPIO5_IO30	0x80000000	/* BT_WAKE */
-			MX6QDL_PAD_CSI0_DATA_EN__GPIO5_IO20	0x80000000	/* BT_HOST_WAKE */
-			MX6QDL_PAD_EIM_D29__GPIO3_IO29		0x80000000	/* RGMII_nRST */
+			MX6QDL_PAD_ENET_TXD0__GPIO1_IO30	0x1b0b0		/* WL_WAKE (unused) */
+			MX6QDL_PAD_CSI0_VSYNC__GPIO5_IO21	0x1b0b0		/* BT_ON */
+			MX6QDL_PAD_CSI0_DAT12__GPIO5_IO30	0x1b0b0		/* BT_WAKE */
+			MX6QDL_PAD_CSI0_DATA_EN__GPIO5_IO20	0x1b0b0		/* BT_HOST_WAKE */
+			MX6QDL_PAD_EIM_D29__GPIO3_IO29		0x1b0b0		/* RGMII_nRST */
 		>;
 	};
 };
-- 
2.8.1
