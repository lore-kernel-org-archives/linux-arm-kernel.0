From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun,  8 May 2011 13:51:20 +0100
Subject: [PATCH v5 01/19] ARM: LPAE: Use long long printk format for
	displaying the pud
In-Reply-To: <1304859098-10760-1-git-send-email-catalin.marinas@arm.com>
References: <1304859098-10760-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1304859098-10760-2-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently using just long but this is not enough for the LPAE format
(64-bit entries).

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/fault.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index bc0e1d8..ee76923 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -94,7 +94,7 @@ void show_pte(struct mm_struct *mm, unsigned long addr)
 
 		pud = pud_offset(pgd, addr);
 		if (PTRS_PER_PUD != 1)
-			printk(", *pud=%08lx", pud_val(*pud));
+			printk(", *pud=%08llx", (long long)pud_val(*pud));
 
 		if (pud_none(*pud))
 			break;
