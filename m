From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Tue,  4 Apr 2017 13:06:43 +0530
Subject: [PATCH 3/3] perf tool, arm64,
 thunderx2: Add implementation defined events for ThunderX2
In-Reply-To: <1491291403-29893-1-git-send-email-ganapatrao.kulkarni@cavium.com>
References: <1491291403-29893-1-git-send-email-ganapatrao.kulkarni@cavium.com>
Message-ID: <1491291403-29893-4-git-send-email-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is not a full event list, but a short list of useful events.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |  2 +
 .../arm64/thunderx2/implementation-defined.json    | 72 ++++++++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/mapfile.csv
 create mode 100644 tools/perf/pmu-events/arch/arm64/thunderx2/implementation-defined.json

diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
new file mode 100644
index 0000000..ba30e43
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -0,0 +1,2 @@
+Family-model,Version,Filename,EventType
+0x00000000420f5161,v1,thunderx2,core
diff --git a/tools/perf/pmu-events/arch/arm64/thunderx2/implementation-defined.json b/tools/perf/pmu-events/arch/arm64/thunderx2/implementation-defined.json
new file mode 100644
index 0000000..360e084
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/thunderx2/implementation-defined.json
@@ -0,0 +1,72 @@
+[
+    {
+        "PublicDescription": "Attributable Level 1 data cache access, read",
+        "EventCode": "0x40",
+        "EventName": "l1d_cache_access_read",
+        "BriefDescription": "l1d cache access, read",
+	"CPU" :"armv8_pmuv3_0"
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data cache access, write ",
+        "EventCode": "0x41",
+        "EventName": "l1d_cache_access_write",
+        "BriefDescription": "l1d cache access, write",
+	"CPU" :"armv8_pmuv3_0"
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data cache refill, read",
+        "EventCode": "0x42",
+        "EventName": "l1d_cache_refill_read",
+        "BriefDescription": "l1d cache refill, read",
+	"CPU" :"armv8_pmuv3_0"
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data cache refill, write",
+        "EventCode": "0x43",
+        "EventName": "l1d_cache_refill_write",
+        "BriefDescription": "l1d refill, write",
+	"CPU" :"armv8_pmuv3_0"
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data TLB refill, read",
+        "EventCode": "0x4C",
+        "EventName": "l1d_tlb_refill_read",
+        "BriefDescription": "l1d tlb refill, read",
+	"CPU" :"armv8_pmuv3_0"
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data TLB refill, write",
+        "EventCode": "0x4D",
+        "EventName": "l1d_tlb_refill_write",
+        "BriefDescription": "l1d tlb refill, write",
+	"CPU" :"armv8_pmuv3_0"
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data or unified TLB access, read",
+        "EventCode": "0x4E",
+        "EventName": "l1d_tlb_read",
+        "BriefDescription": "l1d tlb, read",
+	"CPU" :"armv8_pmuv3_0"
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data or unified TLB access, write",
+        "EventCode": "0x4F",
+        "EventName": "l1d_tlb_write",
+        "BriefDescription": "l1d tlb, write",
+	"CPU" :"armv8_pmuv3_0"
+    },
+    {
+        "PublicDescription": "Bus access, read",
+        "EventCode": "0x60",
+        "EventName": "bus_access_read",
+        "BriefDescription": "Bus access, read",
+	"CPU" :"armv8_pmuv3_0"
+   },
+   {
+        "PublicDescription": "Bus access, write",
+        "EventCode": "0x61",
+        "EventName": "bus_access_write",
+        "BriefDescription": "Bus access, write",
+	"CPU" :"armv8_pmuv3_0"
+   }
+]
-- 
1.8.1.4
