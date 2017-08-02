From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  2 Aug 2017 10:22:01 -0600
Subject: [PATCH 07/26] coresight: pmu: Adds return stack option to perf
 coresight pmu
In-Reply-To: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
References: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1501690940-4137-8-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mike Leach <mike.leach@linaro.org>

Return stack is a programmable option on some ETM and PTM hardware.
Adds the option flags to enable this from the perf event command line.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 2 ++
 include/linux/coresight-pmu.h                    | 1 +
 tools/include/linux/coresight-pmu.h              | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index ad01dfeb2d68..8a0ad77574e7 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -53,10 +53,12 @@ static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
 /* ETMv3.5/PTM's ETMCR is 'config' */
 PMU_FORMAT_ATTR(cycacc,		"config:" __stringify(ETM_OPT_CYCACC));
 PMU_FORMAT_ATTR(timestamp,	"config:" __stringify(ETM_OPT_TS));
+PMU_FORMAT_ATTR(retstack,	"config:" __stringify(ETM_OPT_RETSTK));
 
 static struct attribute *etm_config_formats_attr[] = {
 	&format_attr_cycacc.attr,
 	&format_attr_timestamp.attr,
+	&format_attr_retstack.attr,
 	NULL,
 };
 
diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index 7d410260661b..45852c2cd096 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
@@ -24,6 +24,7 @@
 /* ETMv3.5/PTM's ETMCR config bit */
 #define ETM_OPT_CYCACC  12
 #define ETM_OPT_TS      28
+#define ETM_OPT_RETSTK	29
 
 static inline int coresight_get_trace_id(int cpu)
 {
diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
index 7d410260661b..45852c2cd096 100644
--- a/tools/include/linux/coresight-pmu.h
+++ b/tools/include/linux/coresight-pmu.h
@@ -24,6 +24,7 @@
 /* ETMv3.5/PTM's ETMCR config bit */
 #define ETM_OPT_CYCACC  12
 #define ETM_OPT_TS      28
+#define ETM_OPT_RETSTK	29
 
 static inline int coresight_get_trace_id(int cpu)
 {
-- 
2.7.4
