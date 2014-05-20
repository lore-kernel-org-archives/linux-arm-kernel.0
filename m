From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Tue, 20 May 2014 15:22:45 +0200
Subject: [PATCH v3 01/11] ARM: STi: DT: STiH41x: Rename CLK_SYSIN into
 clk_sysin
In-Reply-To: <1400592175-13176-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1400592175-13176-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1400592175-13176-2-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

all-caps node name is not very usual.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 arch/arm/boot/dts/stih415-clock.dtsi | 2 +-
 arch/arm/boot/dts/stih415.dtsi       | 8 ++++----
 arch/arm/boot/dts/stih416-clock.dtsi | 5 +++--
 arch/arm/boot/dts/stih416.dtsi       | 8 ++++----
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/stih415-clock.dtsi b/arch/arm/boot/dts/stih415-clock.dtsi
index d047dbc..8ef9964 100644
--- a/arch/arm/boot/dts/stih415-clock.dtsi
+++ b/arch/arm/boot/dts/stih415-clock.dtsi
@@ -10,7 +10,7 @@
 		/*
 		 * Fixed 30MHz oscillator input to SoC
 		 */
-		CLK_SYSIN: CLK_SYSIN {
+		clk_sysin: clk-sysin {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <30000000>;
diff --git a/arch/arm/boot/dts/stih415.dtsi b/arch/arm/boot/dts/stih415.dtsi
index d89064c..a2dafe9 100644
--- a/arch/arm/boot/dts/stih415.dtsi
+++ b/arch/arm/boot/dts/stih415.dtsi
@@ -91,7 +91,7 @@
 			status 		= "disabled";
 			reg		= <0xfe531000 0x2c>;
 			interrupts	= <0 210 0>;
-			clocks		= <&CLK_SYSIN>;
+			clocks		= <&clk_sysin>;
 			pinctrl-names 	= "default";
 			pinctrl-0	= <&pinctrl_sbc_serial1>;
 		};
@@ -126,7 +126,7 @@
 			compatible	= "st,comms-ssc4-i2c";
 			reg		= <0xfe540000 0x110>;
 			interrupts	= <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;
-			clocks		= <&CLK_SYSIN>;
+			clocks		= <&clk_sysin>;
 			clock-names	= "ssc";
 			clock-frequency = <400000>;
 			pinctrl-names	= "default";
@@ -139,7 +139,7 @@
 			compatible	= "st,comms-ssc4-i2c";
 			reg		= <0xfe541000 0x110>;
 			interrupts	= <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
-			clocks		= <&CLK_SYSIN>;
+			clocks		= <&clk_sysin>;
 			clock-names	= "ssc";
 			clock-frequency = <400000>;
 			pinctrl-names	= "default";
@@ -200,7 +200,7 @@
 			compatible	= "st,comms-irb";
 			reg		= <0xfe518000 0x234>;
 			interrupts	=  <0 203 0>;
-			clocks		= <&CLK_SYSIN>;
+			clocks		= <&clk_sysin>;
 			rx-mode		= "infrared";
 			pinctrl-names 	= "default";
 			pinctrl-0	= <&pinctrl_ir>;
diff --git a/arch/arm/boot/dts/stih416-clock.dtsi b/arch/arm/boot/dts/stih416-clock.dtsi
index a6942c7..10f8389 100644
--- a/arch/arm/boot/dts/stih416-clock.dtsi
+++ b/arch/arm/boot/dts/stih416-clock.dtsi
@@ -6,16 +6,17 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+
 / {
 	clocks {
+
 		/*
 		 * Fixed 30MHz oscillator inputs to SoC
 		 */
-		CLK_SYSIN: CLK_SYSIN {
+		clk_sysin: clk-sysin {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <30000000>;
-			clock-output-names = "CLK_SYSIN";
 		};
 
 		/*
diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index 78746d2..cc616b4 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -102,7 +102,7 @@
 			interrupts	= <0 210 0>;
 			pinctrl-names 	= "default";
 			pinctrl-0 	= <&pinctrl_sbc_serial1>;
-			clocks          = <&CLK_SYSIN>;
+			clocks          = <&clk_sysin>;
 		};
 
 		i2c at fed40000 {
@@ -135,7 +135,7 @@
 			compatible	= "st,comms-ssc4-i2c";
 			reg		= <0xfe540000 0x110>;
 			interrupts	= <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;
-			clocks		= <&CLK_SYSIN>;
+			clocks		= <&clk_sysin>;
 			clock-names	= "ssc";
 			clock-frequency = <400000>;
 			pinctrl-names	= "default";
@@ -148,7 +148,7 @@
 			compatible	= "st,comms-ssc4-i2c";
 			reg		= <0xfe541000 0x110>;
 			interrupts	= <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
-			clocks		= <&CLK_SYSIN>;
+			clocks		= <&clk_sysin>;
 			clock-names	= "ssc";
 			clock-frequency = <400000>;
 			pinctrl-names	= "default";
@@ -206,7 +206,7 @@
 			reg		= <0xfe518000 0x234>;
 			interrupts	=  <0 203 0>;
 			rx-mode         = "infrared";
-			clocks		= <&CLK_SYSIN>;
+			clocks		= <&clk_sysin>;
 			pinctrl-names 	= "default";
 			pinctrl-0	= <&pinctrl_ir>;
 			resets		= <&softreset STIH416_IRB_SOFTRESET>;
-- 
1.9.1
