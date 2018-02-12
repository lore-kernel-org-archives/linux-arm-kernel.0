From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Mon, 12 Feb 2018 15:43:09 +0100
Subject: [PATCH v2 11/12] ARM: dts: STi: Move clk_sysin clock ouside soc node
In-Reply-To: <1518446590-16800-1-git-send-email-patrice.chotard@st.com>
References: <1518446590-16800-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1518446590-16800-12-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

As clk_sysin node describes the external oscillator, there is no
reason to put it into soc node.
This allows to fix the following warnings when compiling
dtb with W=1 option :

arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /clocks/clk-sysin missing or empty reg/ranges property

arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
Node /clocks/clk-sysin missing or empty reg/ranges property

arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /clocks/clk-sysin missing or empty reg/ranges property

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v2: _ move clk_sys_in outside soc node

 arch/arm/boot/dts/stih407-clock.dtsi | 18 +++++++++---------
 arch/arm/boot/dts/stih410-clock.dtsi | 20 ++++++++++----------
 arch/arm/boot/dts/stih418-clock.dtsi | 20 ++++++++++----------
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
index 1bba47e06ebe..f4e21e2234c9 100644
--- a/arch/arm/boot/dts/stih407-clock.dtsi
+++ b/arch/arm/boot/dts/stih407-clock.dtsi
@@ -7,21 +7,21 @@
  */
 #include <dt-bindings/clock/stih407-clks.h>
 / {
+	/*
+	 * Fixed 30MHz oscillator inputs to SoC
+	 */
+	clk_sysin: clk-sysin {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <30000000>;
+	};
+
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
 
 		/*
-		 * Fixed 30MHz oscillator inputs to SoC
-		 */
-		clk_sysin: clk-sysin {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <30000000>;
-		};
-
-		/*
 		 * ARM Peripheral clock for timers
 		 */
 		arm_periph_clk: clk-m-a9-periphs at 0 {
diff --git a/arch/arm/boot/dts/stih410-clock.dtsi b/arch/arm/boot/dts/stih410-clock.dtsi
index 41fb1a910d49..9481f8769e8a 100644
--- a/arch/arm/boot/dts/stih410-clock.dtsi
+++ b/arch/arm/boot/dts/stih410-clock.dtsi
@@ -7,6 +7,16 @@
  */
 #include <dt-bindings/clock/stih410-clks.h>
 / {
+	/*
+	 * Fixed 30MHz oscillator inputs to SoC
+	 */
+	clk_sysin: clk-sysin {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <30000000>;
+		clock-output-names = "CLK_SYSIN";
+	};
+
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -15,16 +25,6 @@
 		compatible = "st,stih410-clk", "simple-bus";
 
 		/*
-		 * Fixed 30MHz oscillator inputs to SoC
-		 */
-		clk_sysin: clk-sysin {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <30000000>;
-			clock-output-names = "CLK_SYSIN";
-		};
-
-		/*
 		 * ARM Peripheral clock for timers
 		 */
 		arm_periph_clk: clk-m-a9-periphs at 0 {
diff --git a/arch/arm/boot/dts/stih418-clock.dtsi b/arch/arm/boot/dts/stih418-clock.dtsi
index 50413eabe73a..9e3790198f51 100644
--- a/arch/arm/boot/dts/stih418-clock.dtsi
+++ b/arch/arm/boot/dts/stih418-clock.dtsi
@@ -7,6 +7,16 @@
  */
 #include <dt-bindings/clock/stih418-clks.h>
 / {
+	/*
+	 * Fixed 30MHz oscillator inputs to SoC
+	 */
+	clk_sysin: clk-sysin {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <30000000>;
+		clock-output-names = "CLK_SYSIN";
+	};
+
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -15,16 +25,6 @@
 		compatible = "st,stih418-clk", "simple-bus";
 
 		/*
-		 * Fixed 30MHz oscillator inputs to SoC
-		 */
-		clk_sysin: clk-sysin {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <30000000>;
-			clock-output-names = "CLK_SYSIN";
-		};
-
-		/*
 		 * ARM Peripheral clock for timers
 		 */
 		arm_periph_clk: clk-m-a9-periphs at 0 {
-- 
1.9.1
