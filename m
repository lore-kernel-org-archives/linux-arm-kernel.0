From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 Jan 2012 11:33:10 +0000
Subject: [PATCH] ARM: perf: add empty NODE event definitions for Cortex-A5 and
 Cortex-A15
Message-ID: <1327059190-14180-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 89d6c0b5 ("perf, arch: Add generic NODE cache events") added
empty NODE event definitions for the ARM PMU implementations. This was
merged along with Cortex-A5 and Cortex-A15 PMU support, so they missed
out on the original patch.

This patch adds the empty definitions to Cortex-A5 and Cortex-A15.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_v7.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 460bbbb..6933244 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -469,6 +469,20 @@ static const unsigned armv7_a5_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
 		},
 	},
+	[C(NODE)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
 };
 
 /*
@@ -579,6 +593,20 @@ static const unsigned armv7_a15_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
 		},
 	},
+	[C(NODE)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
 };
 
 /*
-- 
1.7.4.1
