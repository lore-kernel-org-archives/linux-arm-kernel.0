From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  6 Jul 2015 12:23:59 +0100
Subject: [PATCHv3 7/9] arm64: dts: juno: describe PMUs separately
In-Reply-To: <1436181842-19402-1-git-send-email-mark.rutland@arm.com>
References: <1436181842-19402-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1436181842-19402-8-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A57 and A53 PMUs in support different events, so describe them
separately in the Juno dts files.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/boot/dts/arm/juno-r1.dts | 18 +++++++++++-------
 arch/arm64/boot/dts/arm/juno.dts    | 18 +++++++++++-------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
index c627511..734e127 100644
--- a/arch/arm64/boot/dts/arm/juno-r1.dts
+++ b/arch/arm64/boot/dts/arm/juno-r1.dts
@@ -91,17 +91,21 @@
 		};
 	};
 
-	pmu {
-		compatible = "arm,armv8-pmuv3";
+	pmu_a57 {
+		compatible = "arm,cortex-a57-pmu";
 		interrupts = <GIC_SPI 02 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 06 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 06 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&A57_0>,
+				     <&A57_1>;
+	};
+
+	pmu_a53 {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-affinity = <&A57_0>,
-				     <&A57_1>,
-				     <&A53_0>,
+		interrupt-affinity = <&A53_0>,
 				     <&A53_1>,
 				     <&A53_2>,
 				     <&A53_3>;
diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index d7cbdd4..ffa05ae 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -91,17 +91,21 @@
 		};
 	};
 
-	pmu {
-		compatible = "arm,armv8-pmuv3";
+	pmu_a57 {
+		compatible = "arm,cortex-a57-pmu";
 		interrupts = <GIC_SPI 02 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 06 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 06 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&A57_0>,
+				     <&A57_1>;
+	};
+
+	pmu_a53 {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-affinity = <&A57_0>,
-				     <&A57_1>,
-				     <&A53_0>,
+		interrupt-affinity = <&A53_0>,
 				     <&A53_1>,
 				     <&A53_2>,
 				     <&A53_3>;
-- 
1.9.1
