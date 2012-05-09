From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 9 May 2012 19:33:03 +0800
Subject: [PATCH V2 04/11] ARM: dts: imx6q-sabrelite: add audmux pinctrl support
In-Reply-To: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1336563190-19974-5-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |    2 ++
 arch/arm/boot/dts/imx6q.dtsi          |    9 +++++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 85b7c6c..5b51deb 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -67,6 +67,8 @@
 
 			audmux at 021d8000 {
 				status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_audmux_1>;
 			};
 
 			uart2: serial at 021e8000 {
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index f95aa3c..5795b93 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -486,6 +486,15 @@
 				reg = <0x020e0000 0x4000>;
 
 				/* shared pinctrl settings */
+				audmux {
+					pinctrl_audmux_1: audmux-1 {
+						fsl,pins = <18   0x80000000	/* MX6Q_PAD_SD2_DAT0__AUDMUX_AUD4_RXD */
+							    1586 0x80000000	/* MX6Q_PAD_SD2_DAT3__AUDMUX_AUD4_TXC */
+							    11   0x80000000	/* MX6Q_PAD_SD2_DAT2__AUDMUX_AUD4_TXD */
+							    3    0x80000000>;	/* MX6Q_PAD_SD2_DAT1__AUDMUX_AUD4_TXFS */
+					};
+				};
+
 				i2c1 {
 					pinctrl_i2c1_1: i2c1grp-1 {
 						fsl,pins = <137 0x4001b8b1	/* MX6Q_PAD_EIM_D21__I2C1_SCL */
-- 
1.7.5.4
