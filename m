From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  4 Jun 2016 10:10:10 +0300
Subject: [PATCH 18/22] irqchip: clps711x: Remove board support
In-Reply-To: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
References: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
Message-ID: <1465024214-22120-19-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since board support for the CLPS711X platform was removed,
remove the board support from the driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/irqchip/irq-clps711x.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/irqchip/irq-clps711x.c b/drivers/irqchip/irq-clps711x.c
index f913f4d..058f1ff 100644
--- a/drivers/irqchip/irq-clps711x.c
+++ b/drivers/irqchip/irq-clps711x.c
@@ -216,12 +216,6 @@ out_kfree:
 	return err;
 }
 
-void __init clps711x_intc_init(phys_addr_t base, resource_size_t size)
-{
-	BUG_ON(_clps711x_intc_init(NULL, base, size));
-}
-
-#ifdef CONFIG_IRQCHIP
 static int __init clps711x_intc_init_dt(struct device_node *np,
 					struct device_node *parent)
 {
@@ -235,4 +229,3 @@ static int __init clps711x_intc_init_dt(struct device_node *np,
 	return _clps711x_intc_init(np, res.start, resource_size(&res));
 }
 IRQCHIP_DECLARE(clps711x, "cirrus,ep7209-intc", clps711x_intc_init_dt);
-#endif
-- 
2.4.9
