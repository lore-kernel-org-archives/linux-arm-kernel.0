From: kim.phillips@arm.com (Kim Phillips)
Date: Tue,  5 Jun 2018 16:07:00 -0500
Subject: [PATCH v4 04/14] coresight: export coresight_timeout and
 etm_perf_symlink
In-Reply-To: <20180605210710.22227-1-kim.phillips@arm.com>
References: <20180605210710.22227-1-kim.phillips@arm.com>
Message-ID: <20180605210710.22227-5-kim.phillips@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Export these symbols for use by other coresight components,
so they can be built as modules.

coresight_timeout is used by the coresight stm, etm4x, tmc,
tpiu, and etb10 modules, and etm_perf_symlink is needed by
the etm3x/4x modules.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 1 +
 drivers/hwtracing/coresight/coresight.c          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 677695635211..0fe7e43ea1c4 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -466,6 +466,7 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(etm_perf_symlink);
 
 static int __init etm_perf_init(void)
 {
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 0cbc2948defc..338f1719641c 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -933,6 +933,7 @@ int coresight_timeout(void __iomem *addr, u32 offset, int position, int value)
 
 	return -EAGAIN;
 }
+EXPORT_SYMBOL_GPL(coresight_timeout);
 
 struct bus_type coresight_bustype = {
 	.name	= "coresight",
-- 
2.17.0
