From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu,  7 May 2015 15:45:05 +0100
Subject: [PATCH 4/4] ARM: vexpress/tc2: Add interrupt-affinity to the PMU node
In-Reply-To: <1431009905-29265-1-git-send-email-sudeep.holla@arm.com>
References: <1431009905-29265-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1431009905-29265-5-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 9fd85eb502a7 ("ARM: pmu: add support for interrupt-affinity
property") added an optional "interrupt-affinity" property, to specify
the CPU affinity for each SPI listed in the interrupts property.

Without this property, we get this boot warning:

  CPU PMU: Failed to parse <no-node>/interrupt-affinity[0]

This patch adds interrupt-affinity to the PMU node in the
vexpress-ca15_a7(a.k.a TC2) device tree.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index 7a2aeacd62c0..107395c32d82 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -191,6 +191,7 @@
 		compatible = "arm,cortex-a15-pmu";
 		interrupts = <0 68 4>,
 			     <0 69 4>;
+		interrupt-affinity = <&cpu0>, <&cpu1>;
 	};
 
 	oscclk6a: oscclk6a {
-- 
1.9.1
