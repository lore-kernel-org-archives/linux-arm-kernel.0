From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Wed, 27 May 2015 00:26:02 +0800
Subject: [PATCH v5 6/6] ARM: dts: imx6sx: enable snvs power key
In-Reply-To: <1432657562-5592-1-git-send-email-Frank.Li@freescale.com>
References: <1432657562-5592-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1432657562-5592-7-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

enable snvs ONOFF power key support

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index f8f0819..e391d63 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -8,6 +8,7 @@
 
 #include <dt-bindings/clock/imx6sx-clock.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include "imx6sx-pinfunc.h"
 #include "skeleton.dtsi"
@@ -679,6 +680,14 @@
 					mask = <0x60>;
 					status = "disabled";
 				};
+
+				snvs_pwrkey: snvs-powerkey {
+					compatible = "fsl,sec-v4.0-pwrkey";
+					regmap = <&snvs>;
+					interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+					linux,keycode = <KEY_POWER>;
+					wakeup;
+				};
 			};
 
 			epit1: epit at 020d0000 {
-- 
1.9.1
