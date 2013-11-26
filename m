From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Tue, 26 Nov 2013 16:40:43 +0100
Subject: [PATCH 2/3] ARM: dts: imx27: imx27-apf27: add pinctrl for fec and
 uart1
In-Reply-To: <1385480444-77808-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1385480444-77808-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <1385480444-77808-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 arch/arm/boot/dts/imx27-apf27.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-apf27.dts b/arch/arm/boot/dts/imx27-apf27.dts
index ba4c6df..8bc75c7 100644
--- a/arch/arm/boot/dts/imx27-apf27.dts
+++ b/arch/arm/boot/dts/imx27-apf27.dts
@@ -34,11 +34,27 @@
 	};
 };
 
+&iomuxc {
+	imx27-apf27 {
+		pinctrl_fec1: fec1grp {
+			fsl,pins = <MX27_FEC1_PINGRP1>;
+		};
+
+		pinctrl_uart1: uart1grp {
+			fsl,pins = <MX27_UART1_PINGRP1>;
+		};
+	};
+};
+
 &uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
 	status = "okay";
 };
 
 &fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
 	status = "okay";
 };
 
-- 
1.8.3.2
