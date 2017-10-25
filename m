From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 25 Oct 2017 09:23:26 +0200
Subject: [PATCH] irqchip/irq-mvebu-gicp: add missing spin_lock init
Message-ID: <20171025072326.21030-1-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A spin lock is used in the irq-mvebu-gicp driver, but it is never
initialized. This patch adds the missing spin_lock_init() call in the
driver's probe function.

Fixes: a68a63cb4dfc ("irqchip/irq-mvebu-gicp: Add new driver for Marvell GICP")
Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/irqchip/irq-mvebu-gicp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gicp.c
index b283fc90be1e..17a4a7b6cdbb 100644
--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -194,6 +194,7 @@ static int mvebu_gicp_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	gicp->dev = &pdev->dev;
+	spin_lock_init(&gicp->spi_lock);
 
 	gicp->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!gicp->res)
-- 
2.14.2
