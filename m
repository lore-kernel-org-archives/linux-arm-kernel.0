From: john.garry@huawei.com (John Garry)
Date: Wed, 6 Dec 2017 00:13:19 +0800
Subject: [RFC PATCH 5/5] perf vendor events arm64: add HiSilicon hip08 JSON
In-Reply-To: <1512490399-94107-1-git-send-email-john.garry@huawei.com>
References: <1512490399-94107-1-git-send-email-john.garry@huawei.com>
Message-ID: <1512490399-94107-6-git-send-email-john.garry@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add HiSilicon hip08 JSON. Since hip08 has its events
implementated according to ARM recommendation, only add
fields "EventCode" (where applicable - hip08 also has
implemented some other custom events).

Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 .../arch/arm64/hisilicon/hip08/core-imp-def.json   | 122 +++++++++++++++++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |   1 +
 2 files changed, 123 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json
new file mode 100644
index 0000000..94fde40
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json
@@ -0,0 +1,122 @@
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
+        "EventCode": "0x46",
+    },
+    {
+        "EventCode": "0x47",
+    },
+    {
+        "EventCode": "0x48",
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
+        "EventCode": "0x50",
+    },
+    {
+        "EventCode": "0x51",
+    },
+    {
+        "EventCode": "0x52",
+    },
+    {
+        "EventCode": "0x53",
+    },
+    {
+        "EventCode": "0x56",
+    },
+    {
+        "EventCode": "0x57",
+    },
+    {
+        "EventCode": "0x58",
+    },
+    {
+        "PublicDescription": "Level 1 instruction cache prefetch access count",
+        "EventCode": "0x102e",
+        "EventName": "L1I_CACHE_PRF",
+        "BriefDescription": "L1I cache prefetch access count",
+    },
+    {
+        "PublicDescription": "Level 1 instruction cache miss due to prefetch access count",
+        "EventCode": "0x102f",
+        "EventName": "L1I_CACHE_PRF_REFILL",
+        "BriefDescription": "L1I cache miss due to prefetch access count",
+    },
+    {
+        "PublicDescription": "Instruction queue is empty",
+        "EventCode": "0x1043",
+        "EventName": "IQ_IS_EMPTY",
+        "BriefDescription": "Instruction queue is empty",
+    },
+    {
+        "PublicDescription": "Instruction fetch stall cycles",
+        "EventCode": "0x1044",
+        "EventName": "IF_IS_STALL",
+        "BriefDescription": "Instruction fetch stall cycles",
+    },
+    {
+        "PublicDescription": "Instructions can receive, but not send",
+        "EventCode": "0x2014",
+        "EventName": "FETCH_BUBBLE",
+        "BriefDescription": "Instructions can receive, but not send",
+    },
+    {
+        "PublicDescription": "Prefetch request from LSU",
+        "EventCode": "0x6013",
+        "EventName": "PRF_REQ",
+        "BriefDescription": "Prefetch request from LSU",
+    },
+    {
+        "PublicDescription": "Hit on prefetched data",
+        "EventCode": "0x6014",
+        "EventName": "HIT_ON_PRF",
+        "BriefDescription": "Hit on prefetched data",
+    },
+    {
+        "PublicDescription": "Cycles of that the number of issuing micro operations are less than 4",
+        "EventCode": "0x7001",
+        "EventName": "EXE_STALL_CYCLE",
+        "BriefDescription": "Cycles of that the number of issue ups are less than 4",
+    },
+    {
+        "PublicDescription": "No any micro operation is issued and meanwhile any load operation is not resolved",
+        "EventCode": "0x7004",
+        "EventName": "MEM_STALL_ANYLOAD",
+        "BriefDescription": "No any micro operation is issued and meanwhile any load operation is not resolved",
+    },
+    {
+        "PublicDescription": "No any micro operation is issued and meanwhile there is any load operation missing L1 cache and pending data refill",
+        "EventCode": "0x7006",
+        "EventName": "MEM_STALL_L1MISS",
+        "BriefDescription": "No any micro operation is issued and meanwhile there is any load operation missing L1 cache and pending data refill",
+    },
+    {
+        "PublicDescription": "No any micro operation is issued and meanwhile there is any load operation missing both L1 and L2 cache and pending data refill from L3 cache",
+        "EventCode": "0x7007",
+        "EventName": "MEM_STALL_L2MISS",
+        "BriefDescription": "No any micro operation is issued and meanwhile there is any load operation missing both L1 and L2 cache and pending data refill from L3 cache",
+    },
+]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index 32fa0d1..9cc42da 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -13,3 +13,4 @@
 #
 #Family-model,Version,Filename,EventType
 0x00000000420f5160,v1,cavium/thunderx2,core
+0x00000000480fd010,v1,hisilicon/hip08,core
-- 
1.9.1
