From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Mon, 29 Aug 2016 14:27:00 +0200
Subject: [PATCH v3 08/14] ARM: DT: STiH410: Enable clock propagation for audio
 clocks
In-Reply-To: <1472473626-15398-1-git-send-email-gabriel.fernandez@st.com>
References: <1472473626-15398-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1472473626-15398-9-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch is used in the clock driver to apply a clock propagation
flag on the audio clocks of STiH410

Signed-off-by: Olivier Bideau <olivier.bideau@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Acked-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih410-clock.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stih410-clock.dtsi b/arch/arm/boot/dts/stih410-clock.dtsi
index e8f4d44..aec2aa7 100644
--- a/arch/arm/boot/dts/stih410-clock.dtsi
+++ b/arch/arm/boot/dts/stih410-clock.dtsi
@@ -235,7 +235,7 @@
 
 			clk_s_d0_flexgen: clk-s-d0-flexgen {
 				#clock-cells = <1>;
-				compatible = "st,flexgen";
+				compatible = "st,flexgen-audio", "st,flexgen";
 
 				clocks = <&clk_s_d0_quadfs 0>,
 					 <&clk_s_d0_quadfs 1>,
-- 
1.9.1
