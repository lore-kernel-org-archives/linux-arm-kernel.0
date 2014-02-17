From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 17 Feb 2014 22:19:43 +0100
Subject: [PATCH 3/4] pinctrl-sunxi: Fix masking when setting irq type
In-Reply-To: <1392671984-29872-1-git-send-email-hdegoede@redhat.com>
References: <1392671984-29872-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1392671984-29872-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pinctrl/pinctrl-sunxi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-sunxi.c b/drivers/pinctrl/pinctrl-sunxi.c
index cc9bd1b..917af0a 100644
--- a/drivers/pinctrl/pinctrl-sunxi.c
+++ b/drivers/pinctrl/pinctrl-sunxi.c
@@ -583,7 +583,7 @@ static int sunxi_pinctrl_irq_set_type(struct irq_data *d,
 	spin_lock_irqsave(&pctl->lock, flags);
 
 	regval = readl(pctl->membase + reg);
-	regval &= ~IRQ_CFG_IRQ_MASK;
+	regval &= ~(IRQ_CFG_IRQ_MASK << index);
 	writel(regval | (mode << index), pctl->membase + reg);
 
 	spin_unlock_irqrestore(&pctl->lock, flags);
-- 
1.8.5.3
