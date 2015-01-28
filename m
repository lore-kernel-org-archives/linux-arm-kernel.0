From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 28 Jan 2015 19:39:03 +0100
Subject: [PATCH 5/5] ARM: at91/dt: add matrix nodes
In-Reply-To: <1422470343-25981-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1422470343-25981-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1422470343-25981-6-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add matrix nodes to AT91 DTs so that other IPs can access its registers.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi | 5 +++++
 arch/arm/boot/dts/at91sam9g45.dtsi | 5 +++++
 arch/arm/boot/dts/at91sam9n12.dtsi | 5 +++++
 arch/arm/boot/dts/at91sam9rl.dtsi  | 5 +++++
 arch/arm/boot/dts/at91sam9x5.dtsi  | 5 +++++
 arch/arm/boot/dts/sama5d3.dtsi     | 5 +++++
 6 files changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index e393e21..d5be412 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -104,6 +104,11 @@
 				reg = <0xffffec00 0x100>;
 			};
 
+			matrix: matrix at ffffee00 {
+				compatible = "atmel,at91sam9260-bus-matrix", "syscon";
+				reg = <0xffffee00 0x200>;
+			};
+
 			pmc: pmc at fffffc00 {
 				compatible = "atmel,at91sam9260-pmc";
 				reg = <0xfffffc00 0x100>;
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index a052585..589c881 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -118,6 +118,11 @@
 				reg = <0xffffe800 0x100>;
 			};
 
+			matrix: matrix at ffffea00 {
+				compatible = "atmel,at91sam9g45-bus-matrix", "syscon";
+				reg = <0xffffea00 0x200>;
+			};
+
 			pmc: pmc at fffffc00 {
 				compatible = "atmel,at91sam9g45-pmc";
 				reg = <0xfffffc00 0x100>;
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 275d981..53ca8bd 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -89,6 +89,11 @@
 				atmel,external-irqs = <31>;
 			};
 
+			matrix: matrix at ffffde00 {
+				compatible = "atmel,at91sam9n12-bus-matrix", "syscon";
+				reg = <0xffffde00 0x200>;
+			};
+
 			ramc0: ramc at ffffe800 {
 				compatible = "atmel,at91sam9g45-ddramc";
 				reg = <0xffffe800 0x200>;
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index 75978f2f..68de712 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -373,6 +373,11 @@
 				reg = <0xffffec00 0x100>;
 			};
 
+			matrix: matrix at ffffee00 {
+				compatible = "atmel,at91sam9rl-bus-matrix", "syscon";
+				reg = <0xffffee00 0x200>;
+			};
+
 			aic: interrupt-controller at fffff000 {
 				#interrupt-cells = <3>;
 				compatible = "atmel,at91rm9200-aic";
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 85cf280..09ad649 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -97,6 +97,11 @@
 				atmel,external-irqs = <31>;
 			};
 
+			matrix: matrix at ffffde00 {
+				compatible = "atmel,at91sam9x5-bus-matrix", "syscon";
+				reg = <0xffffde00 0x200>;
+			};
+
 			ramc0: ramc at ffffe800 {
 				compatible = "atmel,at91sam9g45-ddramc";
 				reg = <0xffffe800 0x200>;
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 17ad07f..94e07cb 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -443,6 +443,11 @@
 				clock-names = "ddrck", "mpddr";
 			};
 
+			matrix: matrix at ffffec00 {
+				compatible = "atmel,sama5d3-matrix", "syscon";
+				reg = <0xffffec00 0x200>;
+			};
+
 			dbgu: serial at ffffee00 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xffffee00 0x200>;
-- 
1.9.1
