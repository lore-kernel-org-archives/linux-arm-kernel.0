From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 21 Nov 2012 12:20:57 +0100
Subject: [PATCH 1/3] ARM i.MX53: Add pwm support
In-Reply-To: <1353496859-29164-1-git-send-email-s.hauer@pengutronix.de>
References: <1353496859-29164-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1353496859-29164-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx53.dtsi |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index a5cb51f..12f2fc2 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -393,6 +393,24 @@
 				};
 			};
 
+			pwm1: pwm at 53fb4000 {
+				#pwm-cells = <2>;
+				compatible = "fsl,imx53-pwm", "fsl,imx27-pwm";
+				reg = <0x53fb4000 0x4000>;
+				clocks = <&clks 37>, <&clks 38>;
+				clock-names = "ipg", "per";
+				interrupts = <61>;
+			};
+
+			pwm2: pwm at 53fb8000 {
+				#pwm-cells = <2>;
+				compatible = "fsl,imx53-pwm", "fsl,imx27-pwm";
+				reg = <0x53fb8000 0x4000>;
+				clocks = <&clks 39>, <&clks 40>;
+				clock-names = "ipg", "per";
+				interrupts = <94>;
+			};
+
 			uart1: serial at 53fbc000 {
 				compatible = "fsl,imx53-uart", "fsl,imx21-uart";
 				reg = <0x53fbc000 0x4000>;
-- 
1.7.10.4
