From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 16 Nov 2016 17:31:31 +0000
Subject: [PATCH 2/2] arm64: dts: juno: fix cluster sleep state entry latency
 on all SoC versions
In-Reply-To: <1479317491-7435-1-git-send-email-sudeep.holla@arm.com>
References: <1479317491-7435-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1479317491-7435-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The core and the cluster sleep state entry latencies can't be same as
cluster sleep involves more work compared to core level e.g. shared
cache maintenance.

Experiments have shown on an average about 100us more latency for the
cluster sleep state compared to the core level sleep. This patch fixes
the entry latency for the cluster sleep state.

Fixes: 28e10a8f3a03 ("arm64: dts: juno: Add idle-states to device tree")
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Reviewed-by: Liviu Dudau <Liviu.Dudau@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/boot/dts/arm/juno-r1.dts | 2 +-
 arch/arm64/boot/dts/arm/juno-r2.dts | 2 +-
 arch/arm64/boot/dts/arm/juno.dts    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
index 123a58b29cbd..f0b857d6d73c 100644
--- a/arch/arm64/boot/dts/arm/juno-r1.dts
+++ b/arch/arm64/boot/dts/arm/juno-r1.dts
@@ -76,7 +76,7 @@
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x1010000>;
 				local-timer-stop;
-				entry-latency-us = <300>;
+				entry-latency-us = <400>;
 				exit-latency-us = <1200>;
 				min-residency-us = <2500>;
 			};
diff --git a/arch/arm64/boot/dts/arm/juno-r2.dts b/arch/arm64/boot/dts/arm/juno-r2.dts
index 007be826efce..26aaa6a7670f 100644
--- a/arch/arm64/boot/dts/arm/juno-r2.dts
+++ b/arch/arm64/boot/dts/arm/juno-r2.dts
@@ -76,7 +76,7 @@
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x1010000>;
 				local-timer-stop;
-				entry-latency-us = <300>;
+				entry-latency-us = <400>;
 				exit-latency-us = <1200>;
 				min-residency-us = <2500>;
 			};
diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index a7270eff6939..6e154d948a80 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -76,7 +76,7 @@
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x1010000>;
 				local-timer-stop;
-				entry-latency-us = <300>;
+				entry-latency-us = <400>;
 				exit-latency-us = <1200>;
 				min-residency-us = <2500>;
 			};
--
2.7.4
