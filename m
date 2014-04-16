From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed, 16 Apr 2014 11:24:52 +0400
Subject: [PATCH 3/8] ARM: dts: imx51-babbage: Add missing pingroup for PMIC
In-Reply-To: <1397633097-1640-1-git-send-email-shc_work@mail.ru>
References: <1397633097-1640-1-git-send-email-shc_work@mail.ru>
Message-ID: <1397633097-1640-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds missing pin definition for PMIC IRQ GPIO.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51-babbage.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index ad143eb..1652f6a 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -199,6 +199,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "fsl,mc13892";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
 		spi-max-frequency = <6000000>;
 		spi-cs-high;
 		reg = <0>;
@@ -490,6 +492,12 @@
 			>;
 		};
 
+		pinctrl_pmic: pmicgrp {
+			fsl,pins = <
+				MX51_PAD_GPIO1_8__GPIO1_8		0xe5 /* IRQ */
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX51_PAD_UART1_RXD__UART1_RXD		0x1c5
-- 
1.8.3.2
