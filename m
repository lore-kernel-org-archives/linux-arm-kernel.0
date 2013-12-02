From: marex@denx.de (Marek Vasut)
Date: Mon,  2 Dec 2013 16:39:28 +0100
Subject: [PATCH 3/3] ARM: dts: imx53: Switch DISP_CLK polarity on M53EVK
In-Reply-To: <1385998768-23512-1-git-send-email-marex@denx.de>
References: <1385998768-23512-1-git-send-email-marex@denx.de>
Message-ID: <1385998768-23512-3-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the DISP_CLK line polarity on M53EVK to work correctly after
the following commit:

commit f0ac9bebf19001f38afbb93e2dc719a15dfb75e5
Author: Fabio Estevam <fabio.estevam@freescale.com>
Date:   Tue Oct 29 19:42:22 2013 -0200

    imx-drm: ipuv3-crtc: Invert IPU DI0 clock polarity

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Dave Airlie <airlied@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx53-m53evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
index 84a2cdc..97ec9c7 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -41,6 +41,7 @@
 					vfront-porch = <9>;
 					vsync-len = <3>;
 					vsync-active = <1>;
+					pixelclk-active = <1>;
 				};
 			};
 		};
-- 
1.8.4.2
