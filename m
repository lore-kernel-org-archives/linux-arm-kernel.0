From: john.garry@huawei.com (John Garry)
Date: Wed, 6 Dec 2017 00:13:18 +0800
Subject: [RFC PATCH 4/5] perf vendor events arm64: relocate thunderx2 JSON
In-Reply-To: <1512490399-94107-1-git-send-email-john.garry@huawei.com>
References: <1512490399-94107-1-git-send-email-john.garry@huawei.com>
Message-ID: <1512490399-94107-5-git-send-email-john.garry@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the pmu events architecture folder structure supports
arch/vendor/platform structure, relocate the ThunderX2 JSON.

Also since Cavium ThunderX2 has implemented its events
according to ARM recommendation, remove the fields apart from
"EventCode".

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../arch/arm64/cavium/thunderx2-imp-def.json       | 62 ----------------------
 .../arch/arm64/cavium/thunderx2/core-imp-def.json  | 32 +++++++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |  2 +-
 3 files changed, 33 insertions(+), 63 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/arm64/cavium/thunderx2-imp-def.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json

diff --git a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2-imp-def.json b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2-imp-def.json
deleted file mode 100644
index 2db45c4..0000000
--- a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2-imp-def.json
+++ /dev/null
@@ -1,62 +0,0 @@
-[
-    {
-        "PublicDescription": "Attributable Level 1 data cache access, read",
-        "EventCode": "0x40",
-        "EventName": "l1d_cache_rd",
-        "BriefDescription": "L1D cache read",
-    },
-    {
-        "PublicDescription": "Attributable Level 1 data cache access, write ",
-        "EventCode": "0x41",
-        "EventName": "l1d_cache_wr",
-        "BriefDescription": "L1D cache write",
-    },
-    {
-        "PublicDescription": "Attributable Level 1 data cache refill, read",
-        "EventCode": "0x42",
-        "EventName": "l1d_cache_refill_rd",
-        "BriefDescription": "L1D cache refill read",
-    },
-    {
-        "PublicDescription": "Attributable Level 1 data cache refill, write",
-        "EventCode": "0x43",
-        "EventName": "l1d_cache_refill_wr",
-        "BriefDescription": "L1D refill write",
-    },
-    {
-        "PublicDescription": "Attributable Level 1 data TLB refill, read",
-        "EventCode": "0x4C",
-        "EventName": "l1d_tlb_refill_rd",
-        "BriefDescription": "L1D tlb refill read",
-    },
-    {
-        "PublicDescription": "Attributable Level 1 data TLB refill, write",
-        "EventCode": "0x4D",
-        "EventName": "l1d_tlb_refill_wr",
-        "BriefDescription": "L1D tlb refill write",
-    },
-    {
-        "PublicDescription": "Attributable Level 1 data or unified TLB access, read",
-        "EventCode": "0x4E",
-        "EventName": "l1d_tlb_rd",
-        "BriefDescription": "L1D tlb read",
-    },
-    {
-        "PublicDescription": "Attributable Level 1 data or unified TLB access, write",
-        "EventCode": "0x4F",
-        "EventName": "l1d_tlb_wr",
-        "BriefDescription": "L1D tlb write",
-    },
-    {
-        "PublicDescription": "Bus access read",
-        "EventCode": "0x60",
-        "EventName": "bus_access_rd",
-        "BriefDescription": "Bus access read",
-   },
-   {
-        "PublicDescription": "Bus access write",
-        "EventCode": "0x61",
-        "EventName": "bus_access_wr",
-        "BriefDescription": "Bus access write",
-   }
-]
diff --git a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
new file mode 100644
index 0000000..99313eb
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
@@ -0,0 +1,32 @@
+[
+    {
+        "EventCode": "0x40",
+    },
+    {
+        "EventCode": "0x41",
+    },
+    {
+        "EventCode": "0x42",
+    },
+    {
+        "EventCode": "0x43",
+    },
+    {
+        "EventCode": "0x4C",
+    },
+    {
+        "EventCode": "0x4D",
+    },
+    {
+        "EventCode": "0x4E",
+    },
+    {
+        "EventCode": "0x4F",
+    },
+    {
+        "EventCode": "0x60",
+   },
+   {
+        "EventCode": "0x61",
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index 219d675..32fa0d1 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -12,4 +12,4 @@
 #
 #
 #Family-model,Version,Filename,EventType
-0x00000000420f5160,v1,cavium,core
+0x00000000420f5160,v1,cavium/thunderx2,core
-- 
1.9.1
