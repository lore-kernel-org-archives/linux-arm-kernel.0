From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 26 May 2015 17:31:16 +0100
Subject: [PATCH 6/6] arm64: dts: juno: describe PMUs separately
In-Reply-To: <1432657876-1362-1-git-send-email-mark.rutland@arm.com>
References: <1432657876-1362-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1432657876-1362-7-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A57 and A53 PMUs in Juno support different events, so describe them
separately.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/boot/dts/arm/juno.dts | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index 5e9110a..015be74 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -118,17 +118,21 @@
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>;
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
