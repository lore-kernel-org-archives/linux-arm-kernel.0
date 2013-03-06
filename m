From: xobs@kosagi.com (Sean Cross)
Date: Wed,  6 Mar 2013 05:05:32 +0000
Subject: [PATCH 2/2] imx6q: Add device definition for i2c2 and i2c3
In-Reply-To: <1362546332-11847-1-git-send-email-xobs@kosagi.com>
References: <1362546332-11847-1-git-send-email-xobs@kosagi.com>
Message-ID: <1362546332-11847-3-git-send-email-xobs@kosagi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device definitions for the remaining two i2c buses.
---
 arch/arm/boot/dts/imx6q.dtsi |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 65b3a849..18adca3 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -184,6 +184,24 @@
 					};
 				};
 
+				i2c2 {
+					pinctrl_i2c2_1: i2c2grp-1 {
+						fsl,pins = <
+							91  0x4001b8b1	/* MX6Q_PAD_EIM_EB2__I2C2_SCL / ALT6 */
+							99  0x4001b8b1	/* MX6Q_PAD_EIM_D16__I2C2_SDA / ALT6 */
+						>;
+					};
+				};
+
+				i2c3 {
+					pinctrl_i2c3_1: i2c3grp-1 {
+						fsl,pins = <
+							106 0x4001b8b1	/* MX6Q_PAD_EIM_D17__I2C3_SCL / ALT6 */
+							114 0x4001b8b1	/* MX6Q_PAD_EIM_D18__I2C3_SDA / ALT6 */
+						>;
+					};
+				};
+
 				uart1 {
 					pinctrl_uart1_1: uart1grp-1 {
 						fsl,pins = <
-- 
1.7.9.5
