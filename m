From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 13 May 2015 17:12:29 +0100
Subject: [PATCH 7/7] arm: dts: vexpress: describe all PMUs in TC2 dts
In-Reply-To: <1431533549-27715-1-git-send-email-mark.rutland@arm.com>
References: <1431533549-27715-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1431533549-27715-8-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dts for the CoreTile Express A15x2 A7x3 (TC2) only describes the
PMUs of the Cortex-A15 CPUs, and not the Cortex-A7 CPUs.

Now that we have a mechanism for describing disparate PMUs and their
interrupts in device tree, this patch makes use of these to describe the
PMUs for all CPUs in the system.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index 7a2aeac..038e30e 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -187,10 +187,22 @@
 			     <1 10 0xf08>;
 	};
 
-	pmu {
+	pmu_a15 {
 		compatible = "arm,cortex-a15-pmu";
 		interrupts = <0 68 4>,
 			     <0 69 4>;
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
