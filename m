From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Mon, 29 Aug 2016 14:26:55 +0200
Subject: [PATCH v3 03/14] ARM: DT: STiH4xx: Simplify clock binding of STiH4xx
 platforms
In-Reply-To: <1472473626-15398-1-git-send-email-gabriel.fernandez@st.com>
References: <1472473626-15398-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1472473626-15398-4-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch simplifies the clock binding because we had too much detail.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 arch/arm/boot/dts/stih407-clock.dtsi | 18 +++++++++---------
 arch/arm/boot/dts/stih410-clock.dtsi | 16 ++++++++--------
 arch/arm/boot/dts/stih418-clock.dtsi | 16 ++++++++--------
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
index ad45f5e..38a56d7 100644
--- a/arch/arm/boot/dts/stih407-clock.dtsi
+++ b/arch/arm/boot/dts/stih407-clock.dtsi
@@ -42,7 +42,7 @@
 
 			clockgen_a9_pll: clockgen-a9-pll {
 				#clock-cells = <1>;
-				compatible = "st,stih407-plls-c32-a9", "st,clkgen-plls-c32";
+				compatible = "st,stih407-clkgen-plla9";
 
 				clocks = <&clk_sysin>;
 
@@ -55,7 +55,7 @@
 		 */
 		clk_m_a9: clk-m-a9 at 92b0000 {
 			#clock-cells = <0>;
-			compatible = "st,stih407-clkgen-a9-mux", "st,clkgen-mux";
+			compatible = "st,stih407-clkgen-a9-mux";
 			reg = <0x92b0000 0x10000>;
 
 			clocks = <&clockgen_a9_pll 0>,
@@ -96,7 +96,7 @@
 
 			clk_s_a0_pll: clk-s-a0-pll {
 				#clock-cells = <1>;
-				compatible = "st,stih407-plls-c32-a0", "st,clkgen-plls-c32";
+				compatible = "st,clkgen-pll0";
 
 				clocks = <&clk_sysin>;
 
@@ -117,7 +117,7 @@
 
 		clk_s_c0_quadfs: clk-s-c0-quadfs at 9103000 {
 			#clock-cells = <1>;
-			compatible = "st,stih407-quadfs660-C", "st,quadfs";
+			compatible = "st,quadfs-pll";
 			reg = <0x9103000 0x1000>;
 
 			clocks = <&clk_sysin>;
@@ -134,7 +134,7 @@
 
 			clk_s_c0_pll0: clk-s-c0-pll0 {
 				#clock-cells = <1>;
-				compatible = "st,plls-c32-cx_0", "st,clkgen-plls-c32";
+				compatible = "st,clkgen-pll0";
 
 				clocks = <&clk_sysin>;
 
@@ -143,7 +143,7 @@
 
 			clk_s_c0_pll1: clk-s-c0-pll1 {
 				#clock-cells = <1>;
-				compatible = "st,plls-c32-cx_1", "st,clkgen-plls-c32";
+				compatible = "st,clkgen-pll1";
 
 				clocks = <&clk_sysin>;
 
@@ -199,7 +199,7 @@
 
 		clk_s_d0_quadfs: clk-s-d0-quadfs at 9104000 {
 			#clock-cells = <1>;
-			compatible = "st,stih407-quadfs660-D", "st,quadfs";
+			compatible = "st,quadfs";
 			reg = <0x9104000 0x1000>;
 
 			clocks = <&clk_sysin>;
@@ -233,7 +233,7 @@
 
 		clk_s_d2_quadfs: clk-s-d2-quadfs at 9106000 {
 			#clock-cells = <1>;
-			compatible = "st,stih407-quadfs660-D", "st,quadfs";
+			compatible = "st,quadfs";
 			reg = <0x9106000 0x1000>;
 
 			clocks = <&clk_sysin>;
@@ -287,7 +287,7 @@
 
 		clk_s_d3_quadfs: clk-s-d3-quadfs at 9107000 {
 			#clock-cells = <1>;
-			compatible = "st,stih407-quadfs660-D", "st,quadfs";
+			compatible = "st,quadfs";
 			reg = <0x9107000 0x1000>;
 
 			clocks = <&clk_sysin>;
diff --git a/arch/arm/boot/dts/stih410-clock.dtsi b/arch/arm/boot/dts/stih410-clock.dtsi
index fd50496..e8f4d44 100644
--- a/arch/arm/boot/dts/stih410-clock.dtsi
+++ b/arch/arm/boot/dts/stih410-clock.dtsi
@@ -44,7 +44,7 @@
 
 			clockgen_a9_pll: clockgen-a9-pll {
 				#clock-cells = <1>;
-				compatible = "st,stih407-plls-c32-a9", "st,clkgen-plls-c32";
+				compatible = "st,stih407-clkgen-plla9";
 
 				clocks = <&clk_sysin>;
 
@@ -98,7 +98,7 @@
 
 			clk_s_a0_pll: clk-s-a0-pll {
 				#clock-cells = <1>;
-				compatible = "st,stih407-plls-c32-a0", "st,clkgen-plls-c32";
+				compatible = "st,clkgen-pll0";
 
 				clocks = <&clk_sysin>;
 
@@ -122,7 +122,7 @@
 
 		clk_s_c0_quadfs: clk-s-c0-quadfs at 9103000 {
 			#clock-cells = <1>;
-			compatible = "st,stih407-quadfs660-C", "st,quadfs";
+			compatible = "st,quadfs-pll";
 			reg = <0x9103000 0x1000>;
 
 			clocks = <&clk_sysin>;
@@ -140,7 +140,7 @@
 
 			clk_s_c0_pll0: clk-s-c0-pll0 {
 				#clock-cells = <1>;
-				compatible = "st,plls-c32-cx_0", "st,clkgen-plls-c32";
+				compatible = "st,clkgen-pll0";
 
 				clocks = <&clk_sysin>;
 
@@ -150,7 +150,7 @@
 
 			clk_s_c0_pll1: clk-s-c0-pll1 {
 				#clock-cells = <1>;
-				compatible = "st,plls-c32-cx_1", "st,clkgen-plls-c32";
+				compatible = "st,clkgen-pll1";
 
 				clocks = <&clk_sysin>;
 
@@ -218,7 +218,7 @@
 
 		clk_s_d0_quadfs: clk-s-d0-quadfs at 9104000 {
 			#clock-cells = <1>;
-			compatible = "st,stih407-quadfs660-D", "st,quadfs";
+			compatible = "st,quadfs";
 			reg = <0x9104000 0x1000>;
 
 			clocks = <&clk_sysin>;
@@ -254,7 +254,7 @@
 
 		clk_s_d2_quadfs: clk-s-d2-quadfs at 9106000 {
 			#clock-cells = <1>;
-			compatible = "st,stih407-quadfs660-D", "st,quadfs";
+			compatible = "st,quadfs";
 			reg = <0x9106000 0x1000>;
 
 			clocks = <&clk_sysin>;
@@ -308,7 +308,7 @@
 
 		clk_s_d3_quadfs: clk-s-d3-quadfs at 9107000 {
 			#clock-cells = <1>;
-			compatible = "st,stih407-quadfs660-D", "st,quadfs";
+			compatible = "st,quadfs";
 			reg = <0x9107000 0x1000>;
 
 			clocks = <&clk_sysin>;
diff --git a/arch/arm/boot/dts/stih418-clock.dtsi b/arch/arm/boot/dts/stih418-clock.dtsi
index ae6d997..0fd0fa5 100644
--- a/arch/arm/boot/dts/stih418-clock.dtsi
+++ b/arch/arm/boot/dts/stih418-clock.dtsi
@@ -44,7 +44,7 @@
 
 			clockgen_a9_pll: clockgen-a9-pll {
 				#clock-cells = <1>;
-				compatible = "st,stih418-plls-c28-a9", "st,clkgen-plls-c32";
+				compatible = "st,stih418-clkgen-plla9";
 
 				clocks = <&clk_sysin>;
 
@@ -98,7 +98,7 @@
 
 			clk_s_a0_pll: clk-s-a0-pll {
 				#clock-cells = <1>;
-				compatible = "st,stih407-plls-c32-a0", "st,clkgen-plls-c32";
+				compatible = "st,clkgen-pll0";
 
 				clocks = <&clk_sysin>;
 
@@ -120,7 +120,7 @@
 
 		clk_s_c0_quadfs: clk-s-c0-quadfs at 9103000 {
 			#clock-cells = <1>;
-			compatible = "st,stih407-quadfs660-C", "st,quadfs";
+			compatible = "st,quadfs-pll";
 			reg = <0x9103000 0x1000>;
 
 			clocks = <&clk_sysin>;
@@ -137,7 +137,7 @@
 
 			clk_s_c0_pll0: clk-s-c0-pll0 {
 				#clock-cells = <1>;
-				compatible = "st,plls-c32-cx_0", "st,clkgen-plls-c32";
+				compatible = "st,clkgen-pll0";
 
 				clocks = <&clk_sysin>;
 
@@ -146,7 +146,7 @@
 
 			clk_s_c0_pll1: clk-s-c0-pll1 {
 				#clock-cells = <1>;
-				compatible = "st,plls-c32-cx_1", "st,clkgen-plls-c32";
+				compatible = "st,clkgen-pll1";
 
 				clocks = <&clk_sysin>;
 
@@ -212,7 +212,7 @@
 
 		clk_s_d0_quadfs: clk-s-d0-quadfs at 9104000 {
 			#clock-cells = <1>;
-			compatible = "st,stih407-quadfs660-D", "st,quadfs";
+			compatible = "st,quadfs";
 			reg = <0x9104000 0x1000>;
 
 			clocks = <&clk_sysin>;
@@ -248,7 +248,7 @@
 
 		clk_s_d2_quadfs: clk-s-d2-quadfs at 9106000 {
 			#clock-cells = <1>;
-			compatible = "st,stih407-quadfs660-D", "st,quadfs";
+			compatible = "st,quadfs";
 			reg = <0x9106000 0x1000>;
 
 			clocks = <&clk_sysin>;
@@ -309,7 +309,7 @@
 
 		clk_s_d3_quadfs: clk-s-d3-quadfs at 9107000 {
 			#clock-cells = <1>;
-			compatible = "st,stih407-quadfs660-D", "st,quadfs";
+			compatible = "st,quadfs";
 			reg = <0x9107000 0x1000>;
 
 			clocks = <&clk_sysin>;
-- 
1.9.1
