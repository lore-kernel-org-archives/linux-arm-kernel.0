From: kim.phillips@arm.com (Kim Phillips)
Date: Thu, 17 May 2018 20:20:19 -0500
Subject: [PATCH 1/6] coresight: remove CORESIGHT_LINKS_AND_SINKS dependencies
 and selections
In-Reply-To: <20180517070643.GC13919@kroah.com>
References: <20180517070643.GC13919@kroah.com>
Message-ID: <20180518012024.22645-1-kim.phillips@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A coresight topology doesn't need to include links, i.e., a source can
be directly connected to a sink.  As such, selecting and/or depending on
LINKS_AND_SINKS is no longer needed.

Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
 drivers/hwtracing/coresight/Kconfig | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index ef9cb3c164e1..83fb78651ef9 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -23,7 +23,6 @@ config CORESIGHT_LINKS_AND_SINKS
 
 config CORESIGHT_LINK_AND_SINK_TMC
 	bool "Coresight generic TMC driver"
-	depends on CORESIGHT_LINKS_AND_SINKS
 	help
 	  This enables support for the Trace Memory Controller driver.
 	  Depending on its configuration the device can act as a link (embedded
@@ -33,7 +32,6 @@ config CORESIGHT_LINK_AND_SINK_TMC
 
 config CORESIGHT_SINK_TPIU
 	bool "Coresight generic TPIU driver"
-	depends on CORESIGHT_LINKS_AND_SINKS
 	help
 	  This enables support for the Trace Port Interface Unit driver,
 	  responsible for bridging the gap between the on-chip coresight
@@ -44,7 +42,6 @@ config CORESIGHT_SINK_TPIU
 
 config CORESIGHT_SINK_ETBV10
 	bool "Coresight ETBv1.0 driver"
-	depends on CORESIGHT_LINKS_AND_SINKS
 	help
 	  This enables support for the Embedded Trace Buffer version 1.0 driver
 	  that complies with the generic implementation of the component without
@@ -53,7 +50,6 @@ config CORESIGHT_SINK_ETBV10
 config CORESIGHT_SOURCE_ETM3X
 	bool "CoreSight Embedded Trace Macrocell 3.x driver"
 	depends on !ARM64
-	select CORESIGHT_LINKS_AND_SINKS
 	help
 	  This driver provides support for processor ETM3.x and PTM1.x modules,
 	  which allows tracing the instructions that a processor is executing
@@ -63,7 +59,6 @@ config CORESIGHT_SOURCE_ETM3X
 config CORESIGHT_SOURCE_ETM4X
 	bool "CoreSight Embedded Trace Macrocell 4.x driver"
 	depends on ARM64
-	select CORESIGHT_LINKS_AND_SINKS
 	help
 	  This driver provides support for the ETM4.x tracer module, tracing the
 	  instructions that a processor is executing. This is primarily useful
@@ -72,7 +67,6 @@ config CORESIGHT_SOURCE_ETM4X
 
 config CORESIGHT_DYNAMIC_REPLICATOR
 	bool "CoreSight Programmable Replicator driver"
-	depends on CORESIGHT_LINKS_AND_SINKS
 	help
 	  This enables support for dynamic CoreSight replicator link driver.
 	  The programmable ATB replicator allows independent filtering of the
@@ -81,7 +75,6 @@ config CORESIGHT_DYNAMIC_REPLICATOR
 config CORESIGHT_STM
 	bool "CoreSight System Trace Macrocell driver"
 	depends on (ARM && !(CPU_32v3 || CPU_32v4 || CPU_32v4T)) || ARM64
-	select CORESIGHT_LINKS_AND_SINKS
 	select STM
 	help
 	  This driver provides support for hardware assisted software
-- 
2.17.0
