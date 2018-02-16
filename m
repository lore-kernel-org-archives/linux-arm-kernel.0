From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Fri, 16 Feb 2018 16:17:27 -0300
Subject: [PATCH 22/41] perf auxtrace arm: Fixing uninitialised variable
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Message-ID: <20180216191746.11095-23-acme@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

When working natively on arm64 the compiler gets pesky and complains
that variable 'i' is uninitialised, something that breaks the
compilation.  Here no further checks are needed since variable
'found_spe' can only be true if variable 'i' has been initialised as
part of the for loop.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel at lists.infradead.org
Link: http://lkml.kernel.org/r/1518467557-18505-4-git-send-email-mathieu.poirier at linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/auxtrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index 2323581b157d..fa639e3e52ac 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -68,7 +68,7 @@ struct auxtrace_record
 	bool found_spe = false;
 	static struct perf_pmu **arm_spe_pmus = NULL;
 	static int nr_spes = 0;
-	int i;
+	int i = 0;
 
 	if (!evlist)
 		return NULL;
-- 
2.14.3
