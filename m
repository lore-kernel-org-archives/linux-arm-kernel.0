From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 23 Jun 2011 18:50:44 +0100
Subject: [PATCH v3 36/40] Subject: ARM: mm: tlb-v4: Use the new processor
	struct macros
In-Reply-To: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308851448-25139-37-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/tlb-v4.S |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/tlb-v4.S b/arch/arm/mm/tlb-v4.S
index d6c9445..17a025a 100644
--- a/arch/arm/mm/tlb-v4.S
+++ b/arch/arm/mm/tlb-v4.S
@@ -57,9 +57,5 @@ ENTRY(v4_flush_user_tlb_range)
 
 	__INITDATA
 
-	.type	v4_tlb_fns, #object
-ENTRY(v4_tlb_fns)
-	.long	v4_flush_user_tlb_range
-	.long	v4_flush_kern_tlb_range
-	.long	v4_tlb_flags
-	.size	v4_tlb_fns, . - v4_tlb_fns
+	/* define struct cpu_tlb_fns (see <asm/tlbflush.h> and proc-macros.S) */
+	define_tlb_functions v4, v4_tlb_flags
-- 
1.7.4.1
