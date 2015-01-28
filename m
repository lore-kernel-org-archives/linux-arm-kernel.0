From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 28 Jan 2015 19:39:02 +0100
Subject: [PATCH 4/5] ARM: at91/dt: add SMC and HSMC nodes
In-Reply-To: <1422470343-25981-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1422470343-25981-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1422470343-25981-5-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All AT91 SoCs embed a SMC (Static Memory Controller) IP handling access
to external memory chips.
Add SMC nodes to AT91 DTs so that other IPs can reference it and configure
the memory bus appropriately.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi | 5 +++++
 arch/arm/boot/dts/at91sam9261.dtsi | 5 +++++
 arch/arm/boot/dts/at91sam9g45.dtsi | 5 +++++
 arch/arm/boot/dts/at91sam9n12.dtsi | 5 +++++
 arch/arm/boot/dts/at91sam9rl.dtsi  | 5 +++++
 arch/arm/boot/dts/at91sam9x5.dtsi  | 5 +++++
 arch/arm/boot/dts/sama5d3.dtsi     | 5 +++++
 arch/arm/boot/dts/sama5d4.dtsi     | 5 +++++
 8 files changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 8c6d57d..e393e21 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -99,6 +99,11 @@
 				reg = <0xffffea00 0x200>;
 			};
 
+			smc: smc at ffffec00 {
+				compatible = "atmel,at91sam9260-smc", "syscon";
+				reg = <0xffffec00 0x100>;
+			};
+
 			pmc: pmc at fffffc00 {
 				compatible = "atmel,at91sam9260-pmc";
 				reg = <0xfffffc00 0x100>;
diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index 410d954..e1cb31d 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -262,6 +262,11 @@
 				reg = <0xffffea00 0x200>;
 			};
 
+			smc: smc at ffffec00 {
+				compatible = "atmel,at91sam9260-smc", "syscon";
+				reg = <0xffffec00 0x100>;
+			};
+
 			matrix: matrix at ffffee00 {
 				compatible = "atmel,at91sam9261-bus-matrix", "syscon";
 				reg = <0xffffee00 0x200>;
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 0713160..a052585 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -113,6 +113,11 @@
 				clock-names = "ddrck";
 			};
 
+			smc: smc at ffffe800 {
+				compatible = "atmel,at91sam9260-smc", "syscon";
+				reg = <0xffffe800 0x100>;
+			};
+
 			pmc: pmc at fffffc00 {
 				compatible = "atmel,at91sam9g45-pmc";
 				reg = <0xfffffc00 0x100>;
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index c2666a7..275d981 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -96,6 +96,11 @@
 				clock-names = "ddrck";
 			};
 
+			smc: smc at ffffea00 {
+				compatible = "atmel,at91sam9260-smc", "syscon";
+				reg = <0xffffea00 0x100>;
+			};
+
 			pmc: pmc at fffffc00 {
 				compatible = "atmel,at91sam9n12-pmc";
 				reg = <0xfffffc00 0x200>;
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index 40f645b..75978f2f 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -368,6 +368,11 @@
 				reg = <0xffffea00 0x200>;
 			};
 
+			smc: smc at ffffec00 {
+				compatible = "atmel,at91sam9260-smc", "syscon";
+				reg = <0xffffec00 0x100>;
+			};
+
 			aic: interrupt-controller at fffff000 {
 				#interrupt-cells = <3>;
 				compatible = "atmel,at91rm9200-aic";
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index a8e35c2..85cf280 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -104,6 +104,11 @@
 				clock-names = "ddrck";
 			};
 
+			smc: smc at ffffea00 {
+				compatible = "atmel,at91sam9260-smc", "syscon";
+				reg = <0xffffea00 0x100>;
+			};
+
 			pmc: pmc at fffffc00 {
 				compatible = "atmel,at91sam9x5-pmc";
 				reg = <0xfffffc00 0x100>;
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 317566d..17ad07f 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -413,6 +413,11 @@
 				clock-names = "tdes_clk";
 			};
 
+			hsmc: hsmc at ffffc000 {
+				compatible = "atmel,sama5d3-smc", "syscon";
+				reg = <0xffffc000 0x700>;
+			};
+
 			dma0: dma-controller at ffffe600 {
 				compatible = "atmel,at91sam9g45-dma";
 				reg = <0xffffe600 0x200>;
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 51390ac..af95377 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -1007,6 +1007,11 @@
 				};
 			};
 
+			hsmc: hsmc at fc05c000 {
+				compatible = "atmel,sama5d3-smc", "syscon";
+				reg = <0xfc05c000 0x700>;
+			};
+
 			rstc at fc068600 {
 				compatible = "atmel,at91sam9g45-rstc";
 				reg = <0xfc068600 0x10>;
-- 
1.9.1
