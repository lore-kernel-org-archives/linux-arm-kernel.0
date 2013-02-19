From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 19 Feb 2013 15:40:32 +0800
Subject: [PATCH] ARM: dts: imx53-mba53: fix fsl,pins for disp1-grp1
Message-ID: <1361259632-18334-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to fsl,imx53-pinctrl.txt, the pin number of DISP1_DAT_21
should be 545, while 543 is IPU_CSI0_D_3.  Along with the change,
one duplication of DISP1_DAT_0 in disp1-grp1 is removed.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx53-mba53.dts |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/imx53-mba53.dts
index e54fffd..468c0a1 100644
--- a/arch/arm/boot/dts/imx53-mba53.dts
+++ b/arch/arm/boot/dts/imx53-mba53.dts
@@ -42,10 +42,9 @@
 			fsl,pins = <689 0x10000		/* DISP1_DRDY	*/
 				    482 0x10000		/* DISP1_HSYNC	*/
 				    489 0x10000		/* DISP1_VSYNC	*/
-				    684 0x10000		/* DISP1_DAT_0	*/
 				    515 0x10000		/* DISP1_DAT_22	*/
 				    523 0x10000		/* DISP1_DAT_23	*/
-				    543 0x10000		/* DISP1_DAT_21	*/
+				    545 0x10000		/* DISP1_DAT_21	*/
 				    553 0x10000		/* DISP1_DAT_20	*/
 				    558 0x10000		/* DISP1_DAT_19	*/
 				    564 0x10000		/* DISP1_DAT_18	*/
-- 
1.7.9.5
