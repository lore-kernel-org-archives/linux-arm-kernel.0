From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed, 16 Apr 2014 11:24:56 +0400
Subject: [PATCH 7/8] ARM: dts: imx51-babbage: Add devicetree node for I2C1
In-Reply-To: <1397633097-1640-1-git-send-email-shc_work@mail.ru>
References: <1397633097-1640-1-git-send-email-shc_work@mail.ru>
Message-ID: <1397633097-1640-7-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds devicetree node and pinctrl group for I2C1.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51-babbage.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 6484b73..5a50bbf 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -335,6 +335,12 @@
 	status = "okay";
 };
 
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+};
+
 &i2c2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c2>;
@@ -513,6 +519,13 @@
 			>;
 		};
 
+		pinctrl_i2c1: i2c1grp {
+			fsl,pins = <
+				MX51_PAD_EIM_D19__I2C1_SCL		0x400001ed
+				MX51_PAD_EIM_D16__I2C1_SDA		0x400001ed
+			>;
+		};
+
 		pinctrl_i2c2: i2c2grp {
 			fsl,pins = <
 				MX51_PAD_KEY_COL4__I2C2_SCL		0x400001ed
-- 
1.8.3.2
