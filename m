From: Anson.Huang@nxp.com (Anson Huang)
Date: Mon, 23 Apr 2018 11:46:59 +0800
Subject: [PATCH 5/5] ARM: dts: imx6sx-sabreauto: add wdog external reset
 support
In-Reply-To: <1524455219-6736-1-git-send-email-Anson.Huang@nxp.com>
References: <1524455219-6736-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1524455219-6736-5-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6SX Sabre Auto board has GPIO1_IO13 pin can be
MUXed as WDOG output to reset PMIC, add this function
support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index eadd483..bf19f4f 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -231,6 +231,12 @@
 				MX6SX_PAD_KEY_COL1__GPIO2_IO_11		0x17059
 			>;
 		};
+
+		pinctrl_wdog: wdoggrp {
+			fsl,pins = <
+				MX6SX_PAD_GPIO1_IO13__WDOG1_WDOG_ANY 0x30b0
+			>;
+		};
 	};
 };
 
@@ -370,3 +376,9 @@
 		#gpio-cells = <2>;
 	};
 };
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
-- 
2.7.4
