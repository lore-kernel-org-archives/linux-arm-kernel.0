From: kim.phillips@arm.com (Kim Phillips)
Date: Tue, 8 May 2018 14:06:55 -0500
Subject: [PATCH 4/4] coresight: remove CORESIGHT_LINKS_AND_SINKS dependencies
Message-ID: <20180508140655.b6d065db6670669336e00db8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A coresight topology doesn't need to include links anymore, i.e., a source can
be directly connected to a sink.  As such the dependency is no longer needed.

Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
 drivers/hwtracing/coresight/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 09a682013ea2..f1e05fbef257 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -30,7 +30,7 @@ config CORESIGHT_LINKS_AND_SINKS
 
 config CORESIGHT_LINK_AND_SINK_TMC
 	tristate "Coresight generic TMC driver"
-	depends on CORESIGHT_LINKS_AND_SINKS
+	depends on CORESIGHT
 	help
 	  This enables support for the Trace Memory Controller driver.
 	  Depending on its configuration the device can act as a link (embedded
@@ -43,7 +43,7 @@ config CORESIGHT_LINK_AND_SINK_TMC
 
 config CORESIGHT_SINK_TPIU
 	tristate "Coresight generic TPIU driver"
-	depends on CORESIGHT_LINKS_AND_SINKS
+	depends on CORESIGHT
 	help
 	  This enables support for the Trace Port Interface Unit driver,
 	  responsible for bridging the gap between the on-chip coresight
@@ -57,7 +57,7 @@ config CORESIGHT_SINK_TPIU
 
 config CORESIGHT_SINK_ETBV10
 	tristate "Coresight ETBv1.0 driver"
-	depends on CORESIGHT_LINKS_AND_SINKS
+	depends on CORESIGHT
 	help
 	  This enables support for the Embedded Trace Buffer version 1.0 driver
 	  that complies with the generic implementation of the component without
@@ -68,7 +68,7 @@ config CORESIGHT_SINK_ETBV10
 
 config CORESIGHT_SOURCE_ETM3X
 	tristate "CoreSight Embedded Trace Macrocell 3.x driver"
-	depends on !ARM64 && CORESIGHT_LINKS_AND_SINKS
+	depends on CORESIGHT && !ARM64
 	help
 	  This driver provides support for processor ETM3.x and PTM1.x modules,
 	  which allows tracing the instructions that a processor is executing
@@ -80,7 +80,7 @@ config CORESIGHT_SOURCE_ETM3X
 
 config CORESIGHT_SOURCE_ETM4X
 	tristate "CoreSight Embedded Trace Macrocell 4.x driver"
-	depends on ARM64 && CORESIGHT_LINKS_AND_SINKS
+	depends on CORESIGHT && ARM64
 	help
 	  This driver provides support for the ETM4.x tracer module, tracing the
 	  instructions that a processor is executing. This is primarily useful
@@ -92,7 +92,7 @@ config CORESIGHT_SOURCE_ETM4X
 
 config CORESIGHT_DYNAMIC_REPLICATOR
 	tristate "CoreSight Programmable Replicator driver"
-	depends on CORESIGHT_LINKS_AND_SINKS
+	depends on CORESIGHT
 	help
 	  This enables support for dynamic CoreSight replicator link driver.
 	  The programmable ATB replicator allows independent filtering of the
@@ -104,7 +104,7 @@ config CORESIGHT_DYNAMIC_REPLICATOR
 config CORESIGHT_STM
 	tristate "CoreSight System Trace Macrocell driver"
 	depends on (ARM && !(CPU_32v3 || CPU_32v4 || CPU_32v4T)) || ARM64
-	depends on STM && CORESIGHT_LINKS_AND_SINKS
+	depends on STM
 	help
 	  This driver provides support for hardware assisted software
 	  instrumentation based tracing. This is primarily used for
-- 
2.17.0
