From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Wed,  4 Jun 2014 16:32:49 +0200
Subject: [PATCH 1/4] ARM: STi: DT: STiH407: 407 DT Entry for clockgen A0
In-Reply-To: <1401892372-18279-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1401892372-18279-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1401892372-18279-2-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch adds DT entries for clockgen A0

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
Signed-off-by: Olivier Bideau <olivier.bideau@st.com>
---
 arch/arm/boot/dts/stih407-clock.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
index 800f46f..e03e86e 100644
--- a/arch/arm/boot/dts/stih407-clock.dtsi
+++ b/arch/arm/boot/dts/stih407-clock.dtsi
@@ -7,6 +7,10 @@
  */
 / {
 	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
 		/*
 		 * Fixed 30MHz oscillator inputs to SoC
 		 */
@@ -35,5 +39,33 @@
 			clock-frequency = <200000000>;
 			clock-output-names = "clk-s-icn-reg-0";
 		};
+
+		/*
+		 * ClockGenAs on SASG2
+		 */
+		clockgen-a at 090ff000 {
+			compatible = "st,clkgen-c32";
+			reg = <0x90ff000 0x1000>;
+
+			clk_s_a0_pll: clk-s-a0-pll {
+				#clock-cells = <1>;
+				compatible = "st,stih407-plls-c32-a0", "st,clkgen-plls-c32";
+
+				clocks = <&clk_sysin>;
+
+				clock-output-names = "clk-s-a0-pll-ofd-0";
+			};
+
+			clk_s_a0_flexgen: clk-s-a0-flexgen {
+				compatible = "st,flexgen";
+
+				#clock-cells = <1>;
+
+				clocks = <&clk_s_a0_pll 0>,
+					 <&clk_sysin>;
+
+				clock-output-names = "clk-ic-lmi0";
+			};
+		};
 	};
 };
-- 
1.9.1
