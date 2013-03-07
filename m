From: xobs@kosagi.com (Sean Cross)
Date: Thu,  7 Mar 2013 06:00:09 +0000
Subject: [PATCH v2 2/3] ARM: dts: imx6q: Add pinctrl for i2c2 and i2c3
In-Reply-To: <1362636010-17367-1-git-send-email-xobs@kosagi.com>
References: <1362636010-17367-1-git-send-email-xobs@kosagi.com>
Message-ID: <1362636010-17367-3-git-send-email-xobs@kosagi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add groups to allow i2c2 and i2c3 to be used on imx6q.
---
 arch/arm/boot/dts/imx6q.dtsip |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsip b/arch/arm/boot/dts/imx6q.dtsip
index f318678..1b1f80b 100644
--- a/arch/arm/boot/dts/imx6q.dtsip
+++ b/arch/arm/boot/dts/imx6q.dtsip
@@ -185,6 +185,24 @@
 					};
 				};
 
+				i2c2 {
+					pinctrl_i2c2_1: i2c2grp-1 {
+						fsl,pins = <
+							MX6Q_PAD_EIM_EB2__I2C2_SCL 0x4001b8b1
+							MX6Q_PAD_EIM_D16__I2C2_SDA 0x4001b8b1
+						>;
+					};
+				};
+
+				i2c3 {
+					pinctrl_i2c3_1: i2c3grp-1 {
+						fsl,pins = <
+							MX6Q_PAD_EIM_D17__I2C3_SCL 0x4001b8b1
+							MX6Q_PAD_EIM_D18__I2C3_SDA 0x4001b8b1
+						>;
+					};
+				};
+
 				uart1 {
 					pinctrl_uart1_1: uart1grp-1 {
 						fsl,pins = <
-- 
1.7.9.5
