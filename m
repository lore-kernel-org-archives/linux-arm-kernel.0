From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 28 Jan 2016 10:29:35 +0900
Subject: [PATCH] ARM: dts: r7s72100: use GIC_* defines
Message-ID: <1453944575-24667-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use GIC_* defines for GIC interrupt cells in r7s72100 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Based on renesas-devel-20160127-v4.5-rc1
---
 arch/arm/boot/dts/r7s72100.dtsi | 161 ++++++++++++++++++++--------------------
 1 file changed, 81 insertions(+), 80 deletions(-)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index 4657d7fb5bce..a5938c72d5bd 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -10,6 +10,7 @@
  */
 
 #include <dt-bindings/clock/r7s72100-clock.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
@@ -152,10 +153,10 @@
 	scif0: serial at e8007000 {
 		compatible = "renesas,scif-r7s72100", "renesas,scif";
 		reg = <0xe8007000 64>;
-		interrupts = <0 190 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 191 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 192 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 189 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF0>;
 		clock-names = "sci_ick";
 		power-domains = <&cpg_clocks>;
@@ -165,10 +166,10 @@
 	scif1: serial at e8007800 {
 		compatible = "renesas,scif-r7s72100", "renesas,scif";
 		reg = <0xe8007800 64>;
-		interrupts = <0 194 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 195 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 196 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 193 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF1>;
 		clock-names = "sci_ick";
 		power-domains = <&cpg_clocks>;
@@ -178,10 +179,10 @@
 	scif2: serial at e8008000 {
 		compatible = "renesas,scif-r7s72100", "renesas,scif";
 		reg = <0xe8008000 64>;
-		interrupts = <0 198 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 199 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 200 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 197 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF2>;
 		clock-names = "sci_ick";
 		power-domains = <&cpg_clocks>;
@@ -191,10 +192,10 @@
 	scif3: serial at e8008800 {
 		compatible = "renesas,scif-r7s72100", "renesas,scif";
 		reg = <0xe8008800 64>;
-		interrupts = <0 202 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 203 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 204 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 201 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF3>;
 		clock-names = "sci_ick";
 		power-domains = <&cpg_clocks>;
@@ -204,10 +205,10 @@
 	scif4: serial at e8009000 {
 		compatible = "renesas,scif-r7s72100", "renesas,scif";
 		reg = <0xe8009000 64>;
-		interrupts = <0 206 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 207 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 208 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 205 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF4>;
 		clock-names = "sci_ick";
 		power-domains = <&cpg_clocks>;
@@ -217,10 +218,10 @@
 	scif5: serial at e8009800 {
 		compatible = "renesas,scif-r7s72100", "renesas,scif";
 		reg = <0xe8009800 64>;
-		interrupts = <0 210 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 211 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 212 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 209 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF5>;
 		clock-names = "sci_ick";
 		power-domains = <&cpg_clocks>;
@@ -230,10 +231,10 @@
 	scif6: serial at e800a000 {
 		compatible = "renesas,scif-r7s72100", "renesas,scif";
 		reg = <0xe800a000 64>;
-		interrupts = <0 214 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 215 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 216 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 213 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF6>;
 		clock-names = "sci_ick";
 		power-domains = <&cpg_clocks>;
@@ -243,10 +244,10 @@
 	scif7: serial at e800a800 {
 		compatible = "renesas,scif-r7s72100", "renesas,scif";
 		reg = <0xe800a800 64>;
-		interrupts = <0 218 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 219 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 220 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 217 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF7>;
 		clock-names = "sci_ick";
 		power-domains = <&cpg_clocks>;
@@ -256,9 +257,9 @@
 	spi0: spi at e800c800 {
 		compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
 		reg = <0xe800c800 0x24>;
-		interrupts = <0 238 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 239 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 240 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "error", "rx", "tx";
 		clocks = <&mstp10_clks R7S72100_CLK_SPI0>;
 		power-domains = <&cpg_clocks>;
@@ -271,9 +272,9 @@
 	spi1: spi at e800d000 {
 		compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
 		reg = <0xe800d000 0x24>;
-		interrupts = <0 241 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 242 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 243 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "error", "rx", "tx";
 		clocks = <&mstp10_clks R7S72100_CLK_SPI1>;
 		power-domains = <&cpg_clocks>;
@@ -286,9 +287,9 @@
 	spi2: spi at e800d800 {
 		compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
 		reg = <0xe800d800 0x24>;
-		interrupts = <0 244 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 245 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 246 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "error", "rx", "tx";
 		clocks = <&mstp10_clks R7S72100_CLK_SPI2>;
 		power-domains = <&cpg_clocks>;
@@ -301,9 +302,9 @@
 	spi3: spi at e800e000 {
 		compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
 		reg = <0xe800e000 0x24>;
-		interrupts = <0 247 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 248 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 249 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "error", "rx", "tx";
 		clocks = <&mstp10_clks R7S72100_CLK_SPI3>;
 		power-domains = <&cpg_clocks>;
@@ -316,9 +317,9 @@
 	spi4: spi at e800e800 {
 		compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
 		reg = <0xe800e800 0x24>;
-		interrupts = <0 250 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 251 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 252 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "error", "rx", "tx";
 		clocks = <&mstp10_clks R7S72100_CLK_SPI4>;
 		power-domains = <&cpg_clocks>;
@@ -342,14 +343,14 @@
 		#size-cells = <0>;
 		compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
 		reg = <0xfcfee000 0x44>;
-		interrupts = <0 157 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 158 IRQ_TYPE_EDGE_RISING>,
-			     <0 159 IRQ_TYPE_EDGE_RISING>,
-			     <0 160 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 161 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 162 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 163 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 164 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 158 IRQ_TYPE_EDGE_RISING>,
+			     <GIC_SPI 159 IRQ_TYPE_EDGE_RISING>,
+			     <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R7S72100_CLK_I2C0>;
 		clock-frequency = <100000>;
 		power-domains = <&cpg_clocks>;
@@ -361,14 +362,14 @@
 		#size-cells = <0>;
 		compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
 		reg = <0xfcfee400 0x44>;
-		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 166 IRQ_TYPE_EDGE_RISING>,
-			     <0 167 IRQ_TYPE_EDGE_RISING>,
-			     <0 168 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 169 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 170 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 171 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 172 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 166 IRQ_TYPE_EDGE_RISING>,
+			     <GIC_SPI 167 IRQ_TYPE_EDGE_RISING>,
+			     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R7S72100_CLK_I2C1>;
 		clock-frequency = <100000>;
 		power-domains = <&cpg_clocks>;
@@ -380,14 +381,14 @@
 		#size-cells = <0>;
 		compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
 		reg = <0xfcfee800 0x44>;
-		interrupts = <0 173 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 174 IRQ_TYPE_EDGE_RISING>,
-			     <0 175 IRQ_TYPE_EDGE_RISING>,
-			     <0 176 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 177 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 178 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 179 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 180 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 174 IRQ_TYPE_EDGE_RISING>,
+			     <GIC_SPI 175 IRQ_TYPE_EDGE_RISING>,
+			     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R7S72100_CLK_I2C2>;
 		clock-frequency = <100000>;
 		power-domains = <&cpg_clocks>;
@@ -399,14 +400,14 @@
 		#size-cells = <0>;
 		compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
 		reg = <0xfcfeec00 0x44>;
-		interrupts = <0 181 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 182 IRQ_TYPE_EDGE_RISING>,
-			     <0 183 IRQ_TYPE_EDGE_RISING>,
-			     <0 184 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 185 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 186 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 187 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 188 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 182 IRQ_TYPE_EDGE_RISING>,
+			     <GIC_SPI 183 IRQ_TYPE_EDGE_RISING>,
+			     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R7S72100_CLK_I2C3>;
 		clock-frequency = <100000>;
 		power-domains = <&cpg_clocks>;
@@ -416,7 +417,7 @@
 	mtu2: timer at fcff0000 {
 		compatible = "renesas,mtu2-r7s72100", "renesas,mtu2";
 		reg = <0xfcff0000 0x400>;
-		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "tgi0a";
 		clocks = <&mstp3_clks R7S72100_CLK_MTU2>;
 		clock-names = "fck";
-- 
2.1.4
