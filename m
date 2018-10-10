From: kueffner.markus@gmail.com (Markus Kueffner)
Date: Wed, 10 Oct 2018 10:19:04 +0200
Subject: [PATCH] ARM: dts: imx6qdl-udoo: Add Pincfgs for UART4
In-Reply-To: <CAOMZO5BqL5Tfd0+KmN2DiJdoWLSYWSWyppw8qdrb-G_by_68Tw@mail.gmail.com>
References: <1538663639-3427-1-git-send-email-kueffner.markus@gmail.com>
 <CAOMZO5BqL5Tfd0+KmN2DiJdoWLSYWSWyppw8qdrb-G_by_68Tw@mail.gmail.com>
Message-ID: <20181010081904.GA23397@armhf-buildhost.asgard.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From b25738867245688e0a1eafeb78379efc6a73b66e Mon Sep 17 00:00:00 2001
From: Markus Kueffner <kueffner.markus@gmail.com>
Date: Wed, 10 Oct 2018 08:32:09 +0200
Subject: [PATCH v2] ARM: dts: imx6qdl-udoo: Add Pincfgs for UART4

Add Pincfgs for UART4 to enable Communication with the onboard SAM3X

Signed-off-by: Markus Kueffner <kueffner.markus@gmail.com>
---
Changes in v2:
  - Removed // style Comment.

 arch/arm/boot/dts/imx6qdl-udoo.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
index 4f27861..40d1b0d 100644
--- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
@@ -195,6 +195,13 @@
 			>;
 		};
 
+		pinctrl_uart4: uart4grp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL0__UART4_TX_DATA	0x1b0b1
+				MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA	0x1b0b1
+			>;
+		};
+
 		pinctrl_usbh: usbhgrp {
 			fsl,pins = <
 				MX6QDL_PAD_GPIO_17__GPIO7_IO12 0x80000000
@@ -265,6 +272,12 @@
 	status = "okay";
 };
 
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	status = "okay";
+};
+
 &usbh1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usbh>;
-- 
2.1.4
