From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 17 Sep 2016 17:10:32 +0200
Subject: [PATCH 04/24] ste_dma40: Move an assignment in d40_lcla_allocate()
In-Reply-To: <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
Message-ID: <5fea9143-f4af-fae7-aa7e-8bbc9c13e72f@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 17 Sep 2016 08:24:46 +0200

Move one assignment for the local variable "ret" so that its setting
will only be performed after corresponding data processing succeeded
by this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/dma/ste_dma40.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 76d63b6..220129e 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3402,7 +3402,7 @@ static int __init d40_lcla_allocate(struct d40_base *base)
 	struct d40_lcla_pool *pool = &base->lcla_pool;
 	unsigned long *page_list;
 	int i, j;
-	int ret = 0;
+	int ret;
 
 	/*
 	 * This is somewhat ugly. We need 8192 bytes that are 18 bit aligned,
@@ -3474,6 +3474,7 @@ static int __init d40_lcla_allocate(struct d40_base *base)
 
 	writel(virt_to_phys(base->lcla_pool.base),
 	       base->virtbase + D40_DREG_LCLA);
+	ret = 0;
  free_page_list:
 	kfree(page_list);
 	return ret;
-- 
2.10.0
