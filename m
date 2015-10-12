From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 12 Oct 2015 16:28:38 +0200
Subject: [PATCH v2 01/14] ARM: at91/dt: use syscon for PMC
In-Reply-To: <1444660131-14954-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1444660131-14954-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1444660131-14954-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PMC is not only used to drive the clocks but also has some registers
related to other functions. One of those is for example the USB gadget
bias.
Using a syscon allows to properly separate those functions.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91rm9200.dtsi  | 2 +-
 arch/arm/boot/dts/at91sam9260.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9261.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9263.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9n12.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi  | 2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi  | 2 +-
 arch/arm/boot/dts/sama5d2.dtsi     | 2 +-
 arch/arm/boot/dts/sama5d3.dtsi     | 2 +-
 arch/arm/boot/dts/sama5d4.dtsi     | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 60edd8baebb8..39eb1e3fc6b8 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -97,7 +97,7 @@
 			};
 
 			pmc: pmc at fffffc00 {
-				compatible = "atmel,at91rm9200-pmc";
+				compatible = "atmel,at91rm9200-pmc", "syscon";
 				reg = <0xfffffc00 0x100>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				interrupt-controller;
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index be9c027ddd97..d4884dd1c243 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -100,7 +100,7 @@
 			};
 
 			pmc: pmc at fffffc00 {
-				compatible = "atmel,at91sam9260-pmc";
+				compatible = "atmel,at91sam9260-pmc", "syscon";
 				reg = <0xfffffc00 0x100>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				interrupt-controller;
diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index ce1e3e94a40c..5e09de4eb9cd 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -568,7 +568,7 @@
 			};
 
 			pmc: pmc at fffffc00 {
-				compatible = "atmel,at91rm9200-pmc";
+				compatible = "atmel,at91rm9200-pmc", "syscon";
 				reg = <0xfffffc00 0x100>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				interrupt-controller;
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index f1f5fa3a9e6e..93446420af25 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -93,7 +93,7 @@
 			};
 
 			pmc: pmc at fffffc00 {
-				compatible = "atmel,at91rm9200-pmc";
+				compatible = "atmel,at91rm9200-pmc", "syscon";
 				reg = <0xfffffc00 0x100>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				interrupt-controller;
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 18b8b9e29704..af8b708ac312 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -114,7 +114,7 @@
 			};
 
 			pmc: pmc at fffffc00 {
-				compatible = "atmel,at91sam9g45-pmc";
+				compatible = "atmel,at91sam9g45-pmc", "syscon";
 				reg = <0xfffffc00 0x100>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				interrupt-controller;
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 32bc9a189db0..95569a87b6c9 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -97,7 +97,7 @@
 			};
 
 			pmc: pmc at fffffc00 {
-				compatible = "atmel,at91sam9n12-pmc";
+				compatible = "atmel,at91sam9n12-pmc", "syscon";
 				reg = <0xfffffc00 0x200>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				interrupt-controller;
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index a0b90aedd3b8..6d829db4e887 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -814,7 +814,7 @@
 			};
 
 			pmc: pmc at fffffc00 {
-				compatible = "atmel,at91sam9g45-pmc";
+				compatible = "atmel,at91sam9g45-pmc", "syscon";
 				reg = <0xfffffc00 0x100>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				interrupt-controller;
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 747d8f070a5c..0a0ea6bce1b9 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -105,7 +105,7 @@
 			};
 
 			pmc: pmc at fffffc00 {
-				compatible = "atmel,at91sam9x5-pmc";
+				compatible = "atmel,at91sam9x5-pmc", "syscon";
 				reg = <0xfffffc00 0x100>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				interrupt-controller;
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 034cd48ae28b..780c8afc7600 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -286,7 +286,7 @@
 			};
 
 			pmc: pmc at f0014000 {
-				compatible = "atmel,sama5d2-pmc";
+				compatible = "atmel,sama5d2-pmc", "syscon";
 				reg = <0xf0014000 0x160>;
 				interrupts = <74 IRQ_TYPE_LEVEL_HIGH 7>;
 				interrupt-controller;
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 7fa276515f11..fa054b28c2c3 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -906,7 +906,7 @@
 			};
 
 			pmc: pmc at fffffc00 {
-				compatible = "atmel,sama5d3-pmc";
+				compatible = "atmel,sama5d3-pmc", "syscon";
 				reg = <0xfffffc00 0x120>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				interrupt-controller;
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 8d1de29e8da1..3ab2c83ecc8b 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -386,7 +386,7 @@
 			};
 
 			pmc: pmc at f0018000 {
-				compatible = "atmel,sama5d3-pmc";
+				compatible = "atmel,sama5d3-pmc", "syscon";
 				reg = <0xf0018000 0x120>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				interrupt-controller;
-- 
2.1.4
