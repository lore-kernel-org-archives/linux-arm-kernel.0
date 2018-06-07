From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Thu,  7 Jun 2018 10:41:07 +0200
Subject: [PATCH 4/4] ARM: dts: fix PMC compatible
In-Reply-To: <20180607084107.4461-1-alexandre.belloni@bootlin.com>
References: <20180607084107.4461-1-alexandre.belloni@bootlin.com>
Message-ID: <20180607084107.4461-5-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make each SoC dtsi use its soc specific PMc compatible string. This solves
a potential issue on at91sam9261 and at91sam9263 when using suspend to RAM

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/boot/dts/at91sam9261.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9263.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi  | 2 +-
 arch/arm/boot/dts/sama5d4.dtsi     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index 53c63d0a418a..33f09d5ea020 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -590,7 +590,7 @@
 			};
 
 			pmc: pmc at fffffc00 {
-				compatible = "atmel,at91rm9200-pmc", "syscon";
+				compatible = "atmel,at91sam9261-pmc", "syscon";
 				reg = <0xfffffc00 0x100>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				interrupt-controller;
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 87fb0660ab5d..af68a86c9973 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -93,7 +93,7 @@
 			};
 
 			pmc: pmc at fffffc00 {
-				compatible = "atmel,at91rm9200-pmc", "syscon";
+				compatible = "atmel,at91sam9263-pmc", "syscon";
 				reg = <0xfffffc00 0x100>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				interrupt-controller;
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index bd001cca25a4..8fb22030f00b 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -832,7 +832,7 @@
 			};
 
 			pmc: pmc at fffffc00 {
-				compatible = "atmel,at91sam9g45-pmc", "syscon";
+				compatible = "atmel,at91sam9rl-pmc", "syscon";
 				reg = <0xfffffc00 0x100>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				interrupt-controller;
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 0cf9beddd556..92a35a1942b6 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -392,7 +392,7 @@
 			};
 
 			pmc: pmc at f0018000 {
-				compatible = "atmel,sama5d3-pmc", "syscon";
+				compatible = "atmel,sama5d4-pmc", "syscon";
 				reg = <0xf0018000 0x120>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				interrupt-controller;
-- 
2.17.1
