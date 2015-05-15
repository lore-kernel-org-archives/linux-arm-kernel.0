From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Fri, 15 May 2015 16:59:01 +0300
Subject: [PATCH v2 2/5] x86: kasan: fix types in kasan page tables declarations
In-Reply-To: <1431698344-28054-1-git-send-email-a.ryabinin@samsung.com>
References: <1431698344-28054-1-git-send-email-a.ryabinin@samsung.com>
Message-ID: <1431698344-28054-3-git-send-email-a.ryabinin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
---
 arch/x86/include/asm/kasan.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kasan.h b/arch/x86/include/asm/kasan.h
index 8b22422..b766c55 100644
--- a/arch/x86/include/asm/kasan.h
+++ b/arch/x86/include/asm/kasan.h
@@ -15,8 +15,8 @@
 #ifndef __ASSEMBLY__
 
 extern pte_t kasan_zero_pte[];
-extern pte_t kasan_zero_pmd[];
-extern pte_t kasan_zero_pud[];
+extern pmd_t kasan_zero_pmd[];
+extern pud_t kasan_zero_pud[];
 
 #ifdef CONFIG_KASAN
 void __init kasan_map_early_shadow(pgd_t *pgd);
-- 
2.4.0
