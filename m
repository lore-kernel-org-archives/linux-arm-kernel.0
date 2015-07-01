From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed,  1 Jul 2015 13:36:01 +0100
Subject: [PATCH 1/3] arm: dts: vexpress: describe all PMUs in TC2 dts
In-Reply-To: <1435754163-17929-1-git-send-email-sudeep.holla@arm.com>
References: <1435754163-17929-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1435754163-17929-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Rutland <mark.rutland@arm.com>

The dts for the CoreTile Express A15x2 A7x3 (TC2) only describes the
PMUs of the Cortex-A15 CPUs, and not the Cortex-A7 CPUs.

Now that we have a mechanism for describing disparate PMUs and their
interrupts in device tree, this patch makes use of these to describe the
PMUs for all CPUs in the system. For consistency, the existing A15 PMU
interrupt-affinity property is reflowed across two lines.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index 107395c32d82..038e30e4332f 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -187,11 +187,22 @@
 			     <1 10 0xf08>;
 	};
 
-	pmu {
+	pmu_a15 {
 		compatible = "arm,cortex-a15-pmu";
 		interrupts = <0 68 4>,
 			     <0 69 4>;
-		interrupt-affinity = <&cpu0>, <&cpu1>;
+		interrupt-affinity = <&cpu0>,
+				     <&cpu1>;
+	};
+
+	pmu_a7 {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts = <0 128 4>,
+			     <0 129 4>,
+			     <0 130 4>;
+		interrupt-affinity = <&cpu2>,
+				     <&cpu3>,
+				     <&cpu4>;
 	};
 
 	oscclk6a: oscclk6a {
-- 
1.9.1
