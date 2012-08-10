From: will.deacon@arm.com (Will Deacon)
Date: Fri, 10 Aug 2012 18:36:28 +0100
Subject: [PATCH 2/9] ARM: perf: add devicetree bindings for 11MPcore, A5,
 A7 and A15 PMUs
In-Reply-To: <1344620195-22372-1-git-send-email-will.deacon@arm.com>
References: <1344620195-22372-1-git-send-email-will.deacon@arm.com>
Message-ID: <1344620195-22372-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds separate devicetree bindings for 11MPcore and
Cortex-{A5,A7,A15} PMUs in preparation for improved devicetree parsing
in the ARM perf-event CPU PMU driver.

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 Documentation/devicetree/bindings/arm/pmu.txt |    4 ++++
 arch/arm/kernel/perf_event.c                  |    6 +++++-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
index 1c044eb..343781b 100644
--- a/Documentation/devicetree/bindings/arm/pmu.txt
+++ b/Documentation/devicetree/bindings/arm/pmu.txt
@@ -7,8 +7,12 @@ representation in the device tree should be done as under:-
 Required properties:
 
 - compatible : should be one of
+	"arm,cortex-a15-pmu"
 	"arm,cortex-a9-pmu"
 	"arm,cortex-a8-pmu"
+	"arm,cortex-a7-pmu"
+	"arm,cortex-a5-pmu"
+	"arm,arm11mpcore-pmu"
 	"arm,arm1176-pmu"
 	"arm,arm1136-pmu"
 - interrupts : 1 combined interrupt or 1 per core.
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index c44647e..3aa3388 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -646,10 +646,14 @@ arch_initcall(cpu_pmu_reset);
  * PMU platform driver and devicetree bindings.
  */
 static struct of_device_id armpmu_of_device_ids[] = {
+	{.compatible = "arm,cortex-a15-pmu"},
 	{.compatible = "arm,cortex-a9-pmu"},
 	{.compatible = "arm,cortex-a8-pmu"},
-	{.compatible = "arm,arm1136-pmu"},
+	{.compatible = "arm,cortex-a7-pmu"},
+	{.compatible = "arm,cortex-a5-pmu"},
+	{.compatible = "arm,arm11mpcore-pmu"},
 	{.compatible = "arm,arm1176-pmu"},
+	{.compatible = "arm,arm1136-pmu"},
 	{},
 };
 
-- 
1.7.4.1
