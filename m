From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 23 Jun 2011 18:50:42 +0100
Subject: [PATCH v3 34/40] Subject: ARM: mm: tlb-fa: Use the new processor
	struct macros
In-Reply-To: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308851448-25139-35-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/tlb-fa.S |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/tlb-fa.S b/arch/arm/mm/tlb-fa.S
index 9694f1f..7a2e56c 100644
--- a/arch/arm/mm/tlb-fa.S
+++ b/arch/arm/mm/tlb-fa.S
@@ -67,9 +67,5 @@ ENTRY(fa_flush_kern_tlb_range)
 
 	__INITDATA
 
-	.type	fa_tlb_fns, #object
-ENTRY(fa_tlb_fns)
-	.long	fa_flush_user_tlb_range
-	.long	fa_flush_kern_tlb_range
-	.long	fa_tlb_flags
-	.size	fa_tlb_fns, . - fa_tlb_fns
+	/* define struct cpu_tlb_fns (see <asm/tlbflush.h> and proc-macros.S) */
+	define_tlb_functions fa, fa_tlb_flags
-- 
1.7.4.1
