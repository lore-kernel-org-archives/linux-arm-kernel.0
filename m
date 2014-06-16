From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Mon, 16 Jun 2014 14:40:51 +0900
Subject: [PATCH v3 -next 9/9] mm, CMA: clean-up log message
In-Reply-To: <1402897251-23639-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1402897251-23639-1-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <1402897251-23639-10-git-send-email-iamjoonsoo.kim@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need explicit 'CMA:' prefix, since we already define prefix
'cma:' in pr_fmt. So remove it.

Acked-by: Michal Nazarewicz <mina86@mina86.com>
Reviewed-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

diff --git a/mm/cma.c b/mm/cma.c
index 9961120..4b251b0 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -225,12 +225,12 @@ int __init cma_declare_contiguous(phys_addr_t base,
 	*res_cma = cma;
 	cma_area_count++;
 
-	pr_info("CMA: reserved %ld MiB at %08lx\n", (unsigned long)size / SZ_1M,
+	pr_info("Reserved %ld MiB at %08lx\n", (unsigned long)size / SZ_1M,
 		(unsigned long)base);
 	return 0;
 
 err:
-	pr_err("CMA: failed to reserve %ld MiB\n", (unsigned long)size / SZ_1M);
+	pr_err("Failed to reserve %ld MiB\n", (unsigned long)size / SZ_1M);
 	return ret;
 }
 
-- 
1.7.9.5
