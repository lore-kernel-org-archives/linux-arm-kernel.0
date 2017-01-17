From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 17 Jan 2017 12:15:10 +0000
Subject: [PATCH v4 1/4] arm64: dts: juno: remove dtsi nesting inside tree
 structure
In-Reply-To: <1484655313-9025-1-git-send-email-sudeep.holla@arm.com>
References: <1484655313-9025-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1484655313-9025-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently juno-clock.dtsi and juno-base.dtsi are nested badly inside
the device tree structure. It's generally good practice to ensure that
individual dtsi stand by themselves at the top of the file.

This patch removes the nesting of the above mentioned dtsi files and
makes them independent.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi   | 6 ++++--
 arch/arm64/boot/dts/arm/juno-clocks.dtsi | 3 ++-
 arch/arm64/boot/dts/arm/juno-r1.dts      | 3 +--
 arch/arm64/boot/dts/arm/juno-r2.dts      | 3 +--
 arch/arm64/boot/dts/arm/juno.dts         | 3 +--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index 7d832247d0db..580afaee978f 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -1,3 +1,6 @@
+#include "juno-clocks.dtsi"
+
+/ {
 	/*
 	 *  Devices shared by all Juno boards
 	 */
@@ -507,8 +510,6 @@
 		};
 	};

-	/include/ "juno-clocks.dtsi"
-
 	smmu_dma: iommu at 7fb00000 {
 		compatible = "arm,mmu-401", "arm,smmu-v1";
 		reg = <0x0 0x7fb00000 0x0 0x10000>;
@@ -719,3 +720,4 @@
 		interrupt-map-mask = <0 0>;
 		interrupt-map = <0 0 &gic 0 0 0 168 IRQ_TYPE_LEVEL_HIGH>;
 	};
+};
diff --git a/arch/arm64/boot/dts/arm/juno-clocks.dtsi b/arch/arm64/boot/dts/arm/juno-clocks.dtsi
index 25352ed943e6..e5e265dfa902 100644
--- a/arch/arm64/boot/dts/arm/juno-clocks.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-clocks.dtsi
@@ -6,7 +6,7 @@
  * This file is licensed under a dual GPLv2 or BSD license.
  *
  */
-
+/ {
 	/* SoC fixed clocks */
 	soc_uartclk: refclk7273800hz {
 		compatible = "fixed-clock";
@@ -42,3 +42,4 @@
 		clock-frequency = <400000000>;
 		clock-output-names = "faxi_clk";
 	};
+};
diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
index eec37feee8fc..b883a8afb6f4 100644
--- a/arch/arm64/boot/dts/arm/juno-r1.dts
+++ b/arch/arm64/boot/dts/arm/juno-r1.dts
@@ -9,6 +9,7 @@
 /dts-v1/;

 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include "juno-base.dtsi"

 / {
 	model = "ARM Juno development board (r1)";
@@ -176,8 +177,6 @@
 				     <&A53_2>,
 				     <&A53_3>;
 	};
-
-	#include "juno-base.dtsi"
 };

 &memtimer {
diff --git a/arch/arm64/boot/dts/arm/juno-r2.dts b/arch/arm64/boot/dts/arm/juno-r2.dts
index 28f40ec44090..cfd8150bf30a 100644
--- a/arch/arm64/boot/dts/arm/juno-r2.dts
+++ b/arch/arm64/boot/dts/arm/juno-r2.dts
@@ -9,6 +9,7 @@
 /dts-v1/;

 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include "juno-base.dtsi"

 / {
 	model = "ARM Juno development board (r2)";
@@ -176,8 +177,6 @@
 				     <&A53_2>,
 				     <&A53_3>;
 	};
-
-	#include "juno-base.dtsi"
 };

 &memtimer {
diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index ac5ceb73f45f..9967c808a92d 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -9,6 +9,7 @@
 /dts-v1/;

 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include "juno-base.dtsi"

 / {
 	model = "ARM Juno development board (r0)";
@@ -176,8 +177,6 @@
 				     <&A53_2>,
 				     <&A53_3>;
 	};
-
-	#include "juno-base.dtsi"
 };

 &etm0 {
--
2.7.4
