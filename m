From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Mon, 24 Mar 2014 10:22:14 +0800
Subject: [PATCHv2 1/3] ARM: dts: vf610: Add Freescale FTM PWM node.
In-Reply-To: <1395627736-5338-1-git-send-email-Li.Xiubo@freescale.com>
References: <1395627736-5338-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <1395627736-5338-2-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds devicetree node for VF610, and there are 8 channels
supported.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Yuan Yao <yao.yuan@freescale.com>
---
 arch/arm/boot/dts/vf610.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index acf544e..2a7917e 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -183,6 +183,19 @@
 				clock-names = "pit";
 			};
 
+			pwm0: pwm at 40038000 {
+				compatible = "fsl,vf610-ftm-pwm";
+				#pwm-cells = <3>;
+				reg = <0x40038000 0x1000>;
+				clock-names = "ftm_sys", "ftm_ext",
+					      "ftm_fix", "ftm_cnt_clk_en";
+				clocks = <&clks VF610_CLK_FTM0>,
+					<&clks VF610_CLK_FTM0_EXT_SEL>,
+					<&clks VF610_CLK_FTM0_FIX_SEL>,
+					<&clks VF610_CLK_FTM0_EXT_FIX_EN>;
+				status = "disabled";
+			};
+
 			adc0: adc at 4003b000 {
 				compatible = "fsl,vf610-adc";
 				reg = <0x4003b000 0x1000>;
-- 
1.8.4
