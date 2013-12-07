From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  7 Dec 2013 12:26:35 +0400
Subject: [PATCH 4/5] ARM: dts: imx27-phytec-phycore-som: Add pinctrl for CSPI1
 and GPIOs used on module
In-Reply-To: <1386404796-8848-1-git-send-email-shc_work@mail.ru>
References: <1386404796-8848-1-git-send-email-shc_work@mail.ru>
Message-ID: <1386404796-8848-4-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-som.dts | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
index ce8d69a..7087a4f 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
@@ -51,6 +51,8 @@
 };
 
 &cspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_cspi1>;
 	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
 	status = "okay";
@@ -181,8 +183,19 @@
 
 &iomuxc {
 	imx27_phycore_som {
+		pinctrl_cspi1: cspi1grp {
+			fsl,pins = <
+				MX27_CSPI1_PINGRP1
+				MX27_PAD_CSPI1_SS0__GPIO4_28	0x0 /* SPI1 CS0 */
+				MX27_PAD_USB_PWR__GPIO2_23	0x0 /* PMIC IRQ */
+			>;
+		};
+
 		pinctrl_fec1: fec1grp {
-			fsl,pins = <MX27_FEC1_PINGRP1>;
+			fsl,pins = <
+				MX27_FEC1_PINGRP1
+				MX27_PAD_SSI3_TXDAT__GPIO3_30	0x0 /* FEC RST */
+			>;
 		};
 
 		pinctrl_i2c2: i2c2grp {
-- 
1.8.3.2
