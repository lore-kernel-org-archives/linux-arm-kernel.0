From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 23 May 2014 12:31:50 +0200
Subject: [PATCH 70/71] ARM: dts: vf610: Add Freescale FlexTimer Module timer
 node.
In-Reply-To: <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
References: <537F214C.8000700@linaro.org>
 <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1400841111-6683-70-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xiubo Li <Li.Xiubo@freescale.com>

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Jingchang Lu <b35083@freescale.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/boot/dts/vf610.dtsi |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index b8ce0aa7..3c91b84 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -347,6 +347,19 @@
 				status = "disabled";
 			};
 
+			ftm: ftm at 400b8000 {
+				compatible = "fsl,ftm-timer";
+				reg = <0x400b8000 0x1000 0x400b9000 0x1000>;
+				interrupts = <0 44 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "ftm-evt", "ftm-src",
+					"ftm-evt-counter-en", "ftm-src-counter-en";
+				clocks = <&clks VF610_CLK_FTM2>,
+					<&clks VF610_CLK_FTM3>,
+					<&clks VF610_CLK_FTM2_EXT_FIX_EN>,
+					<&clks VF610_CLK_FTM3_EXT_FIX_EN>;
+				status = "disabled";
+			};
+
 			fec0: ethernet at 400d0000 {
 				compatible = "fsl,mvf600-fec";
 				reg = <0x400d0000 0x1000>;
-- 
1.7.9.5
