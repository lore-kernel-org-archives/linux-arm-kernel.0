From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Tue, 12 Feb 2013 12:58:36 +0200
Subject: [PATCH 3/6] dma: coh901318_lli: avoid unbalanced locking
In-Reply-To: <1360666720-19006-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1360666720-19006-1-git-send-email-andriy.shevchenko@linux.intel.com>
Message-ID: <1360666720-19006-4-git-send-email-andriy.shevchenko@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have not checked the code but there is a possibility that custom pool->lock
is not needed at all due to dma_pool contains it's own lock.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/dma/coh901318_lli.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/coh901318_lli.c b/drivers/dma/coh901318_lli.c
index 3e96610..702112d 100644
--- a/drivers/dma/coh901318_lli.c
+++ b/drivers/dma/coh901318_lli.c
@@ -61,7 +61,7 @@ coh901318_lli_alloc(struct coh901318_pool *pool, unsigned int len)
 	dma_addr_t phy;
 
 	if (len == 0)
-		goto err;
+		return NULL;
 
 	spin_lock(&pool->lock);
 
-- 
1.7.10.4
