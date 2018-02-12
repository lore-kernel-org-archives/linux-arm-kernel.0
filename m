From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 12 Feb 2018 13:32:37 -0700
Subject: [PATCH 3/3] perf tools: Fixing uninitialised variable
In-Reply-To: <1518467557-18505-1-git-send-email-mathieu.poirier@linaro.org>
References: <1518467557-18505-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1518467557-18505-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When working natively on arm64 the compiler gets pesky and complains
that variable 'i' is uninitialised, something that breaks the
compilation.  Here no further checks are needed since variable 'found_spe'
can only be true if variable 'i' has been initialised as part of the for
loop.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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
2.7.4
