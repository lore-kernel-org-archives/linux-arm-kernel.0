From: nm@ti.com (Nishanth Menon)
Date: Fri, 21 Jun 2013 16:25:49 -0500
Subject: [RFC PATCH V2 8/8] ARM: dts: OMAP4-panda-es: use tps regulator as
 cpu0 supply
In-Reply-To: <1371849949-12649-1-git-send-email-nm@ti.com>
References: <1371849949-12649-1-git-send-email-nm@ti.com>
Message-ID: <1371849949-12649-9-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TPS62361 is used for cpufreq regulation. As part of this change
use labels that can be used to reference cpu0 to setup it's supply.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/omap4-panda-es.dts |    4 ++++
 arch/arm/boot/dts/omap4.dtsi         |    4 ++--
 arch/arm/boot/dts/omap443x.dtsi      |    2 +-
 arch/arm/boot/dts/omap4460.dtsi      |    2 +-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda-es.dts b/arch/arm/boot/dts/omap4-panda-es.dts
index 325816c..d2ce518 100644
--- a/arch/arm/boot/dts/omap4-panda-es.dts
+++ b/arch/arm/boot/dts/omap4-panda-es.dts
@@ -93,3 +93,7 @@
 	>;
 	gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
 };
+
+&cpu0 {
+	cpu0-supply = <&omap_tps62361>;
+};
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 3c75b23..127b974 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -24,13 +24,13 @@
 	};
 
 	cpus {
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			compatible = "arm,cortex-a9";
 			next-level-cache = <&L2>;
 			clocks = <&dpll_mpu>;
 			clock-names = "cpu";
 		};
-		cpu at 1 {
+		cpu1: cpu at 1 {
 			compatible = "arm,cortex-a9";
 			next-level-cache = <&L2>;
 		};
diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x.dtsi
index e759937..91a5f70 100644
--- a/arch/arm/boot/dts/omap443x.dtsi
+++ b/arch/arm/boot/dts/omap443x.dtsi
@@ -12,7 +12,7 @@
 
 / {
 	cpus {
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			/* OMAP443x variants OPP50-OPPNT */
 			operating-points = <
 				/* kHz    uV */
diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap4460.dtsi
index 8320865..9827e35 100644
--- a/arch/arm/boot/dts/omap4460.dtsi
+++ b/arch/arm/boot/dts/omap4460.dtsi
@@ -12,7 +12,7 @@
 / {
 	cpus {
 		/* OMAP446x 'standard device' variants OPP50 to OPPTurbo */
-		cpu at 0 {
+		cpu0: cpu@0 {
 			operating-points = <
 				/* kHz    uV */
 				350000  1025000
-- 
1.7.9.5
