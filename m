From: festevam@gmail.com (Fabio Estevam)
Date: Fri,  5 Dec 2014 16:16:07 -0200
Subject: [PATCH] ARM: dts: imx25: Fix the SPI1 clocks
Message-ID: <1417803367-23448-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

>From Documentation/devicetree/bindings/clock/imx25-clock.txt:

	cspi1_ipg		78
	cspi2_ipg		79
	cspi3_ipg		80

, so fix the SPI1 clocks accordingly to avoid a kernel hang when trying to
access SPI1.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx25.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 58d3c3c..d238676 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -162,7 +162,7 @@
 				#size-cells = <0>;
 				compatible = "fsl,imx25-cspi", "fsl,imx35-cspi";
 				reg = <0x43fa4000 0x4000>;
-				clocks = <&clks 62>, <&clks 62>;
+				clocks = <&clks 78>, <&clks 78>;
 				clock-names = "ipg", "per";
 				interrupts = <14>;
 				status = "disabled";
-- 
1.9.1
