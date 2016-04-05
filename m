From: eric@anholt.net (Eric Anholt)
Date: Mon,  4 Apr 2016 20:44:17 -0700
Subject: [PATCH 3/4] irqchip: bcm2836: Fix compiler warning on 64-bit build
In-Reply-To: <1459827858-3871-1-git-send-email-eric@anholt.net>
References: <1459827858-3871-1-git-send-email-eric@anholt.net>
Message-ID: <1459827858-3871-4-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/irqchip/irq-bcm2836.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index 4ae9f76..ee62413 100644
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
2.7.0
