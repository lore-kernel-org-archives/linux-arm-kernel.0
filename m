From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 Aug 2016 17:59:46 +0100
Subject: [PATCH] arm64: remove traces of perf_ops_bp
Message-ID: <1470934786-4052-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even though perf_ops_bp was removed/renamed back in commit
b0a873ebbf87bf38 ("perf: Register PMU implementations"), as part of
v2.6.37, its definition still lives on in some arch headers.

This patch removes the vestigal definition from arm64.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/hw_breakpoint.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
index 115ea2a..2487891 100644
--- a/arch/arm64/include/asm/hw_breakpoint.h
+++ b/arch/arm64/include/asm/hw_breakpoint.h
@@ -141,8 +141,6 @@ static inline void ptrace_hw_copy_thread(struct task_struct *task)
 }
 #endif
 
-extern struct pmu perf_ops_bp;
-
 /* Determine number of BRP registers available. */
 static inline int get_num_brps(void)
 {
-- 
1.9.1
