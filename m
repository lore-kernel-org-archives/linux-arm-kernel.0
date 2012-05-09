From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 9 May 2012 19:33:08 +0800
Subject: [PATCH V2 09/11] ARM: dts: imx6q-sabrelite: add serial2 pinctrl
 support
In-Reply-To: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1336563190-19974-10-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |    2 ++
 arch/arm/boot/dts/imx6q.dtsi          |    7 +++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 5a35bfd..e0ec929 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -73,6 +73,8 @@
 
 			uart2: serial at 021e8000 {
 				status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_serial2_1>;
 			};
 
 			i2c at 021a0000 { /* I2C1 */
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 5795b93..31c3d5f 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -502,6 +502,13 @@
 					};
 				};
 
+				serial2 {
+					pinctrl_serial2_1: serial2grp-1 {
+						fsl,pins = <183 0x1b0b1		/* MX6Q_PAD_EIM_D26__UART2_TXD */
+							    191 0x1b0b1>;	/* MX6Q_PAD_EIM_D27__UART2_RXD */
+					};
+				};
+
 				usdhc3 {
 					pinctrl_usdhc3_1: usdhc3grp-1 {
 						fsl,pins = <1273 0x17059	/* MX6Q_PAD_SD3_CMD__USDHC3_CMD */
-- 
1.7.5.4
