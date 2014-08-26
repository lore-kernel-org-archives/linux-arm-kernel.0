From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Aug 2014 15:13:26 +0100
Subject: [PATCH 07/11] irqchip: gic: make gic_default_routable_irq_domain_ops
 static
In-Reply-To: <1409062410-25891-1-git-send-email-will.deacon@arm.com>
References: <1409062410-25891-1-git-send-email-will.deacon@arm.com>
Message-ID: <1409062410-25891-8-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The internal irq domain ops for the GIC are not used directly anywhere
else, so make them static. This gets rid of a sparse warning on the
file.

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/irqchip/irq-gic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 4b959e606fe8..dda6dbc23565 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -867,7 +867,7 @@ static int gic_routable_irq_domain_xlate(struct irq_domain *d,
 	return 0;
 }
 
-const struct irq_domain_ops gic_default_routable_irq_domain_ops = {
+static const struct irq_domain_ops gic_default_routable_irq_domain_ops = {
 	.map = gic_routable_irq_domain_map,
 	.unmap = gic_routable_irq_domain_unmap,
 	.xlate = gic_routable_irq_domain_xlate,
-- 
2.1.0.rc1
