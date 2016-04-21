From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 21 Apr 2016 12:04:27 +0100
Subject: [PATCH 10/18] ASoC: sti: Update example to include assigned-clocks
 and mclk-fs
In-Reply-To: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
References: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1461236675-10176-11-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the examples, as otherwise driver errors with an incorrect
mclk ratio at runtime.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Cc: arnaud.pouliquen at st.com
---
 Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt b/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
index ef2e0c6..e6ef96a8 100644
--- a/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
+++ b/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
@@ -62,6 +62,9 @@ Example:
 		#sound-dai-cells = <0>;
 		st,syscfg = <&syscfg_core>;
 		clocks = <&clk_s_d0_flexgen CLK_PCM_2>;
+		assigned-clocks = <&clk_s_d0_flexgen CLK_PCM_2>;
+		assigned-clock-parents = <&clk_s_d0_quadfs 2>;
+		assigned-clock-rates = <50000000>;
 		reg = <0x8D82000 0x158>;
 		interrupts = <GIC_SPI 86 IRQ_TYPE_NONE>;
 		dmas = <&fdma0 4 0 1>;
@@ -78,6 +81,9 @@ Example:
 		#sound-dai-cells = <0>;
 		st,syscfg = <&syscfg_core>;
 		clocks = <&clk_s_d0_flexgen CLK_SPDIFF>;
+		assigned-clocks = <&clk_s_d0_flexgen CLK_SPDIFF>;
+		assigned-clock-parents = <&clk_s_d0_quadfs 3>;
+		assigned-clock-rates = <50000000>;
 		reg = <0x8D85000 0x158>;
 		interrupts = <GIC_SPI 89 IRQ_TYPE_NONE>;
 		dmas = <&fdma0 7 0 1>;
@@ -133,6 +139,7 @@ Example of audio card declaration:
 			/* DAC */
 			format = "i2s";
 			dai-tdm-slot-width = <32>;
+			mclk-fs = <256>;
 			cpu {
 				sound-dai = <&sti_uni_player2>;
 			};
@@ -144,6 +151,7 @@ Example of audio card declaration:
 		simple-audio-card,dai-link at 1 {
 			/* SPDIF */
 			format = "left_j";
+			mclk-fs = <128>;
 			cpu {
 				sound-dai = <&sti_uni_player3>;
 			};
-- 
1.9.1
