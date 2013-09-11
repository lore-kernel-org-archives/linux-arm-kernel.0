From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 11 Sep 2013 11:51:08 +0200
Subject: [PATCH 2/2] ARM: dts: imx53-qsb: select open-drain mode for i2c1 pads
In-Reply-To: <1378893068-22235-1-git-send-email-l.stach@pengutronix.de>
References: <1378893068-22235-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1378893068-22235-2-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pull-ups on this bus are connected to the 1.8V plane.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx53-qsb.dts | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
index 2031ccc..29d81da 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -155,6 +155,16 @@
 			>;
 		};
 	};
+	
+	i2c1 {
+		/* open drain */
+		pinctrl_i2c1_qsb: i2c1grp-1 {
+			fsl,pins = <
+				MX53_PAD_CSI0_DAT8__I2C1_SDA      0x400001cc
+				MX53_PAD_CSI0_DAT9__I2C1_SCL      0x400001cc
+			>;
+		};
+	};
 
 	tve {
 		pinctrl_vga_sync_1: vgasync-grp1 {
@@ -189,7 +199,7 @@
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1_1>;
+	pinctrl-0 = <&pinctrl_i2c1_qsb>;
 	status = "okay";
 
 	accelerometer: mma8450 at 1c {
-- 
1.8.4.rc3
