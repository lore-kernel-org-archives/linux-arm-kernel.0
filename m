From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 12 Dec 2013 18:49:06 -0700
Subject: [PATCH V1 02/11] ARM: dts: imx6qdl-sabrelite: Add uart1 support
In-Reply-To: <1386899355-17379-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1386899355-17379-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1386899355-17379-3-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uart1 is available on Sabre Lite.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index d7522c9..903da14 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -141,6 +141,10 @@
 			fsl,pins = <MX6QDL_I2C1_PINGRP1>;
 		};
 
+		pinctrl_uart1: uart1grp {
+			fsl,pins = <MX6QDL_UART1_PINGRP2>;
+		};
+
 		pinctrl_uart2: uart2grp {
 			fsl,pins = <MX6QDL_UART2_PINGRP1>;
 		};
@@ -189,6 +193,12 @@
 	status = "okay";
 };
 
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
 &uart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2>;
-- 
1.8.1.2
