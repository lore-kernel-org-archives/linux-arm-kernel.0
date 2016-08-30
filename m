From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 30 Aug 2016 22:52:49 +0200
Subject: [PATCH 2/3] ARM: dts: lpc18xx: remove skeleton.dtsi include and fix
 unit address warnings
In-Reply-To: <20160830205250.15616-1-manabian@gmail.com>
References: <20160830205250.15616-1-manabian@gmail.com>
Message-ID: <20160830205250.15616-3-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removale of skeleton.dtsi allows us also to fix the following
warning from the dts compiler:
  Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name

by adding proper unit addresses to the memory nodes.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi              | 4 +++-
 arch/arm/boot/dts/lpc4337-ciaa.dts          | 2 +-
 arch/arm/boot/dts/lpc4350-hitex-eval.dts    | 2 +-
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts | 2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index a1ecfe3..860ffa8 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -11,7 +11,6 @@
  *
  */
 
-#include "skeleton.dtsi"
 #include "armv7-m.dtsi"
 
 #include "dt-bindings/clock/lpc18xx-cgu.h"
@@ -21,6 +20,9 @@
 #define LPC_GPIO(port, pin)	(port * 32 + pin)
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/lpc4337-ciaa.dts b/arch/arm/boot/dts/lpc4337-ciaa.dts
index 5cfadb0..7c16d63 100644
--- a/arch/arm/boot/dts/lpc4337-ciaa.dts
+++ b/arch/arm/boot/dts/lpc4337-ciaa.dts
@@ -30,7 +30,7 @@
 		stdout-path = &uart2;
 	};
 
-	memory {
+	memory at 28000000 {
 		device_type = "memory";
 		reg = <0x28000000 0x0800000>; /* 8 MB */
 	};
diff --git a/arch/arm/boot/dts/lpc4350-hitex-eval.dts b/arch/arm/boot/dts/lpc4350-hitex-eval.dts
index d37779e..bc89702 100644
--- a/arch/arm/boot/dts/lpc4350-hitex-eval.dts
+++ b/arch/arm/boot/dts/lpc4350-hitex-eval.dts
@@ -34,7 +34,7 @@
 		stdout-path = &uart0;
 	};
 
-	memory {
+	memory at 28000000 {
 		device_type = "memory";
 		reg = <0x28000000 0x800000>; /* 8 MB */
 	};
diff --git a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
index 37bbcb6..5ca5eb5 100644
--- a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
+++ b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
@@ -35,7 +35,7 @@
 		stdout-path = &uart0;
 	};
 
-	memory {
+	memory at 28000000 {
 		device_type = "memory";
 		reg = <0x28000000 0x2000000>; /* 32 MB */
 	};
-- 
2.9.3
