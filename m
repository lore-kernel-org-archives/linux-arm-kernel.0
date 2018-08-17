From: texier.pj2@gmail.com (Pierre-Jean Texier)
Date: Fri, 17 Aug 2018 23:23:17 +0200
Subject: [PATCH] ARM: dts: imx7s-warp: enable i2c3 device support
Message-ID: <1534540997-20094-1-git-send-email-texier.pj2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The WaRP7 has one mikroBUS socket on the back to plug click boards.
This patch allows to interact with some of these
i2c modules (EEPROM, RTC and so on).

Signed-off-by: Pierre-Jean Texier <texier.pj2@gmail.com>
---
 arch/arm/boot/dts/imx7s-warp.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
index fa390da..b3d0951 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -216,6 +216,13 @@
 	status = "okay";
 };
 
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+};
+
 &i2c4 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
@@ -346,6 +353,13 @@
 		>;
 	};
 
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX7D_PAD_I2C3_SDA__I2C3_SDA	0x4000007f
+			MX7D_PAD_I2C3_SCL__I2C3_SCL	0x4000007f
+		>;
+	};
+
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
 			MX7D_PAD_I2C4_SCL__I2C4_SCL	0x4000007f
-- 
2.7.4
