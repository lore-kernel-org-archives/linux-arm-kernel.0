From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun,  2 Mar 2014 13:18:38 +0400
Subject: [PATCH 1/2] ARM: dts: imx27-phytec-phycore-rdk: Add missing pinctrl
 definition for SPI CS1
Message-ID: <1393751919-17892-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds missing pinctrl definition for SPI chipselect 1.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index df3b2e7..86510ed 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -15,6 +15,7 @@
 };
 
 &cspi1 {
+	pinctrl-0 = <&pinctrl_cspi1>, <&pinctrl_cspi1cs1>;
 	fsl,spi-num-chipselects = <2>;
 	cs-gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>,
 		   <&gpio4 27 GPIO_ACTIVE_LOW>;
@@ -36,6 +37,12 @@
 
 &iomuxc {
 	imx27_phycore_rdk {
+		pinctrl_cspi1cs1: cspi1cs1grp {
+			fsl,pins = <
+				MX27_PAD_CSPI1_SS1__GPIO4_27 0x0
+			>;
+		};
+
 		pinctrl_i2c1: i2c1grp {
 			/* Add pullup to DATA line */
 			fsl,pins = <
-- 
1.8.3.2
