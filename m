From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 21 Dec 2013 11:11:41 +0400
Subject: [PATCH 5/6] ARM: dts: imx27-phytec-phycore-rdk: Add pingrp for SDHC
In-Reply-To: <1387609902-13361-1-git-send-email-shc_work@mail.ru>
References: <1387609902-13361-1-git-send-email-shc_work@mail.ru>
Message-ID: <1387609902-13361-5-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index eca1b6d..1967dad 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -48,6 +48,14 @@
 			fsl,pins = <MX27_OWIRE1_PINGRP1>;
 		};
 
+		pinctrl_sdhc2: sdhc2grp {
+			fsl,pins = <
+				MX27_SDHC2_PINGRP1
+				MX27_PAD_SSI3_FS__GPIO3_28	0x0 /* WP */
+				MX27_PAD_SSI3_RXDAT__GPIO3_29	0x0 /* CD */
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX27_UART1_PINGRP1
@@ -71,6 +79,8 @@
 };
 
 &sdhci2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdhc2>;
 	bus-width = <4>;
 	cd-gpios = <&gpio3 29 GPIO_ACTIVE_HIGH>;
 	wp-gpios = <&gpio3 28 GPIO_ACTIVE_HIGH>;
-- 
1.8.3.2
