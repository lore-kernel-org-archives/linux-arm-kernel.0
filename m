From: koro.chen@mediatek.com (Koro Chen)
Date: Mon, 6 Jul 2015 14:52:10 +0800
Subject: [PATCH] arm64: dts: mt8173: Add afe device node
Message-ID: <1436165530-41963-1-git-send-email-koro.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds afe (audio front end) device node to the MT8173 dtsi file.

This patch is based on Matthias's tree:
https://github.com/mbgg/linux-mediatek
branch: v4.2-next/arm64

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 0696f8f..f8afab4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/clock/mt8173-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/mt8173-power.h>
 #include <dt-bindings/reset-controller/mt8173-resets.h>
 #include "mt8173-pinfunc.h"
 
@@ -393,6 +394,37 @@
 			#size-cells = <0>;
 			status = "disabled";
 		};
+
+		afe: mt8173-afe-pcm at 11220000  {
+			compatible = "mediatek,mt8173-afe-pcm";
+			reg = <0 0x11220000 0 0x1000>;
+			interrupts = <GIC_SPI 134 IRQ_TYPE_EDGE_FALLING>;
+			power-domains = <&scpsys MT8173_POWER_DOMAIN_AUDIO>;
+			clocks = <&infracfg CLK_INFRA_AUDIO>,
+				 <&topckgen CLK_TOP_AUDIO_SEL>,
+				 <&topckgen CLK_TOP_AUD_INTBUS_SEL>,
+				 <&topckgen CLK_TOP_APLL1_DIV0>,
+				 <&topckgen CLK_TOP_APLL2_DIV0>,
+				 <&topckgen CLK_TOP_I2S0_M_SEL>,
+				 <&topckgen CLK_TOP_I2S1_M_SEL>,
+				 <&topckgen CLK_TOP_I2S2_M_SEL>,
+				 <&topckgen CLK_TOP_I2S3_M_SEL>,
+				 <&topckgen CLK_TOP_I2S3_B_SEL>;
+			clock-names = "infra_sys_audio_clk",
+				      "top_pdn_audio",
+				      "top_pdn_aud_intbus",
+				      "bck0",
+				      "bck1",
+				      "i2s0_m",
+				      "i2s1_m",
+				      "i2s2_m",
+				      "i2s3_m",
+				      "i2s3_b";
+			assigned-clocks = <&topckgen CLK_TOP_AUD_1_SEL>,
+					  <&topckgen CLK_TOP_AUD_2_SEL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_APLL1>,
+						 <&topckgen CLK_TOP_APLL2>;
+		};
 	};
 };
 
-- 
1.8.1.1.dirty
