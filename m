From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Fri, 13 Jul 2018 10:30:04 -0700
Subject: [PATCH v2 1/2] ARM: dts: imx51-zii-scu3-esb: Add switch IRQ line
 pinumx config
In-Reply-To: <20180713173005.19552-1-andrew.smirnov@gmail.com>
References: <20180713173005.19552-1-andrew.smirnov@gmail.com>
Message-ID: <20180713173005.19552-2-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of relying on default values, configure PAD_AUD3_BB_CK to be a
GPIO explicitly. While at, it change the pad configuration to enable
a 100K pull-down (the pin is used as IRQ_TYPE_LEVEL_HIGH).

Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: cphealy at gmail.com
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/imx51-zii-scu3-esb.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-zii-scu3-esb.dts b/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
index 2941a92d40f1..0bb42c00d72b 100644
--- a/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
+++ b/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
@@ -221,6 +221,8 @@
 			interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_switch>;
 
 			ports {
 				#address-cells = <1>;
@@ -426,6 +428,12 @@
 		>;
 	};
 
+	pinctrl_switch: switchgrp {
+		fsl,pins = <
+			MX51_PAD_AUD3_BB_CK__GPIO4_20		0xc5
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX51_PAD_UART1_RXD__UART1_RXD		0x1c5
-- 
2.17.1
