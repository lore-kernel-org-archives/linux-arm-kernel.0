From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 Jan 2017 10:09:22 +0100
Subject: [PATCH 2/4] ARM: dts: imx7d-sdp: Fix watchdog and pwm pinmux
In-Reply-To: <20170119090924.19636-1-s.hauer@pengutronix.de>
References: <20170119090924.19636-1-s.hauer@pengutronix.de>
Message-ID: <20170119090924.19636-3-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The watchdog pin and the pwm output pin are controlled by the
iomuxc_lpsr, not the regular iomux, so move the pins there.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 2f33c463cbce..84f35a6cbb30 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -502,12 +502,6 @@
 			>;
 		};
 
-		pinctrl_pwm1: pwm1grp {
-			fsl,pins = <
-				MX7D_PAD_GPIO1_IO01__PWM1_OUT		0x110b0
-			>;
-		};
-
 		pinctrl_tsc2046_pendown: tsc2046_pendown {
 			fsl,pins = <
 				MX7D_PAD_EPDC_BDR1__GPIO2_IO29		0x59
@@ -635,11 +629,19 @@
 				MX7D_PAD_SD3_STROBE__SD3_STROBE		0x1b
 			>;
 		};
-
-		pinctrl_wdog: wdoggrp {
-			fsl,pins = <
-				MX7D_PAD_GPIO1_IO00__WDOD1_WDOG_B	0x74
-			>;
-		};
 	};
 };
+
+&iomuxc_lpsr {
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO00__WDOD1_WDOG_B	0x74
+		>;
+	};
+
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO01__PWM1_OUT		0x110b0
+		>;
+	};
+};
\ No newline at end of file
-- 
2.11.0
