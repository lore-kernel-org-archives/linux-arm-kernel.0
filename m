From: chao.xie@marvell.com (Chao Xie)
Date: Fri,  9 Sep 2011 12:18:11 +0800
Subject: [PATCH 1/4] ARM: mmp: add irq_disable callback for gpio chip
Message-ID: <1315541894-19504-1-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/plat-pxa/gpio.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-pxa/gpio.c b/arch/arm/plat-pxa/gpio.c
index a11dc36..15de09d 100644
--- a/arch/arm/plat-pxa/gpio.c
+++ b/arch/arm/plat-pxa/gpio.c
@@ -263,6 +263,7 @@ static struct irq_chip pxa_muxed_gpio_chip = {
 	.irq_ack	= pxa_ack_muxed_gpio,
 	.irq_mask	= pxa_mask_muxed_gpio,
 	.irq_unmask	= pxa_unmask_muxed_gpio,
+	.irq_disable	= pxa_mask_muxed_gpio,
 	.irq_set_type	= pxa_gpio_irq_type,
 };
 
-- 
1.7.0.4
