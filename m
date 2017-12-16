From: nm@ti.com (Nishanth Menon)
Date: Sat, 16 Dec 2017 14:40:40 -0600
Subject: [PATCH V2 8/8] ARM: dts: keystone-k2l-clocks: Add missing unit name
 to clock nodes that have regs
In-Reply-To: <20171216204040.18017-1-nm@ti.com>
References: <20171215132102.435-1-nm@ti.com> <20171216204040.18017-1-nm@ti.com>
Message-ID: <20171216204040.18017-9-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the control register as the base for the clock nodes which are
missing them. This squashes some 22 warnings of the effect when built
with W=1.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V1: rebase

V1: https://patchwork.kernel.org/patch/10115123/

 arch/arm/boot/dts/keystone-k2l-clocks.dtsi | 44 +++++++++++++++---------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/keystone-k2l-clocks.dtsi b/arch/arm/boot/dts/keystone-k2l-clocks.dtsi
index b3f82040a722..635528064dea 100644
--- a/arch/arm/boot/dts/keystone-k2l-clocks.dtsi
+++ b/arch/arm/boot/dts/keystone-k2l-clocks.dtsi
@@ -41,7 +41,7 @@ clocks {
 		reg-names = "control";
 	};
 
-	clkdfeiqnsys: clkdfeiqnsys {
+	clkdfeiqnsys: clkdfeiqnsys at 2350004 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk12>;
@@ -51,7 +51,7 @@ clocks {
 		domain-id = <0>;
 	};
 
-	clkpcie1: clkpcie1 {
+	clkpcie1: clkpcie1 at 235002c {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk12>;
@@ -61,7 +61,7 @@ clocks {
 		domain-id = <4>;
 	};
 
-	clkgem1: clkgem1 {
+	clkgem1: clkgem1 at 2350040 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk1>;
@@ -71,7 +71,7 @@ clocks {
 		domain-id = <9>;
 	};
 
-	clkgem2: clkgem2 {
+	clkgem2: clkgem2 at 2350044 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk1>;
@@ -81,7 +81,7 @@ clocks {
 		domain-id = <10>;
 	};
 
-	clkgem3: clkgem3 {
+	clkgem3: clkgem3 at 2350048 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk1>;
@@ -91,7 +91,7 @@ clocks {
 		domain-id = <11>;
 	};
 
-	clktac: clktac {
+	clktac: clktac at 2350064 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -101,7 +101,7 @@ clocks {
 		domain-id = <17>;
 	};
 
-	clkrac: clkrac {
+	clkrac: clkrac at 2350068 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -111,7 +111,7 @@ clocks {
 		domain-id = <17>;
 	};
 
-	clkdfepd0: clkdfepd0 {
+	clkdfepd0: clkdfepd0 at 235006c {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -121,7 +121,7 @@ clocks {
 		domain-id = <18>;
 	};
 
-	clkfftc0: clkfftc0 {
+	clkfftc0: clkfftc0 at 2350070 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -131,7 +131,7 @@ clocks {
 		domain-id = <19>;
 	};
 
-	clkosr: clkosr {
+	clkosr: clkosr at 2350088 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -141,7 +141,7 @@ clocks {
 		domain-id = <21>;
 	};
 
-	clktcp3d0: clktcp3d0 {
+	clktcp3d0: clktcp3d0 at 235008c {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -151,7 +151,7 @@ clocks {
 		domain-id = <22>;
 	};
 
-	clktcp3d1: clktcp3d1 {
+	clktcp3d1: clktcp3d1 at 2350094 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -161,7 +161,7 @@ clocks {
 		domain-id = <23>;
 	};
 
-	clkvcp0: clkvcp0 {
+	clkvcp0: clkvcp0 at 235009c {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -171,7 +171,7 @@ clocks {
 		domain-id = <24>;
 	};
 
-	clkvcp1: clkvcp1 {
+	clkvcp1: clkvcp1 at 23500a0 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -181,7 +181,7 @@ clocks {
 		domain-id = <24>;
 	};
 
-	clkvcp2: clkvcp2 {
+	clkvcp2: clkvcp2 at 23500a4 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -191,7 +191,7 @@ clocks {
 		domain-id = <24>;
 	};
 
-	clkvcp3: clkvcp3 {
+	clkvcp3: clkvcp3 at 23500a8 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -201,7 +201,7 @@ clocks {
 		domain-id = <24>;
 	};
 
-	clkbcp: clkbcp {
+	clkbcp: clkbcp at 23500bc {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -211,7 +211,7 @@ clocks {
 		domain-id = <26>;
 	};
 
-	clkdfepd1: clkdfepd1 {
+	clkdfepd1: clkdfepd1 at 23500c0 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -221,7 +221,7 @@ clocks {
 		domain-id = <27>;
 	};
 
-	clkfftc1: clkfftc1 {
+	clkfftc1: clkfftc1 at 23500c4 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -231,7 +231,7 @@ clocks {
 		domain-id = <28>;
 	};
 
-	clkiqnail: clkiqnail {
+	clkiqnail: clkiqnail at 23500c8 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -241,7 +241,7 @@ clocks {
 		domain-id = <29>;
 	};
 
-	clkuart2: clkuart2 {
+	clkuart2: clkuart2 at 2350000 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&clkmodrst0>;
@@ -251,7 +251,7 @@ clocks {
 		domain-id = <0>;
 	};
 
-	clkuart3: clkuart3 {
+	clkuart3: clkuart3 at 2350000 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&clkmodrst0>;
-- 
2.14.1
