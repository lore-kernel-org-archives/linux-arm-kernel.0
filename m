From: zhongjiang@huawei.com (zhongjiang)
Date: Sat, 10 Dec 2016 15:04:29 +0800
Subject: [RFC PATCH] arm64: change from CONT_PMD_SHIFT to CONT_PTE_SHIFT
Message-ID: <1481353469-38755-1-git-send-email-zhongjiang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: zhong jiang <zhongjiang@huawei.com>

I think that CONT_PTE_SHIFT is more reasonable even if they are some
value. and the patch is not any functional change.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 arch/arm64/mm/hugetlbpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 2e49bd2..0a4c97b 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -323,7 +323,7 @@ static __init int setup_hugepagesz(char *opt)
 static __init int add_default_hugepagesz(void)
 {
 	if (size_to_hstate(CONT_PTES * PAGE_SIZE) == NULL)
-		hugetlb_add_hstate(CONT_PMD_SHIFT);
+		hugetlb_add_hstate(CONT_PTE_SHIFT);
 	return 0;
 }
 arch_initcall(add_default_hugepagesz);
-- 
1.8.3.1
