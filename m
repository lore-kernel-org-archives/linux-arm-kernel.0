From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Fri, 28 Apr 2017 10:23:47 +0530
Subject: [PATCH v2 4/4] perf vendor events arm64: Add implementation defined
 pmu core events of ThunderX2
In-Reply-To: <1493355227-31492-1-git-send-email-ganapatrao.kulkarni@cavium.com>
References: <1493355227-31492-1-git-send-email-ganapatrao.kulkarni@cavium.com>
Message-ID: <1493355227-31492-5-git-send-email-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is not a full event list, but a short list of useful events.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 tools/perf/pmu-events/arch/arm64/mapfile.csv       | 14 +++++
 .../arm64/thunderx2/implementation-defined.json    | 62 ++++++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/mapfile.csv
 create mode 100644 tools/perf/pmu-events/arch/arm64/thunderx2/implementation-defined.json

diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
new file mode 100644
index 0000000..bc9f798
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -0,0 +1,14 @@
+# Format:
+#	MIDR,Version,JSON/file/pathname,Type
+#
+# where
+#	MIDR	Processor version
+#	Version could be used to track version of of JSON file
+#		but currently unused.
+#	JSON/file/pathname is the path to JSON file, relative
+#		to tools/perf/pmu-events/arch/arm64/.
+#	Type is core, uncore etc
+#
+#
+#Family-model,Version,Filename,EventType
+0x00000000420f5161,v1,thunderx2,core
diff --git a/tools/perf/pmu-events/arch/arm64/thunderx2/implementation-defined.json b/tools/perf/pmu-events/arch/arm64/thunderx2/implementation-defined.json
new file mode 100644
index 0000000..cdb03db
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/thunderx2/implementation-defined.json
@@ -0,0 +1,62 @@
+[
+    {
+        "PublicDescription": "Attributable Level 1 data cache access, read",
+        "EventCode": "0x40",
+        "EventName": "l1d_cache_access_read",
+        "BriefDescription": "l1d cache access, read",
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data cache access, write ",
+        "EventCode": "0x41",
+        "EventName": "l1d_cache_access_write",
+        "BriefDescription": "l1d cache access, write",
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data cache refill, read",
+        "EventCode": "0x42",
+        "EventName": "l1d_cache_refill_read",
+        "BriefDescription": "l1d cache refill, read",
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data cache refill, write",
+        "EventCode": "0x43",
+        "EventName": "l1d_cache_refill_write",
+        "BriefDescription": "l1d refill, write",
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data TLB refill, read",
+        "EventCode": "0x4C",
+        "EventName": "l1d_tlb_refill_read",
+        "BriefDescription": "l1d tlb refill, read",
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data TLB refill, write",
+        "EventCode": "0x4D",
+        "EventName": "l1d_tlb_refill_write",
+        "BriefDescription": "l1d tlb refill, write",
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data or unified TLB access, read",
+        "EventCode": "0x4E",
+        "EventName": "l1d_tlb_read",
+        "BriefDescription": "l1d tlb, read",
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data or unified TLB access, write",
+        "EventCode": "0x4F",
+        "EventName": "l1d_tlb_write",
+        "BriefDescription": "l1d tlb, write",
+    },
+    {
+        "PublicDescription": "Bus access, read",
+        "EventCode": "0x60",
+        "EventName": "bus_access_read",
+        "BriefDescription": "Bus access, read",
+   },
+   {
+        "PublicDescription": "Bus access, write",
+        "EventCode": "0x61",
+        "EventName": "bus_access_write",
+        "BriefDescription": "Bus access, write",
+   }
+]
-- 
1.8.1.4
