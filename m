From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 16 Jan 2014 13:52:27 +0100
Subject: [PATCH 1/4] ARM: dts: imx6: edmqmx6: Add usdhc4 (emmc) support
In-Reply-To: <1389876750-29880-1-git-send-email-s.hauer@pengutronix.de>
References: <1389876750-29880-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1389876750-29880-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
index 84f5143..7ce2038 100644
--- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
@@ -141,6 +141,10 @@
 		pinctrl_usdhc3: usdhc3grp {
 			fsl,pins = <MX6QDL_USDHC3_PINGRP_D4>;
 		};
+
+		pinctrl_usdhc4: usdhc4grp {
+			fsl,pins = <MX6QDL_USDHC4_PINGRP_D8>;
+		};
 	};
 };
 
@@ -176,3 +180,12 @@
 	vmmc-supply = <&reg_3p3v>;
 	status = "okay";
 };
+
+&usdhc4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc4>;
+	vmmc-supply = <&reg_3p3v>;
+	non-removable;
+	bus-width = <8>;
+	status = "okay";
+};
-- 
1.8.5.2
