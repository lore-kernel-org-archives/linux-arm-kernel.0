From: kim.phillips@arm.com (Kim Phillips)
Date: Thu, 17 May 2018 20:20:20 -0500
Subject: [PATCH 2/6] coresight: fix CORESIGHT_STM -- STM dependency
In-Reply-To: <20180518012024.22645-1-kim.phillips@arm.com>
References: <20180517070643.GC13919@kroah.com>
 <20180518012024.22645-1-kim.phillips@arm.com>
Message-ID: <20180518012024.22645-2-kim.phillips@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

coresight-stm unconditionally calls stm_register_device.  This
patch makes it therefore depend on STM instead of just selecting STM.

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
 drivers/hwtracing/coresight/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 83fb78651ef9..f9abdef5b0d9 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -74,8 +74,7 @@ config CORESIGHT_DYNAMIC_REPLICATOR
 
 config CORESIGHT_STM
 	bool "CoreSight System Trace Macrocell driver"
-	depends on (ARM && !(CPU_32v3 || CPU_32v4 || CPU_32v4T)) || ARM64
-	select STM
+	depends on STM && ((ARM && !(CPU_32v3 || CPU_32v4 || CPU_32v4T)) || ARM64)
 	help
 	  This driver provides support for hardware assisted software
 	  instrumentation based tracing. This is primarily used for
-- 
2.17.0
