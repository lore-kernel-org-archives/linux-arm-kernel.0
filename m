From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 22 Apr 2015 09:40:30 -0300
Subject: [PATCH] ARM: dts: imx25: Add missing '#pwm-cells' property for pwm4
Message-ID: <1429706430-9495-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All pwm ports pass the '#pwm-cells' property, except pw4.

Fix it by passing '#pwm-cells' property for pwm4.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx25.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index e4d3aec..677f81d 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -428,6 +428,7 @@
 
 			pwm4: pwm at 53fc8000 {
 				compatible = "fsl,imx25-pwm", "fsl,imx27-pwm";
+				#pwm-cells = <2>;
 				reg = <0x53fc8000 0x4000>;
 				clocks = <&clks 108>, <&clks 52>;
 				clock-names = "ipg", "per";
-- 
1.9.1
