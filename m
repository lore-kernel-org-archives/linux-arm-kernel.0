From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Mon, 12 Feb 2018 15:43:08 +0100
Subject: [PATCH v2 10/12] ARM: dts: STi: Add fake reg property for clocks
In-Reply-To: <1518446590-16800-1-git-send-email-patrice.chotard@st.com>
References: <1518446590-16800-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1518446590-16800-11-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

For all clock's element inside SoC, add a fake reg property,
this allows to fix the following warnings when compiling
dtb with W=1 option :

arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /clocks/clk-m-a9-periphs missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /clocks/clk-m-a9-ext2f-div2s missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /clocks/clk-tmdsout-hdmi missing or empty reg/ranges property

arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
Node /clocks/clk-m-a9-periphs missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
Node /clocks/clk-m-a9-ext2f-div2s missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
Node /clocks/clk-tmdsout-hdmi missing or empty reg/ranges property

arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /clocks/clk-m-a9-periphs missing or empty reg/ranges property
arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /clocks/clk-m-a9-ext2f-div2s missing or empty reg/ranges property
arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /clocks/clk-tmdsout-hdmi missing or empty reg/ranges property

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v2: _ add a fake reg property to node without reg property.

 arch/arm/boot/dts/stih407-clock.dtsi | 9 ++++++---
 arch/arm/boot/dts/stih410-clock.dtsi | 9 ++++++---
 arch/arm/boot/dts/stih418-clock.dtsi | 9 ++++++---
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
index b882dcf3a649..1bba47e06ebe 100644
--- a/arch/arm/boot/dts/stih407-clock.dtsi
+++ b/arch/arm/boot/dts/stih407-clock.dtsi
@@ -24,9 +24,10 @@
 		/*
 		 * ARM Peripheral clock for timers
 		 */
-		arm_periph_clk: clk-m-a9-periphs {
+		arm_periph_clk: clk-m-a9-periphs at 0 {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
+			reg = <0 0>;
 
 			clocks = <&clk_m_a9>;
 			clock-div = <2>;
@@ -67,9 +68,10 @@
 		/*
 		 * ARM Peripheral clock for timers
 		 */
-		clk_m_a9_ext2f_div2: clk-m-a9-ext2f-div2s {
+		clk_m_a9_ext2f_div2: clk-m-a9-ext2f-div2s at 0 {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
+			reg = <0 0>;
 
 			clocks = <&clk_s_c0_flexgen 13>;
 
@@ -254,9 +256,10 @@
 					     "clk-s-d2-fs0-ch3";
 		};
 
-		clk_tmdsout_hdmi: clk-tmdsout-hdmi {
+		clk_tmdsout_hdmi: clk-tmdsout-hdmi at 0 {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
+			reg = <0 0>;
 			clock-frequency = <0>;
 		};
 
diff --git a/arch/arm/boot/dts/stih410-clock.dtsi b/arch/arm/boot/dts/stih410-clock.dtsi
index 4df1b2187aa2..41fb1a910d49 100644
--- a/arch/arm/boot/dts/stih410-clock.dtsi
+++ b/arch/arm/boot/dts/stih410-clock.dtsi
@@ -27,9 +27,10 @@
 		/*
 		 * ARM Peripheral clock for timers
 		 */
-		arm_periph_clk: clk-m-a9-periphs {
+		arm_periph_clk: clk-m-a9-periphs at 0 {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
+			reg = <0 0>;
 			clocks = <&clk_m_a9>;
 			clock-div = <2>;
 			clock-mult = <1>;
@@ -69,9 +70,10 @@
 		/*
 		 * ARM Peripheral clock for timers
 		 */
-		clk_m_a9_ext2f_div2: clk-m-a9-ext2f-div2s {
+		clk_m_a9_ext2f_div2: clk-m-a9-ext2f-div2s at 0 {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
+			reg = <0 0>;
 
 			clocks = <&clk_s_c0_flexgen 13>;
 
@@ -266,9 +268,10 @@
 					     "clk-s-d2-fs0-ch3";
 		};
 
-		clk_tmdsout_hdmi: clk-tmdsout-hdmi {
+		clk_tmdsout_hdmi: clk-tmdsout-hdmi at 0 {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
+			reg = <0 0>;
 			clock-frequency = <0>;
 		};
 
diff --git a/arch/arm/boot/dts/stih418-clock.dtsi b/arch/arm/boot/dts/stih418-clock.dtsi
index e68bf28bd038..50413eabe73a 100644
--- a/arch/arm/boot/dts/stih418-clock.dtsi
+++ b/arch/arm/boot/dts/stih418-clock.dtsi
@@ -27,9 +27,10 @@
 		/*
 		 * ARM Peripheral clock for timers
 		 */
-		arm_periph_clk: clk-m-a9-periphs {
+		arm_periph_clk: clk-m-a9-periphs at 0 {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
+			reg = <0 0>;
 			clocks = <&clk_m_a9>;
 			clock-div = <2>;
 			clock-mult = <1>;
@@ -69,9 +70,10 @@
 		/*
 		 * ARM Peripheral clock for timers
 		 */
-		clk_m_a9_ext2f_div2: clk-m-a9-ext2f-div2s {
+		clk_m_a9_ext2f_div2: clk-m-a9-ext2f-div2s at 0 {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
+			reg = <0 0>;
 
 			clocks = <&clk_s_c0_flexgen 13>;
 
@@ -259,9 +261,10 @@
 					     "clk-s-d2-fs0-ch3";
 		};
 
-		clk_tmdsout_hdmi: clk-tmdsout-hdmi {
+		clk_tmdsout_hdmi: clk-tmdsout-hdmi at 0 {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
+			reg = <0 0>;
 			clock-frequency = <0>;
 		};
 
-- 
1.9.1
