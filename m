From: eric@anholt.net (Eric Anholt)
Date: Wed, 13 Apr 2016 13:28:42 -0700
Subject: [PATCH v2 3/4] irqchip: bcm2836: Fix compiler warning on 64-bit build
In-Reply-To: <1460579323-8099-1-git-send-email-eric@anholt.net>
References: <1460579323-8099-1-git-send-email-eric@anholt.net>
Message-ID: <1460579323-8099-3-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Anholt <eric@anholt.net>
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
---

v2: add ack

 drivers/irqchip/irq-bcm2836.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index 6b61c68b87ae..bb3d61fe4bdb 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -253,7 +253,7 @@ bcm2836_arm_irqchip_smp_init(void)
 	/* Unmask IPIs to the boot CPU. */
 	bcm2836_arm_irqchip_cpu_notify(&bcm2836_arm_irqchip_cpu_notifier,
 				       CPU_STARTING,
-				       (void *)smp_processor_id());
+				       (void *)(uintptr_t)smp_processor_id());
 	register_cpu_notifier(&bcm2836_arm_irqchip_cpu_notifier);
 
 	set_smp_cross_call(bcm2836_arm_irqchip_send_ipi);
-- 
2.8.0.rc3
