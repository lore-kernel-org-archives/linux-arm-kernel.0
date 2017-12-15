From: nm@ti.com (Nishanth Menon)
Date: Fri, 15 Dec 2017 07:20:59 -0600
Subject: [PATCH 5/8] ARM: dts: keystone-clocks: Add missing unit name to clock
 nodes that have regs
In-Reply-To: <20171215132102.435-1-nm@ti.com>
References: <20171215132102.435-1-nm@ti.com>
Message-ID: <20171215132102.435-6-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the control register as the base for the clock nodes which are
missing them. This squashes some 78 warnings of the effect when built
with W=1.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/keystone-clocks.dtsi | 52 +++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/keystone-clocks.dtsi b/arch/arm/boot/dts/keystone-clocks.dtsi
index 2391e3e4d234..0d735e0288db 100644
--- a/arch/arm/boot/dts/keystone-clocks.dtsi
+++ b/arch/arm/boot/dts/keystone-clocks.dtsi
@@ -48,7 +48,7 @@ clocks {
 		clock-output-names = "gemtraceclk";
 	};
 
-	chipstmxptclk: chipstmxptclk {
+	chipstmxptclk: chipstmxptclk at 2310164 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,pll-divider-clock";
 		clocks = <&mainmuxclk>;
@@ -157,7 +157,7 @@ clocks {
 		clock-output-names = "chipclk1rstiso112";
 	};
 
-	clkmodrst0: clkmodrst0 {
+	clkmodrst0: clkmodrst0 at 2350000 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk16>;
@@ -168,7 +168,7 @@ clocks {
 	};
 
 
-	clkusb: clkusb {
+	clkusb: clkusb at 2350008 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk16>;
@@ -178,7 +178,7 @@ clocks {
 		domain-id = <0>;
 	};
 
-	clkaemifspi: clkaemifspi {
+	clkaemifspi: clkaemifspi at 235000c {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk16>;
@@ -189,7 +189,7 @@ clocks {
 	};
 
 
-	clkdebugsstrc: clkdebugsstrc {
+	clkdebugsstrc: clkdebugsstrc at 2350014 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -199,7 +199,7 @@ clocks {
 		domain-id = <1>;
 	};
 
-	clktetbtrc: clktetbtrc {
+	clktetbtrc: clktetbtrc at 2350018 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
@@ -209,7 +209,7 @@ clocks {
 		domain-id = <1>;
 	};
 
-	clkpa: clkpa {
+	clkpa: clkpa at 235001c {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&paclk13>;
@@ -219,7 +219,7 @@ clocks {
 		domain-id = <2>;
 	};
 
-	clkcpgmac: clkcpgmac {
+	clkcpgmac: clkcpgmac at 2350020 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&clkpa>;
@@ -229,7 +229,7 @@ clocks {
 		domain-id = <2>;
 	};
 
-	clksa: clksa {
+	clksa: clksa at 2350024 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&clkpa>;
@@ -239,7 +239,7 @@ clocks {
 		domain-id = <2>;
 	};
 
-	clkpcie: clkpcie {
+	clkpcie: clkpcie at 2350028 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk12>;
@@ -249,7 +249,7 @@ clocks {
 		domain-id = <3>;
 	};
 
-	clksr: clksr {
+	clksr: clksr at 2350034 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk1rstiso112>;
@@ -259,7 +259,7 @@ clocks {
 		domain-id = <6>;
 	};
 
-	clkgem0: clkgem0 {
+	clkgem0: clkgem0 at 235003c {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk1>;
@@ -269,7 +269,7 @@ clocks {
 		domain-id = <8>;
 	};
 
-	clkddr30: clkddr30 {
+	clkddr30: clkddr30 at 235005c {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk12>;
@@ -279,7 +279,7 @@ clocks {
 		domain-id = <16>;
 	};
 
-	clkwdtimer0: clkwdtimer0 {
+	clkwdtimer0: clkwdtimer0 at 2350000 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&clkmodrst0>;
@@ -289,7 +289,7 @@ clocks {
 		domain-id = <0>;
 	};
 
-	clkwdtimer1: clkwdtimer1 {
+	clkwdtimer1: clkwdtimer1 at 2350000 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&clkmodrst0>;
@@ -299,7 +299,7 @@ clocks {
 		domain-id = <0>;
 	};
 
-	clkwdtimer2: clkwdtimer2 {
+	clkwdtimer2: clkwdtimer2 at 2350000 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&clkmodrst0>;
@@ -309,7 +309,7 @@ clocks {
 		domain-id = <0>;
 	};
 
-	clkwdtimer3: clkwdtimer3 {
+	clkwdtimer3: clkwdtimer3 at 2350000 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&clkmodrst0>;
@@ -319,7 +319,7 @@ clocks {
 		domain-id = <0>;
 	};
 
-	clktimer15: clktimer15 {
+	clktimer15: clktimer15 at 2350000 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&clkmodrst0>;
@@ -329,7 +329,7 @@ clocks {
 		domain-id = <0>;
 	};
 
-	clkuart0: clkuart0 {
+	clkuart0: clkuart0 at 2350000 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&clkmodrst0>;
@@ -339,7 +339,7 @@ clocks {
 		domain-id = <0>;
 	};
 
-	clkuart1: clkuart1 {
+	clkuart1: clkuart1 at 2350000 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&clkmodrst0>;
@@ -349,7 +349,7 @@ clocks {
 		domain-id = <0>;
 	};
 
-	clkaemif: clkaemif {
+	clkaemif: clkaemif at 2350000 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&clkaemifspi>;
@@ -359,7 +359,7 @@ clocks {
 		domain-id = <0>;
 	};
 
-	clkusim: clkusim {
+	clkusim: clkusim at 2350000 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&clkmodrst0>;
@@ -369,7 +369,7 @@ clocks {
 		domain-id = <0>;
 	};
 
-	clki2c: clki2c {
+	clki2c: clki2c at 2350000 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&clkmodrst0>;
@@ -379,7 +379,7 @@ clocks {
 		domain-id = <0>;
 	};
 
-	clkspi: clkspi {
+	clkspi: clkspi at 2350000 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&clkaemifspi>;
@@ -389,7 +389,7 @@ clocks {
 		domain-id = <0>;
 	};
 
-	clkgpio: clkgpio {
+	clkgpio: clkgpio at 2350000 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&clkmodrst0>;
@@ -399,7 +399,7 @@ clocks {
 		domain-id = <0>;
 	};
 
-	clkkeymgr: clkkeymgr {
+	clkkeymgr: clkkeymgr at 2350000 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&clkmodrst0>;
-- 
2.14.1
