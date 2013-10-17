From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 17 Oct 2013 15:03:16 +0200
Subject: [PATCH] ARM: imx27: add missing #pwm-cells property
Message-ID: <1382014996-18084-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pwm-node is missing its #pwm-cells property. The pwm-framework will
complain about this.

Add the missing property.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/imx27.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index b7a1c6d..826231e 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -123,6 +123,7 @@
 			};
 
 			pwm: pwm at 10006000 {
+				#pwm-cells = <2>;
 				compatible = "fsl,imx27-pwm";
 				reg = <0x10006000 0x1000>;
 				interrupts = <23>;
-- 
1.8.4.rc3
