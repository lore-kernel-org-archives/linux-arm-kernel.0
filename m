From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 20 Nov 2017 17:26:29 +0000
Subject: [PATCH] arm64: mm: remove stale comment
Message-ID: <20171120172629.24006-1-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit:

  155433cb365ee466 ("arm64: cache: Remove support for ASID-tagged VIVT I-caches")

... the ASID rollover code no longer performs I-cache maintenance, yet a
leftover comment says it does. The comment doesn't say anything that
can't be inferred from the next line, so let's remove it entirely.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/context.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index ab9f5f0fb2c7..b48ec1e18184 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -117,7 +117,6 @@ static void flush_context(unsigned int cpu)
 		per_cpu(reserved_asids, i) = asid;
 	}
 
-	/* Queue a TLB invalidate and flush the I-cache if necessary. */
 	cpumask_setall(&tlb_flush_pending);
 }
 
-- 
2.11.0
