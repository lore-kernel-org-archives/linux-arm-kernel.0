From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 18 Jul 2012 11:42:43 +0200
Subject: [PATCH 2/2] ARM i.MX53: dts: add flexcan to imx53
In-Reply-To: <1342604563-18915-1-git-send-email-mkl@pengutronix.de>
References: <1342604563-18915-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1342604563-18915-3-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/boot/dts/imx53.dtsi |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index e3e8694..5ae0dbd 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -196,6 +196,20 @@
 				status = "disabled";
 			};
 
+			can1: can at 53fc8000 {
+				compatible = "fsl,imx53-flexcan", "fsl,p1010-flexcan";
+				reg = <0x53fc8000 0x4000>;
+				interrupts = <82>;
+				status = "disabled";
+			};
+
+			can2: can at 53fcc000 {
+				compatible = "fsl,imx53-flexcan", "fsl,p1010-flexcan";
+				reg = <0x53fcc000 0x4000>;
+				interrupts = <83>;
+				status = "disabled";
+			};
+
 			gpio5: gpio at 53fdc000 {
 				compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
 				reg = <0x53fdc000 0x4000>;
-- 
1.7.10.4
