From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 21 Dec 2013 11:11:38 +0400
Subject: [PATCH 2/6] ARM: dts: imx27-phytec-phycore-rdk: Enable 1-Wire module
In-Reply-To: <1387609902-13361-1-git-send-email-shc_work@mail.ru>
References: <1387609902-13361-1-git-send-email-shc_work@mail.ru>
Message-ID: <1387609902-13361-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables 1-Wire module for Phytec PCM-970 RDK.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index 7ada054..eca1b6d 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -44,6 +44,10 @@
 			>;
 		};
 
+		pinctrl_owire1: owire1grp {
+			fsl,pins = <MX27_OWIRE1_PINGRP1>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX27_UART1_PINGRP1
@@ -60,6 +64,12 @@
 	};
 };
 
+&owire {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_owire1>;
+	status = "okay";
+};
+
 &sdhci2 {
 	bus-width = <4>;
 	cd-gpios = <&gpio3 29 GPIO_ACTIVE_HIGH>;
-- 
1.8.3.2
