From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Tue, 12 Nov 2013 09:36:56 +0800
Subject: [PATCHv6 2/4] ARM: dts: Add Freescale FTM PWM node for VF610.
In-Reply-To: <1384220218-12716-1-git-send-email-Li.Xiubo@freescale.com>
References: <1384220218-12716-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <1384220218-12716-3-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds devicetree node for VF610, and there are 8 channels supported
by default.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/vf610.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 67d929c..ec12397 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -140,6 +140,16 @@
 				clock-names = "pit";
 			};
 
+			pwm0: pwm at 40038000 {
+				compatible = "fsl,vf610-ftm-pwm";
+				#pwm-cells = <3>;
+				reg = <0x40038000 0x1000>;
+				clock-names = "ftm0", "ftm0_counter";
+				clocks = <&clks VF610_CLK_FTM0>,
+					<&clks VF610_CLK_FTM0>;
+				status = "disabled";
+			};
+
 			wdog at 4003e000 {
 				compatible = "fsl,vf610-wdt", "fsl,imx21-wdt";
 				reg = <0x4003e000 0x1000>;
-- 
1.8.4
