From: nm@ti.com (Nishanth Menon)
Date: Fri, 15 Dec 2017 07:21:00 -0600
Subject: [PATCH 6/8] ARM: dts: keystone-hk-clocks: Add missing unit name to
 clock nodes that have regs
In-Reply-To: <20171215132102.435-1-nm@ti.com>
References: <20171215132102.435-1-nm@ti.com>
Message-ID: <20171215132102.435-7-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the control register as the base for the clock nodes which are
missing them. This squashes some 36 warnings of the effect when built
with W=1.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/keystone-k2hk-clocks.dtsi | 74 ++++++++++++++---------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/arch/arm/boot/dts/keystone-k2hk-clocks.dtsi b/arch/arm/boot/dts/keystone-k2hk-clocks.dtsi
index 142c8491ff54..c2a5fd19ff49 100644
--- a/arch/arm/boot/dts/keystone-k2hk-clocks.dtsi
+++ b/arch/arm/boot/dts/keystone-k2hk-clocks.dtsi
@@ -50,7 +50,7 @@ clocks {
 		reg-names = "control";
 	};
 
-	clktsip: clktsip {
+	clktsip: clktsip at 2350000 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk16>;
@@ -60,7 +60,7 @@ clocks {
 		domain-id = <0>;
 	};
 
-	clksrio: clksrio {
+	clksrio: clksrio at 235002c {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk1rstiso13>;
@@ -70,7 +70,7 @@ clocks {
 		domain-id = <4>;
 	};
 
-	clkhyperlink0: clkhyperlink0 {
+	clkhyperlink0: clkhyperlink0 at 2350030 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk12>;
@@ -80,7 +80,7 @@ clocks {
 		domain-id = <5>;
 	};
 
-	clkgem1: clkgem1 {
+	clkgem1: clkgem1 at 2350040 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk1>;
@@ -90,7 +90,7 @@ clocks {
 		domain-id = <9>;
 	};
 
-	clkgem2: clkgem2 {
+	clkgem2: clkgem2 at 2350044 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk1>;
@@ -100,7 +100,7 @@ clocks {
 		domain-id = <10>;
 	};
 
-	clkgem3: clkgem3 {
+	clkgem3: clkgem3 at 2350048 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk1>;
@@ -110,7 +110,7 @@ clocks {
 		domain-id = <11>;
 	};
 
-	clkgem4: clkgem4 {
+	clkgem4: clkgem4 at 235004c {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk1>;
@@ -120,7 +120,7 @@ clocks {
 		domain-id = <12>;
 	};
 
-	clkgem5: clkgem5 {
+	clkgem5: clkgem5 at 2350050 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk1>;
@@ -130,7 +130,7 @@ clocks {
 		domain-id = <13>;
 	};
 
-	clkgem6: clkgem6 {
+	clkgem6: clkgem6 at 2350054 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk1>;
@@ -140,7 +140,7 @@ clocks {
 		domain-id = <14>;
 	};
 
-	clkgem7: clkgem7 {
+	clkgem7: clkgem7 at 2350058 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk1>;
@@ -150,7 +150,7 @@ clocks {
 		domain-id = <15>;
 	};
 
-	clkddr31: clkddr31 {
+	clkddr31: clkddr31 at 2350060 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -160,7 +160,7 @@ clocks {
 		domain-id = <16>;
 	};
 
-	clktac: clktac {
+	clktac: clktac at 2350064 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -170,7 +170,7 @@ clocks {
 		domain-id = <17>;
 	};
 
-	clkrac01: clkrac01 {
+	clkrac01: clkrac01 at 2350068 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -180,7 +180,7 @@ clocks {
 		domain-id = <17>;
 	};
 
-	clkrac23: clkrac23 {
+	clkrac23: clkrac23 at 235006c {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -190,7 +190,7 @@ clocks {
 		domain-id = <18>;
 	};
 
-	clkfftc0: clkfftc0 {
+	clkfftc0: clkfftc0 at 2350070 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -200,7 +200,7 @@ clocks {
 		domain-id = <19>;
 	};
 
-	clkfftc1: clkfftc1 {
+	clkfftc1: clkfftc1 at 2350074 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -210,7 +210,7 @@ clocks {
 		domain-id = <19>;
 	};
 
-	clkfftc2: clkfftc2 {
+	clkfftc2: clkfftc2 at 2350078 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -220,7 +220,7 @@ clocks {
 		domain-id = <20>;
 	};
 
-	clkfftc3: clkfftc3 {
+	clkfftc3: clkfftc3 at 235007c {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -230,7 +230,7 @@ clocks {
 		domain-id = <20>;
 	};
 
-	clkfftc4: clkfftc4 {
+	clkfftc4: clkfftc4 at 2350080 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -240,7 +240,7 @@ clocks {
 		domain-id = <20>;
 	};
 
-	clkfftc5: clkfftc5 {
+	clkfftc5: clkfftc5 at 2350084 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -250,7 +250,7 @@ clocks {
 		domain-id = <20>;
 	};
 
-	clkaif: clkaif {
+	clkaif: clkaif at 2350088 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -260,7 +260,7 @@ clocks {
 		domain-id = <21>;
 	};
 
-	clktcp3d0: clktcp3d0 {
+	clktcp3d0: clktcp3d0 at 235008c {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -270,7 +270,7 @@ clocks {
 		domain-id = <22>;
 	};
 
-	clktcp3d1: clktcp3d1 {
+	clktcp3d1: clktcp3d1 at 2350090 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -280,7 +280,7 @@ clocks {
 		domain-id = <22>;
 	};
 
-	clktcp3d2: clktcp3d2 {
+	clktcp3d2: clktcp3d2 at 2350094 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -290,7 +290,7 @@ clocks {
 		domain-id = <23>;
 	};
 
-	clktcp3d3: clktcp3d3 {
+	clktcp3d3: clktcp3d3 at 2350098 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -300,7 +300,7 @@ clocks {
 		domain-id = <23>;
 	};
 
-	clkvcp0: clkvcp0 {
+	clkvcp0: clkvcp0 at 235009c {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -310,7 +310,7 @@ clocks {
 		domain-id = <24>;
 	};
 
-	clkvcp1: clkvcp1 {
+	clkvcp1: clkvcp1 at 23500a0 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -320,7 +320,7 @@ clocks {
 		domain-id = <24>;
 	};
 
-	clkvcp2: clkvcp2 {
+	clkvcp2: clkvcp2 at 23500a4 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -330,7 +330,7 @@ clocks {
 		domain-id = <24>;
 	};
 
-	clkvcp3: clkvcp3 {
+	clkvcp3: clkvcp3 at 23500a8 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -340,7 +340,7 @@ clocks {
 		domain-id = <24>;
 	};
 
-	clkvcp4: clkvcp4 {
+	clkvcp4: clkvcp4 at 23500ac {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -350,7 +350,7 @@ clocks {
 		domain-id = <25>;
 	};
 
-	clkvcp5: clkvcp5 {
+	clkvcp5: clkvcp5 at 23500b0 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -360,7 +360,7 @@ clocks {
 		domain-id = <25>;
 	};
 
-	clkvcp6: clkvcp6 {
+	clkvcp6: clkvcp6 at 23500b4 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -370,7 +370,7 @@ clocks {
 		domain-id = <25>;
 	};
 
-	clkvcp7: clkvcp7 {
+	clkvcp7: clkvcp7 at 23500b8 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -380,7 +380,7 @@ clocks {
 		domain-id = <25>;
 	};
 
-	clkbcp: clkbcp {
+	clkbcp: clkbcp at 23500bc {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -390,7 +390,7 @@ clocks {
 		domain-id = <26>;
 	};
 
-	clkdxb: clkdxb {
+	clkdxb: clkdxb at 23500c0 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -400,7 +400,7 @@ clocks {
 		domain-id = <27>;
 	};
 
-	clkhyperlink1: clkhyperlink1 {
+	clkhyperlink1: clkhyperlink1 at 23500c4 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk12>;
@@ -410,7 +410,7 @@ clocks {
 		domain-id = <28>;
 	};
 
-	clkxge: clkxge {
+	clkxge: clkxge at 23500c8 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
-- 
2.14.1
