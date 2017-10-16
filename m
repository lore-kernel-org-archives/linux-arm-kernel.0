From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Tue, 17 Oct 2017 00:02:21 +0530
Subject: [PATCH v9 4/5] perf vendor events arm64: Add ThunderX2 implementation
 defined pmu core events
In-Reply-To: <20171016183222.25750-1-ganapatrao.kulkarni@cavium.com>
References: <20171016183222.25750-1-ganapatrao.kulkarni@cavium.com>
Message-ID: <20171016183222.25750-5-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is not a full event list, but a short list of useful events.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 .../arch/arm64/cavium/thunderx2-imp-def.json       | 62 ++++++++++++++++++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv       | 15 ++++++
 2 files changed, 77 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/cavium/thunderx2-imp-def.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/mapfile.csv

diff --git a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2-imp-def.json b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2-imp-def.json
new file mode 100644
index 0000000..2db45c4
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2-imp-def.json
@@ -0,0 +1,62 @@
+[
+    {
+        "PublicDescription": "Attributable Level 1 data cache access, read",
+        "EventCode": "0x40",
+        "EventName": "l1d_cache_rd",
+        "BriefDescription": "L1D cache read",
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data cache access, write ",
+        "EventCode": "0x41",
+        "EventName": "l1d_cache_wr",
+        "BriefDescription": "L1D cache write",
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data cache refill, read",
+        "EventCode": "0x42",
+        "EventName": "l1d_cache_refill_rd",
+        "BriefDescription": "L1D cache refill read",
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data cache refill, write",
+        "EventCode": "0x43",
+        "EventName": "l1d_cache_refill_wr",
+        "BriefDescription": "L1D refill write",
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data TLB refill, read",
+        "EventCode": "0x4C",
+        "EventName": "l1d_tlb_refill_rd",
+        "BriefDescription": "L1D tlb refill read",
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data TLB refill, write",
+        "EventCode": "0x4D",
+        "EventName": "l1d_tlb_refill_wr",
+        "BriefDescription": "L1D tlb refill write",
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data or unified TLB access, read",
+        "EventCode": "0x4E",
+        "EventName": "l1d_tlb_rd",
+        "BriefDescription": "L1D tlb read",
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data or unified TLB access, write",
+        "EventCode": "0x4F",
+        "EventName": "l1d_tlb_wr",
+        "BriefDescription": "L1D tlb write",
+    },
+    {
+        "PublicDescription": "Bus access read",
+        "EventCode": "0x60",
+        "EventName": "bus_access_rd",
+        "BriefDescription": "Bus access read",
+   },
+   {
+        "PublicDescription": "Bus access write",
+        "EventCode": "0x61",
+        "EventName": "bus_access_wr",
+        "BriefDescription": "Bus access write",
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
new file mode 100644
index 0000000..219d675
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -0,0 +1,15 @@
+# Format:
+#	MIDR,Version,JSON/file/pathname,Type
+#
+# where
+#	MIDR	Processor version
+#		Variant[23:20] and Revision [3:0] should be zero.
+#	Version could be used to track version of of JSON file
+#		but currently unused.
+#	JSON/file/pathname is the path to JSON file, relative
+#		to tools/perf/pmu-events/arch/arm64/.
+#	Type is core, uncore etc
+#
+#
+#Family-model,Version,Filename,EventType
+0x00000000420f5160,v1,cavium,core
-- 
2.9.4
