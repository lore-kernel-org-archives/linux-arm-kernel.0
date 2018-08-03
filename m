From: seanvk.dev@oregontracks.org (Sean V Kelley)
Date: Thu,  2 Aug 2018 21:18:11 -0700
Subject: [PATCH] perf vendor events arm64: Enable JSON events for eMAG
Message-ID: <20180803041811.17065-1-seanvk.dev@oregontracks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the Ampere Computing eMAG file.  This platform
follows the ARMv8 recommended IMPLEMENTATION DEFINED events, where
applicable.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: John Garry <john.garry@huawei.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: William Cohen <wcohen@redhat.com>

Signed-off-by: Sean V Kelley <seanvk.dev@oregontracks.org>
---
 .../arch/arm64/ampere/emag/core-imp-def.json  | 32 +++++++++++++++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |  1 +
 2 files changed, 33 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/core-imp-def.json

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/core-imp-def.json
new file mode 100644
index 000000000000..bc03c06c3918
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/core-imp-def.json
@@ -0,0 +1,32 @@
+[
+    {
+        "ArchStdEvent": "L1D_CACHE_RD",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WR",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_RD",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_WR",
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_RD",
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_WR",
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_RD",
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_WR",
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_RD",
+   },
+   {
+        "ArchStdEvent": "BUS_ACCESS_WR",
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index f03e26ecb658..59cd8604b0bd 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -16,3 +16,4 @@
 0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000430f0af0,v1,cavium/thunderx2,core
 0x00000000480fd010,v1,hisilicon/hip08,core
+0x00000000500f0000,v1,ampere/emag,core
-- 
2.17.1
