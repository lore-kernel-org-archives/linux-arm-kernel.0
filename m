From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Feb 2013 15:15:17 +0000
Subject: [PATCH 1/2] ARM: perf: fix ARMv7 EVTYPE_MASK to include NSH bit
Message-ID: <1361805318-8477-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Masked out PMXEVTYPER.NSH means that we can't enable profiling at PL2,
regardless of the settings in the HDCR.

This patch fixes the broken mask.

Cc: <stable@vger.kernel.org>
Reported-by: Christoffer Dall <cdall@cs.columbia.edu>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_v7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 8c79a9e..039cffb 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -774,7 +774,7 @@ static const unsigned armv7_a7_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 /*
  * PMXEVTYPER: Event selection reg
  */
-#define	ARMV7_EVTYPE_MASK	0xc00000ff	/* Mask for writable bits */
+#define	ARMV7_EVTYPE_MASK	0xc80000ff	/* Mask for writable bits */
 #define	ARMV7_EVTYPE_EVENT	0xff		/* Mask for EVENT bits */
 
 /*
-- 
1.8.0
