From: robert.richter@amd.com (Robert Richter)
Date: Mon, 30 Aug 2010 18:21:55 +0200
Subject: [PATCH] oprofile, arm: initialize perf_event pointers with NULL
Message-ID: <mailman.215.1283252618.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pointers must be NULL'ed to avoid double-freeing the pointers in
rare cases during reinitialization.

Signed-off-by: Robert Richter <robert.richter@amd.com>
---
 arch/arm/oprofile/common.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/oprofile/common.c b/arch/arm/oprofile/common.c
index c3652f7..d660cb8 100644
--- a/arch/arm/oprofile/common.c
+++ b/arch/arm/oprofile/common.c
@@ -351,6 +351,8 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 {
 	int cpu, ret = 0;
 
+	memset(&perf_events, 0, sizeof(perf_events));
+
 	perf_num_counters = armpmu_get_max_events();
 
 	counter_config = kcalloc(perf_num_counters,
-- 
1.7.1.1


-- 
Advanced Micro Devices, Inc.
Operating System Research Center
