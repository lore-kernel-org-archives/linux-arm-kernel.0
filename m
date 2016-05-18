From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Wed, 18 May 2016 10:41:28 +0200
Subject: [PATCH 07/11] ARM: DT: STiH407: Enable synchronous clock mode on
 clkgend2
In-Reply-To: <1463560892-7209-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1463560892-7209-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1463560892-7209-8-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a compatibility string on clkgend2 to allow the clock
driver to handle the synchronous/asynchronous modes of STiH407

Signed-off-by: Olivier Bideau <olivier.bideau@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 arch/arm/boot/dts/stih407-clock.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
index 76c6984..bdf3998 100644
--- a/arch/arm/boot/dts/stih407-clock.dtsi
+++ b/arch/arm/boot/dts/stih407-clock.dtsi
@@ -256,7 +256,7 @@
 
 			clk_s_d2_flexgen: clk-s-d2-flexgen {
 				#clock-cells = <1>;
-				compatible = "st,flexgen";
+				compatible = "st,stih407-clkgend2", "st,flexgen";
 
 				clocks = <&clk_s_d2_quadfs 0>,
 					 <&clk_s_d2_quadfs 1>,
-- 
1.9.1
