From: chf.fritz@googlemail.com (Christoph Fritz)
Date: Sun, 24 Jan 2016 23:49:18 +0100
Subject: [PATCH] ARM: imx6sx-sdb: add i2c3 node
Message-ID: <1453675758.6691.17.camel@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds node i2c bus 3 to get the appropriate userland device
file. So for prototyping it's possible to experiment within userland.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 arch/arm/boot/dts/imx6sx-sdb.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
index e0dc1ee..3d91627 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -197,6 +197,13 @@
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
@@ -398,6 +405,13 @@
 			>;
 		};
 
+		pinctrl_i2c3: i2c3grp {
+			fsl,pins = <
+				MX6SX_PAD_KEY_ROW4__I2C3_SDA		0x4001b8b1
+				MX6SX_PAD_KEY_COL4__I2C3_SCL		0x4001b8b1
+			>;
+		};
+
 		pinctrl_i2c4: i2c4grp {
 			fsl,pins = <
 				MX6SX_PAD_CSI_DATA07__I2C4_SDA		0x4001b8b1
-- 
2.1.4
