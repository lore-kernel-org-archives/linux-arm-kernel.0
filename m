From: haibo.chen@freescale.com (Haibo Chen)
Date: Mon, 27 Jul 2015 19:26:47 +0800
Subject: [PATCH 5/5] ARM: dts: imx6ul-14x14-evk.dts: add tsc support
In-Reply-To: <1437996407-27266-1-git-send-email-haibo.chen@freescale.com>
References: <1437996407-27266-1-git-send-email-haibo.chen@freescale.com>
Message-ID: <1437996407-27266-6-git-send-email-haibo.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add touch screen surpport for i.MX6UL-EVK board.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 arch/arm/boot/dts/imx6ul-14x14-evk.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
index 61b41ee..323d32d 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
@@ -44,6 +44,15 @@
 	soc-supply = <&reg_soc>;
 };
 
+&tsc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_tsc>;
+	status = "okay";
+	xnur-gpio = <&gpio1 3 0>;
+	measure_delay_time = <0xffff>;
+	pre_charge_time = <0xfff>;
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
@@ -212,6 +221,15 @@
 		>;
 	};
 
+	pinctrl_tsc: tscgrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01		0xb0
+			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02		0xb0
+			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03		0xb0
+			MX6UL_PAD_GPIO1_IO04__GPIO1_IO04		0xb0
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX 0x1b0b1
-- 
1.9.1
