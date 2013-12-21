From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 21 Dec 2013 11:11:42 +0400
Subject: [PATCH 6/6] ARM: dts: imx27-phytec-phycore-rdk: Add pinctrl
 definitions for WEIM
In-Reply-To: <1387609902-13361-1-git-send-email-shc_work@mail.ru>
References: <1387609902-13361-1-git-send-email-shc_work@mail.ru>
Message-ID: <1387609902-13361-6-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds pinctrl definitions for WEIM CS4 and GPIO used as
CAN IRQ line.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index 1967dad..eaaff00 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -69,6 +69,13 @@
 				MX27_UART2_RTSCTS_PINGRP1
 			>;
 		};
+
+		pinctrl_weim: weimgrp {
+			fsl,pins = <
+				MX27_PAD_CS4_B__CS4_B		0x0 /* CS4 */
+				MX27_PAD_SD1_D1__GPIO5_19	0x0 /* CAN IRQ */
+			>;
+		};
 	};
 };
 
@@ -103,6 +110,9 @@
 };
 
 &weim {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_weim>;
+
 	can at d4000000 {
 		compatible = "nxp,sja1000";
 		reg = <4 0x00000000 0x00000100>;
-- 
1.8.3.2
