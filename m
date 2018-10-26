From: yangyingliang@huawei.com (Yang Yingliang)
Date: Fri, 26 Oct 2018 15:51:17 +0800
Subject: [PATCH v2 1/4] irqchip/gic-v3-mbi: fix uninitialized mbi_lock
In-Reply-To: <1540540280-26612-1-git-send-email-yangyingliang@huawei.com>
References: <1540540280-26612-1-git-send-email-yangyingliang@huawei.com>
Message-ID: <1540540280-26612-2-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mbi_lock is uninitialized, use marco DEFINE_MUTEX
to initialize it.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/irqchip/irq-gic-v3-mbi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index ad70e7c..fbfa7ff 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -24,7 +24,7 @@ struct mbi_range {
 	unsigned long		*bm;
 };
 
-static struct mutex		mbi_lock;
+static DEFINE_MUTEX(mbi_lock);
 static phys_addr_t		mbi_phys_base;
 static struct mbi_range		*mbi_ranges;
 static unsigned int		mbi_range_nr;
-- 
1.8.3
