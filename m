From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Sun, 18 Oct 2015 12:24:43 -0600
Subject: [PATCH V2 26/30] perf tools: making source devices path broadly
 accessible
In-Reply-To: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1445192687-24112-27-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Other perf tools may want access to the event source device
directory.  As such moving the path definition to pmu.h for
easy inclusion by other clients.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/pmu.c | 2 --
 tools/perf/util/pmu.h | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 89c91a1a67e7..e1f2dc23a253 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -20,8 +20,6 @@ struct perf_pmu_format {
 	struct list_head list;
 };
 
-#define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
-
 int perf_pmu_parse(struct list_head *list, char *name);
 extern FILE *perf_pmu_in;
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 5d7e84466bee..3fbb791a955a 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -35,6 +35,7 @@ struct perf_pmu_info {
 };
 
 #define UNIT_MAX_LEN	31 /* max length for event unit name */
+#define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
 
 struct perf_pmu_alias {
 	char *name;
-- 
1.9.1
