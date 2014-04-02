From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  2 Apr 2014 19:25:45 -0300
Subject: [PATCH 2/3] ARM: dts: imx27-pdk: Pass the UART1 pin configuration
In-Reply-To: <1396477546-11130-1-git-send-email-festevam@gmail.com>
References: <1396477546-11130-1-git-send-email-festevam@gmail.com>
Message-ID: <1396477546-11130-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Provide an entry for the UART1 pin muxing.

While at it, sort the dt entries.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx27-pdk.dts | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-pdk.dts b/arch/arm/boot/dts/imx27-pdk.dts
index 28c83bc..5e9a4bb 100644
--- a/arch/arm/boot/dts/imx27-pdk.dts
+++ b/arch/arm/boot/dts/imx27-pdk.dts
@@ -21,11 +21,27 @@
 	};
 };
 
-&uart1 {
-	fsl,uart-has-rtscts;
+&fec {
 	status = "okay";
 };
 
-&fec {
+
+&iomuxc {
+	imx27-pdk {
+		pinctrl_uart1: uart1grp {
+			fsl,pins = <
+				MX27_PAD_UART1_TXD__UART1_TXD 0x0
+				MX27_PAD_UART1_RXD__UART1_RXD 0x0
+				MX27_PAD_UART1_CTS__UART1_CTS 0x0
+				MX27_PAD_UART1_RTS__UART1_RTS 0x0
+			>;
+		};
+	};
+};
+
+&uart1 {
+	fsl,uart-has-rtscts;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
 	status = "okay";
 };
-- 
1.8.3.2
