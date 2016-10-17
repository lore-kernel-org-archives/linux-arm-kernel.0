From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Mon, 17 Oct 2016 17:16:05 +0800
Subject: [PATCH] atags_proc: add missing \n when no ATAGs
Message-ID: <1476695765-52094-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No ATAGs message is missing a \n, add it.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/kernel/atags_proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/atags_proc.c b/arch/arm/kernel/atags_proc.c
index 5a33790..d7af7b8 100644
--- a/arch/arm/kernel/atags_proc.c
+++ b/arch/arm/kernel/atags_proc.c
@@ -41,7 +41,7 @@ static int __init init_atags_procfs(void)
 	size_t size;
 
 	if (tag->hdr.tag != ATAG_CORE) {
-		pr_info("No ATAGs?");
+		pr_info("No ATAGs?\n");
 		return -EINVAL;
 	}
 
-- 
1.7.12.4
