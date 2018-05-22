From: john.garry@huawei.com (John Garry)
Date: Tue, 22 May 2018 23:54:04 +0800
Subject: [PATCH] drivers/perf: Remove ARM_SPE_PMU explicit PERF_EVENTS
 dependency
Message-ID: <1527004444-239462-1-git-send-email-john.garry@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit bddb9b68d3fb ("drivers/perf: commonise PERF_EVENTS
dependency"), all perf drivers depend on PERF_EVENTS config under a
common menu.

Config ARM_SPE_PMU still declares explicitly a dependency on
PERF_EVENTS, which is unneeded, so remove it.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 28bb5a0..90ce4da 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -94,7 +94,7 @@ config XGENE_PMU
 
 config ARM_SPE_PMU
 	tristate "Enable support for the ARMv8.2 Statistical Profiling Extension"
-	depends on PERF_EVENTS && ARM64
+	depends on ARM64
 	help
 	  Enable perf support for the ARMv8.2 Statistical Profiling
 	  Extension, which provides periodic sampling of operations in
-- 
1.9.1
