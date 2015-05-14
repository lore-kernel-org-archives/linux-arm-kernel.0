From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Fri, 15 May 2015 01:18:53 +0800
Subject: [PATCH 7/7] arm: dts: imx6sx: enable snvs power key
In-Reply-To: <1431623933-3473-1-git-send-email-Frank.Li@freescale.com>
References: <1431623933-3473-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1431623933-3473-8-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

enable snvs ONOFF power key support

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 7bc5b20..24041d7 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -674,6 +674,13 @@
 					compatible = "fsl,sec-v4.0-poweroff";
 					status = "disabled";
 				};
+
+				snvs_pwrkey: snvs-powerkey {
+					compatible = "fsl,sec-v4.0-pwrkey";
+					interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+					linux,keycode = <116>; /* KEY_POWER */
+					wakeup;
+				};
 			};
 
 			epit1: epit at 020d0000 {
-- 
1.9.1
