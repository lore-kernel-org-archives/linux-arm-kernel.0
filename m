From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu, 31 Mar 2016 14:33:43 +0200
Subject: [PATCHv3 3/5] ARM: dts: imx6-tx6: enable support for rtscts on UARTs
In-Reply-To: <1459427625-15568-1-git-send-email-LW@KARO-electronics.de>
References: <1459427625-15568-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1459427625-15568-4-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing pinctrl for the RTS/CTS lines to uart1 and set the
fsl,uart-has-rtscts property on all UARTs to enable support for HW
handshake.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6qdl-tx6.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index d96dba2..24101c1 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -684,19 +684,22 @@
 
 &uart1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
+	pinctrl-0 = <&pinctrl_uart1 &pinctrl_uart1_rtscts>;
+	fsl,uart-has-rtscts;
 	status = "okay";
 };
 
 &uart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2 &pinctrl_uart2_rtscts>;
+	fsl,uart-has-rtscts;
 	status = "okay";
 };
 
 &uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart3 &pinctrl_uart3_rtscts>;
+	fsl,uart-has-rtscts;
 	status = "okay";
 };
 
-- 
2.1.4
