From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu,  7 Aug 2014 21:52:38 +0200
Subject: [PATCH 1/3] ARM: dts: imx25, remove imx35-sdma compatible
Message-ID: <1407441160-2011-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The preloaded script addresses on imx25 and imx35 are different, so
imx25 is not compatible with imx35-sdma unless a custom firmware is
loaded.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx25.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index c1740396b2c9..4d40e550d701 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -453,7 +453,7 @@
 			};
 
 			sdma: sdma at 53fd4000 {
-				compatible = "fsl,imx25-sdma", "fsl,imx35-sdma";
+				compatible = "fsl,imx25-sdma";
 				reg = <0x53fd4000 0x4000>;
 				clocks = <&clks 112>, <&clks 68>;
 				clock-names = "ipg", "ahb";
-- 
2.0.1
