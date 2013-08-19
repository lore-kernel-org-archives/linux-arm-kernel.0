From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 19 Aug 2013 17:09:46 +0800
Subject: [PATCH] ARM: dts: imx6sl reuses imx6q sdma firmware
Message-ID: <1376903386-27771-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no imx6sl specific sdma firmware.  Instead, imx6sl reuses
imx6q sdma firmware.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6sl.dtsi |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index c46651e..9fec772 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -619,7 +619,8 @@
 					 <&clks IMX6SL_CLK_SDMA>;
 				clock-names = "ipg", "ahb";
 				#dma-cells = <3>;
-				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6sl.bin";
+				/* imx6sl reuses imx6q sdma firmware */
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6q.bin";
 			};
 
 			pxp: pxp at 020f0000 {
-- 
1.7.9.5
