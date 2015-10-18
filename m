From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Sun, 18 Oct 2015 12:24:46 -0600
Subject: [PATCH V2 29/30] perf tools: adding coresight define for auxtrace
In-Reply-To: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1445192687-24112-30-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding new define for auxiliary traces collected by ETM tracers.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/auxtrace.c | 1 +
 tools/perf/util/auxtrace.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 430df9575dbe..666773d4e942 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -892,6 +892,7 @@ int perf_event__process_auxtrace_info(struct perf_tool *tool __maybe_unused,
 		return intel_pt_process_auxtrace_info(event, session);
 	case PERF_AUXTRACE_INTEL_BTS:
 		return intel_bts_process_auxtrace_info(event, session);
+	case PERF_AUXTRACE_CS_ETM:
 	case PERF_AUXTRACE_UNKNOWN:
 	default:
 		return -EINVAL;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index ed1c940be883..35569d25d1d3 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -41,6 +41,7 @@ enum auxtrace_type {
 	PERF_AUXTRACE_UNKNOWN,
 	PERF_AUXTRACE_INTEL_PT,
 	PERF_AUXTRACE_INTEL_BTS,
+	PERF_AUXTRACE_CS_ETM,
 };
 
 enum itrace_period_type {
-- 
1.9.1
