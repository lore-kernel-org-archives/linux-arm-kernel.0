From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Tue, 13 Mar 2018 09:04:52 -0300
Subject: [PATCH 15/31] perf vendor events arm64: Relocate ThunderX2 JSON to
 cavium subdirectory
In-Reply-To: <20180313120508.29327-1-acme@kernel.org>
References: <20180313120508.29327-1-acme@kernel.org>
Message-ID: <20180313120508.29327-16-acme@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: John Garry <john.garry@huawei.com>

Since jevents now supports vendor subdirectory, relocate
the ThunderX2 JSON to Cavium subdirectory.

Signed-off-by: John Garry <john.garry@huawei.com>
Tested-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: William Cohen <wcohen@redhat.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linuxarm at huawei.com
Link: http://lkml.kernel.org/r/1520506716-197429-6-git-send-email-john.garry at huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../cavium/{thunderx2-imp-def.json => thunderx2/core-imp-def.json}      | 0
 tools/perf/pmu-events/arch/arm64/mapfile.csv                            | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/perf/pmu-events/arch/arm64/cavium/{thunderx2-imp-def.json => thunderx2/core-imp-def.json} (100%)

diff --git a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2-imp-def.json b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/cavium/thunderx2-imp-def.json
rename to tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index e61c9ca6cf9e..952a05cbf675 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -12,5 +12,5 @@
 #
 #
 #Family-model,Version,Filename,EventType
-0x00000000420f5160,v1,cavium,core
+0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000410fd03[[:xdigit:]],v1,cortex-a53,core
-- 
2.14.3
