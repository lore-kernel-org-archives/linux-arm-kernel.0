From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Wed, 13 May 2015 00:50:38 +0800
Subject: [PATCH 3/3] arm: dts: imx6sx: enable snvs power key
In-Reply-To: <1431449438-19460-1-git-send-email-Frank.Li@freescale.com>
References: <1431449438-19460-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1431449438-19460-3-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

enable snvs ONOFF power key support

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 708175d..1350d2e 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -680,6 +680,14 @@
 				};
 			};
 
+			snvs-pwrkey at 0x020cc000 {
+				compatible = "fsl,imx6sx-snvs-pwrkey";
+				reg = <0x020cc000 0x4000>;
+				interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+				fsl,keycode = <116>; /* KEY_POWER */
+				fsl,wakeup;
+			};
+
 			epit1: epit at 020d0000 {
 				reg = <0x020d0000 0x4000>;
 				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.9.1
