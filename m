From: marex@denx.de (Marek Vasut)
Date: Mon,  7 Jan 2013 15:27:00 +0100
Subject: [PATCH] ARM: mx5: Fix MX53 flexcan2 clock
Message-ID: <1357568820-15426-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The second FlexCAN port uses different clock than the first one, configure
correct clock to prevent hanging of the system during bringing up of the port.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx53.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 5b59763..abe0f0b 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -614,7 +614,7 @@
 				compatible = "fsl,imx53-flexcan", "fsl,p1010-flexcan";
 				reg = <0x53fcc000 0x4000>;
 				interrupts = <83>;
-				clocks = <&clks 158>, <&clks 157>;
+				clocks = <&clks 87>, <&clks 86>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
-- 
1.7.10.4
