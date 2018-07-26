From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Thu, 26 Jul 2018 13:05:21 -0300
Subject: [PATCH 1/2] ARM: dts: imx51-babbage: Add MC13892 ADC support
Message-ID: <1532621122-22013-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MC13892 Analog-to-Digital input pins (ADIN5-7) are exposed on the
imx51-babbage board.

Pass the "fsl,mc13xxx-uses-adc" property so that the MC13892 ADC
block can work.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx51-babbage.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index ba60b0c..35ee1b4 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -204,6 +204,7 @@
 		reg = <0>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
+		fsl,mc13xxx-uses-adc;
 		fsl,mc13xxx-uses-rtc;
 
 		regulators {
-- 
2.7.4
