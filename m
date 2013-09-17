From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 17 Sep 2013 16:18:38 -0300
Subject: [PATCH] ARM: dts: imx28-evk: Enable touchscreen support
Message-ID: <1379445518-3260-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide 'lradc-touchscreen-wires' property to the LRADC driver, so that
touchscreen can be functional.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Shawn,

I undertand you reported issues with this patch in the previous kernel.

With 3.12-rc1, I am not able to see any problem with it.

Most likely that the audio issue you saw was due to the mxs i2c breakage (PIO 
mode for small transfers) that it is fixed now.

 arch/arm/boot/dts/imx28-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 8cb6b6a..5f9c0a0 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -182,6 +182,7 @@
 			};
 
 			lradc at 80050000 {
+				fsl,lradc-touchscreen-wires = <4>;
 				status = "okay";
 			};
 
-- 
1.8.1.2
