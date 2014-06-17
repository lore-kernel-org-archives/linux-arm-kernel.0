From: msalter@redhat.com (Mark Salter)
Date: Tue, 17 Jun 2014 13:14:26 -0400
Subject: [PATCH] arm64: export __cpu_{clear,copy}_user_page functions
Message-ID: <1403025266-2326-1-git-send-email-msalter@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The __cpu_clear_user_page() and __cpu_copy_user_page() functions
are not currently exported. This prevents modules from using
clear_user_page() and opy_user_page().

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 arch/arm64/mm/copypage.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
index 9aecbac..13bbc3be 100644
--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -27,8 +27,10 @@ void __cpu_copy_user_page(void *kto, const void *kfrom, unsigned long vaddr)
 	copy_page(kto, kfrom);
 	__flush_dcache_area(kto, PAGE_SIZE);
 }
+EXPORT_SYMBOL_GPL(__cpu_copy_user_page);
 
 void __cpu_clear_user_page(void *kaddr, unsigned long vaddr)
 {
 	clear_page(kaddr);
 }
+EXPORT_SYMBOL_GPL(__cpu_clear_user_page);
-- 
1.9.0
