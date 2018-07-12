From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Wed, 11 Jul 2018 19:33:36 -0700
Subject: [PATCH 1/2] ARM: dts: imx51-zii-scu3-esb: Add switch IRQ line pinumx
 config
In-Reply-To: <20180712023337.30112-1-andrew.smirnov@gmail.com>
References: <20180712023337.30112-1-andrew.smirnov@gmail.com>
Message-ID: <20180712023337.30112-2-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT code to explicitly configure PAD_AUD3_BB_CK and avoid relying
on defaults.

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
