From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 23 Jun 2011 18:50:47 +0100
Subject: [PATCH v3 39/40] Subject: ARM: mm: tlb-v6: Use the new processor
	struct macros
In-Reply-To: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308851448-25139-40-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/tlb-v6.S |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/tlb-v6.S b/arch/arm/mm/tlb-v6.S
index 73d7d89..a685944 100644
--- a/arch/arm/mm/tlb-v6.S
+++ b/arch/arm/mm/tlb-v6.S
@@ -90,9 +90,5 @@ ENTRY(v6wbi_flush_kern_tlb_range)
 
 	__INIT
 
-	.type	v6wbi_tlb_fns, #object
-ENTRY(v6wbi_tlb_fns)
-	.long	v6wbi_flush_user_tlb_range
-	.long	v6wbi_flush_kern_tlb_range
-	.long	v6wbi_tlb_flags
-	.size	v6wbi_tlb_fns, . - v6wbi_tlb_fns
+	/* define struct cpu_tlb_fns (see <asm/tlbflush.h> and proc-macros.S) */
+	define_tlb_functions v6wbi, v6wbi_tlb_flags
-- 
1.7.4.1
