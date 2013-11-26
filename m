From: lisovy@gmail.com (Rostislav Lisovy)
Date: Wed, 27 Nov 2013 00:53:15 +0100
Subject: [PATCH 1/2] ARM: i.MX53: dts: NAND flash controller
In-Reply-To: <1385509996-17769-1-git-send-email-lisovy@gmail.com>
References: <1385509996-17769-1-git-send-email-lisovy@gmail.com>
Message-ID: <1385509996-17769-2-git-send-email-lisovy@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rostislav Lisovy <lisovy@gmail.com>

diff --git a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
index 9304d0a..fa7309f5 100644
--- a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
+++ b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
@@ -72,6 +72,10 @@
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <MX53_UART1_PINGRP2>;
 		};
+
+		pinctrl_nand: nandgrp {
+			fsl,pins = <MX53_NAND_PINGRP1>;
+		};
 	};
 };
 
@@ -205,6 +209,14 @@
 	};
 };
 
+&nfc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_nand>;
+	nand-bus-width = <8>;
+	nand-ecc-mode = "hw";
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
-- 
1.8.3.2
