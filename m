From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed,  5 Mar 2014 10:20:58 +0100
Subject: [PATCH v5 07/11] ARM: dts: imx53-mba53: Fix TVE DDC I2C bus property
In-Reply-To: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
References: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1394011262-16849-8-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the Television Encoder node's DDC I2C bus property to
use the common property name of 'ddc-i2c-bus' instead of just 'ddc'.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx53-mba53.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/imx53-mba53.dts
index 9b6e769..f2affb0 100644
--- a/arch/arm/boot/dts/imx53-mba53.dts
+++ b/arch/arm/boot/dts/imx53-mba53.dts
@@ -234,7 +234,7 @@
 &tve {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_vga_sync_1>;
-	ddc = <&i2c3>;
+	i2c-ddc-bus = <&i2c3>;
 	fsl,tve-mode = "vga";
 	fsl,hsync-pin = <4>;
 	fsl,vsync-pin = <6>;
-- 
1.9.0.rc3
