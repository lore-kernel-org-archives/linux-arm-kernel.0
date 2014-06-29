From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 29 Jun 2014 16:10:59 +0200
Subject: [PATCH v3 1/4] pinctrl: sunxi: Add IRQCHIP_SKIP_SET_WAKE flag for
 pinctrl irq chip
In-Reply-To: <1404051062-24079-1-git-send-email-hdegoede@redhat.com>
References: <1404051062-24079-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1404051062-24079-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen-Yu Tsai <wens@csie.org>

The sunxi pinctrl irq chip driver does not support wakeup at the
moment. Adding IRQCHIP_SKIP_SET_WAKE lets the irqs work with drivers
using wakeup.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index d989a10..c199337 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -630,6 +630,7 @@ static struct irq_chip sunxi_pinctrl_irq_chip = {
 	.irq_mask	= sunxi_pinctrl_irq_mask,
 	.irq_unmask	= sunxi_pinctrl_irq_unmask,
 	.irq_set_type	= sunxi_pinctrl_irq_set_type,
+	.flags		= IRQCHIP_SKIP_SET_WAKE,
 };
 
 static void sunxi_pinctrl_irq_handler(unsigned irq, struct irq_desc *desc)
-- 
2.0.0
