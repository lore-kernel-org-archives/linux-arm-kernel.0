From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 13 Apr 2014 11:48:42 -0300
Subject: [PATCH v4 2/3] ARM: dts: imx27-pdk: Pass the UART1 pin configuration
In-Reply-To: <1397400523-4330-1-git-send-email-festevam@gmail.com>
References: <1397400523-4330-1-git-send-email-festevam@gmail.com>
Message-ID: <1397400523-4330-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Provide an entry for the UART1 pin muxing.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v3:
- None
Changes since v2:
- None
Changes since v1:
- Keep the iomuxc node at the bottom

 arch/arm/boot/dts/imx27-pdk.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-pdk.dts b/arch/arm/boot/dts/imx27-pdk.dts
index bd95265..e0f4213 100644
--- a/arch/arm/boot/dts/imx27-pdk.dts
+++ b/arch/arm/boot/dts/imx27-pdk.dts
@@ -28,5 +28,20 @@
 
 &uart1 {
 	fsl,uart-has-rtscts;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
 	status = "okay";
 };
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
-- 
1.8.3.2
