From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 26 Apr 2014 08:52:10 +0400
Subject: [PATCH 5/8] ARM: dts: imx27-phytec-phycore-rdk: Add CSI enable switch
In-Reply-To: <1398487933-5683-1-git-send-email-shc_work@mail.ru>
References: <1398487933-5683-1-git-send-email-shc_work@mail.ru>
Message-ID: <1398487933-5683-5-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a GPIO fixed regulator which used on RDK to
enable CSI bus.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index ac18ccf..72c773e 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -38,6 +38,20 @@
 		};
 	};
 
+	regulators {
+		regulator at 2 {
+			compatible = "regulator-fixed";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_csien>;
+			reg = <2>;
+			regulator-name = "CSI_EN";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio2 24 GPIO_ACTIVE_LOW>;
+			regulator-always-on;
+		};
+	};
+
 	usbphy {
 		usbphy2: usbphy at 2 {
 			compatible = "usb-nop-xceiv";
@@ -83,6 +97,12 @@
 
 &iomuxc {
 	imx27_phycore_rdk {
+		pinctrl_csien: csiengrp {
+			fsl,pins = <
+				MX27_PAD_USB_OC_B__GPIO2_24 0x0
+			>;
+		};
+
 		pinctrl_cspi1cs1: cspi1cs1grp {
 			fsl,pins = <
 				MX27_PAD_CSPI1_SS1__GPIO4_27 0x0
-- 
1.8.3.2
