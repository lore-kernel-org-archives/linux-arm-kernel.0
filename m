From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 24 Mar 2015 15:09:06 +0100
Subject: [PATCH 1/2] ARM: dts: imx25: Add #pwm-cells to pwm4
Message-ID: <1427206147-19365-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The property '#pwm-cells' is currently missing. It is not possible to
use pwm4 without this property.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx25.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index e4d3aecc4ed2..677f81d9dcd5 100644
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
2.1.4
