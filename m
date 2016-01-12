From: wangkefeng.wang@huawei.com (wangkefeng.wang at huawei.com)
Date: Tue, 12 Jan 2016 10:22:50 +0800
Subject: [PATCH] arm/mm: use PAGE_ALIGNED instead of IS_ALIGNED
Message-ID: <1452565370-11143-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kefeng Wang <wangkefeng.wang@huawei.com>

Use PAGE_ALIGEND macro in <linux/mm.h> to simplify code.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/mm/pageattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/pageattr.c b/arch/arm/mm/pageattr.c
index cf30daf..fa1c0f1 100644
--- a/arch/arm/mm/pageattr.c
+++ b/arch/arm/mm/pageattr.c
@@ -43,7 +43,7 @@ static int change_memory_common(unsigned long addr, int numpages,
 	int ret;
 	struct page_change_data data;
 
-	if (!IS_ALIGNED(addr, PAGE_SIZE)) {
+	if (!PAGE_ALIGNED(addr)) {
 		start &= PAGE_MASK;
 		end = start + size;
 		WARN_ON_ONCE(1);
-- 
2.6.0.GIT
