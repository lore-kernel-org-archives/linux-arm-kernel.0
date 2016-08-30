From: vanessa.maegima@nxp.com (Vanessa Maegima)
Date: Tue, 30 Aug 2016 17:23:02 -0300
Subject: [PATCH v2 1/3] ARM: dts: imx7s-warp: Enable I2C2 device support
Message-ID: <1472588584-686-1-git-send-email-vanessa.maegima@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable I2C2 device support.

Signed-off-by: Vanessa Maegima <vanessa.maegima@nxp.com>
---
Changes since v1:
- Update commit subject
- Update commit log

 arch/arm/boot/dts/imx7s-warp.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
index 92d9c85..71dbece 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -188,6 +188,13 @@
 	};
 };
 
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+};
+
 &i2c4 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
@@ -278,6 +285,13 @@
 		>;
 	};
 
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX7D_PAD_I2C2_SDA__I2C2_SDA	0x4000007f
+			MX7D_PAD_I2C2_SCL__I2C2_SCL	0x4000007f
+		>;
+	};
+
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
 			MX7D_PAD_I2C4_SCL__I2C4_SCL	0x4000007f
-- 
2.7.4
