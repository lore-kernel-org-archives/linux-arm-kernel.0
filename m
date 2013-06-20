From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 20 Jun 2013 16:50:13 +0200
Subject: [PATCH 4/6] ARM: dts: imx27: Add 1-wire
In-Reply-To: <1371739815-6666-1-git-send-email-mpa@pengutronix.de>
References: <1371739815-6666-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1371739815-6666-5-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx27.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 044004a..e883e77 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -110,6 +110,14 @@
 				clock-names = "ipg", "per";
 			};
 
+			owire: owire at 10009000 {
+				compatible = "fsl,imx21-owire";
+				reg = <0x10009000 0x1000>;
+				clocks = <&clks 35>;
+				clock-names = "ipg";
+				status = "disabled";
+			};
+
 			uart1: serial at 1000a000 {
 				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
 				reg = <0x1000a000 0x1000>;
-- 
1.8.2.1
