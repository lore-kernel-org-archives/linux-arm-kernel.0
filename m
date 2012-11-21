From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 21 Nov 2012 12:20:58 +0100
Subject: [PATCH 2/3] ARM i.MX51: Add pwm support
In-Reply-To: <1353496859-29164-1-git-send-email-s.hauer@pengutronix.de>
References: <1353496859-29164-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1353496859-29164-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx51.dtsi |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 8cf69c7..2781e47 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -409,6 +409,24 @@
 				};
 			};
 
+			pwm1: pwm at 73fb4000 {
+				#pwm-cells = <2>;
+				compatible = "fsl,imx51-pwm", "fsl,imx27-pwm";
+				reg = <0x73fb4000 0x4000>;
+				clocks = <&clks 37>, <&clks 38>;
+				clock-names = "ipg", "per";
+				interrupts = <61>;
+			};
+
+			pwm2: pwm at 73fb8000 {
+				#pwm-cells = <2>;
+				compatible = "fsl,imx51-pwm", "fsl,imx27-pwm";
+				reg = <0x73fb8000 0x4000>;
+				clocks = <&clks 39>, <&clks 40>;
+				clock-names = "ipg", "per";
+				interrupts = <94>;
+			};
+
 			uart1: serial at 73fbc000 {
 				compatible = "fsl,imx51-uart", "fsl,imx21-uart";
 				reg = <0x73fbc000 0x4000>;
-- 
1.7.10.4
