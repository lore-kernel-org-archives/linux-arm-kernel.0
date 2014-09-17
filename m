From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Wed, 17 Sep 2014 13:46:28 +0530
Subject: [PATCH 1/3] ARM: dts: vf610: Add PWM second instance
In-Reply-To: <cover.1410930820.git.bhuvanchandra.dv@toradex.com>
References: <cover.1410930820.git.bhuvanchandra.dv@toradex.com>
Message-ID: <8adbc5d8df9f559c434a486fd9e8143e1d537aaf.1410930820.git.bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
 arch/arm/boot/dts/vf610.dtsi |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 4d2ec32..fb00f13 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -210,6 +210,19 @@
 				status = "disabled";
 			};
 
+			pwm1: pwm at 40039000 {
+				compatible = "fsl,vf610-ftm-pwm";
+				#pwm-cells = <3>;
+				reg = <0x40039000 0x1000>;
+				clock-names = "ftm_sys", "ftm_ext",
+					      "ftm_fix", "ftm_cnt_clk_en";
+				clocks = <&clks VF610_CLK_FTM1>,
+					<&clks VF610_CLK_FTM1_EXT_SEL>,
+					<&clks VF610_CLK_FTM1_FIX_SEL>,
+					<&clks VF610_CLK_FTM1_EXT_FIX_EN>;
+				status = "disabled";
+			};
+
 			adc0: adc at 4003b000 {
 				compatible = "fsl,vf610-adc";
 				reg = <0x4003b000 0x1000>;
-- 
1.7.9.5
