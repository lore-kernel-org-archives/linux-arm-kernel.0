From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 11 May 2018 11:23:28 +0100
Subject: [PATCH v2 2/2] ARM: dts: vexpress: replace '_' with '-' in node names
In-Reply-To: <1526034208-9690-1-git-send-email-sudeep.holla@arm.com>
References: <1525884482-19855-1-git-send-email-sudeep.holla@arm.com>
 <1526034208-9690-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1526034208-9690-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The latest DTC throws warnings for character '_' in the node names.

Warning (node_name_chars_strict): /pmu_a15: Character '_' not recommended in node name
Warning (node_name_chars_strict): /pmu_a7: Character '_' not recommended in node name

The general recommendation is to use character '-' for all the node names.
This patch fixes the warnings following the recommendation.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

v1->v2:
	- This patch is newly added in v2 and was missing earlier

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index 65a874ea66be..ac6b90e9d806 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -204,7 +204,7 @@
 			     <1 10 0xf08>;
 	};

-	pmu_a15 {
+	pmu-a15 {
 		compatible = "arm,cortex-a15-pmu";
 		interrupts = <0 68 4>,
 			     <0 69 4>;
@@ -212,7 +212,7 @@
 				     <&cpu1>;
 	};

-	pmu_a7 {
+	pmu-a7 {
 		compatible = "arm,cortex-a7-pmu";
 		interrupts = <0 128 4>,
 			     <0 129 4>,
--
2.7.4
