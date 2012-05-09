From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 9 May 2012 19:33:01 +0800
Subject: [PATCH V2 02/11] ARM: dts: imx6q-sabrelite: add i2c1 pinctrl support
In-Reply-To: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1336563190-19974-3-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |    2 ++
 arch/arm/boot/dts/imx6q.dtsi          |    7 +++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 2f631f2..85b7c6c 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -76,6 +76,8 @@
 			i2c at 021a0000 { /* I2C1 */
 				status = "okay";
 				clock-frequency = <100000>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2c1_1>;
 
 				codec: sgtl5000 at 0a {
 					compatible = "fsl,sgtl5000";
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 949f979..f95aa3c 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -486,6 +486,13 @@
 				reg = <0x020e0000 0x4000>;
 
 				/* shared pinctrl settings */
+				i2c1 {
+					pinctrl_i2c1_1: i2c1grp-1 {
+						fsl,pins = <137 0x4001b8b1	/* MX6Q_PAD_EIM_D21__I2C1_SCL */
+							    196 0x4001b8b1>;	/* MX6Q_PAD_EIM_D28__I2C1_SDA */
+					};
+				};
+
 				usdhc3 {
 					pinctrl_usdhc3_1: usdhc3grp-1 {
 						fsl,pins = <1273 0x17059	/* MX6Q_PAD_SD3_CMD__USDHC3_CMD */
-- 
1.7.5.4
