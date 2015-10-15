From: tn@semihalf.com (Tomasz Nowicki)
Date: Thu, 15 Oct 2015 16:05:13 +0200
Subject: [PATCH V1 04/10] irqchip / GICv3: remove gic root node in ITS
In-Reply-To: <1444917919-21152-1-git-send-email-tn@semihalf.com>
References: <1444917919-21152-1-git-send-email-tn@semihalf.com>
Message-ID: <1444917919-21152-5-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

The gic_root_node defined in ITS driver is not actually
used, and the ITS driver seems will not use it in the
future, so just remove it.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index f0d64e4..9640e4d 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -94,7 +94,6 @@ struct its_device {
 
 static LIST_HEAD(its_nodes);
 static DEFINE_SPINLOCK(its_lock);
-static struct device_node *gic_root_node;
 static struct rdists *gic_rdists;
 
 #define gic_data_rdist()		(raw_cpu_ptr(gic_rdists->rdist))
@@ -1549,8 +1548,6 @@ int its_init(struct device_node *node, struct rdists *rdists,
 	}
 
 	gic_rdists = rdists;
-	gic_root_node = node;
-
 	its_alloc_lpi_tables();
 	its_lpi_init(rdists->id_bits);
 
-- 
1.9.1
