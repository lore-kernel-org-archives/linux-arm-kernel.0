From: will.deacon@arm.com (Will Deacon)
Date: Tue, 27 Nov 2018 12:41:57 +0000
Subject: [PATCH 3/3] arm64: entry: Remove confusing comment
In-Reply-To: <1543322517-470-1-git-send-email-will.deacon@arm.com>
References: <1543322517-470-1-git-send-email-will.deacon@arm.com>
Message-ID: <1543322517-470-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The comment about SYS_MEMBARRIER_SYNC_CORE relying on ERET being
context-synchronizing is confusing and misplaced with kpti. Given that
this is already documented under Documentation/ (see arch-support.txt
for membarrier), remove the comment altogether.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index a7fc77ab4a0a..c7d050207e53 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -344,10 +344,6 @@ alternative_else_nop_endif
 	ldp	x28, x29, [sp, #16 * 14]
 	ldr	lr, [sp, #S_LR]
 	add	sp, sp, #S_FRAME_SIZE		// restore sp
-	/*
-	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on eret context synchronization
-	 * when returning from IPI handler, and when returning to user-space.
-	 */
 
 	.if	\el == 0
 alternative_insn eret, nop, ARM64_UNMAP_KERNEL_AT_EL0
-- 
2.1.4
