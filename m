From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Sep 2016 14:49:05 +0100
Subject: [RFC PATCH 4/8] arm64: asm-offsets: remove unused definitions
In-Reply-To: <1473947349-14521-1-git-send-email-mark.rutland@arm.com>
References: <1473947349-14521-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1473947349-14521-5-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Subsequent patches will move the thread_info::{task,cpu} fields, and the
current TI_{TASK,CPU} offset definitions are not used anywhere.

This patch removes the redundant definitions.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/asm-offsets.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 05070b7..ee764eb 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -38,8 +38,6 @@ int main(void)
   DEFINE(TI_FLAGS,		offsetof(struct thread_info, flags));
   DEFINE(TI_PREEMPT,		offsetof(struct thread_info, preempt_count));
   DEFINE(TI_ADDR_LIMIT,		offsetof(struct thread_info, addr_limit));
-  DEFINE(TI_TASK,		offsetof(struct thread_info, task));
-  DEFINE(TI_CPU,		offsetof(struct thread_info, cpu));
   BLANK();
   DEFINE(THREAD_CPU_CONTEXT,	offsetof(struct task_struct, thread.cpu_context));
   BLANK();
-- 
1.9.1
