From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 21 Jun 2016 18:38:21 +0100
Subject: [PATCH] pinctrl: rockchip: make rockchip_irq_gc_mask_set_bit static
Message-ID: <1466530701-26685-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rockchip_irq_gc_mask_set_bit() function is not exported our used
outside of ppinctrl-rockchip.c so fix the following sparse error by
making it static:

drivers/pinctrl/pinctrl-rockchip.c:2010:6: warning: symbol 'rockchip_irq_gc_mask_set_bit' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-gpio at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-rockchip at lists.infradead.org
---
 drivers/pinctrl/pinctrl-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index a91026e..7d679c2 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -2007,7 +2007,7 @@ static void rockchip_irq_gc_mask_clr_bit(struct irq_data *d)
 	irq_gc_mask_clr_bit(d);
 }
 
-void rockchip_irq_gc_mask_set_bit(struct irq_data *d)
+static void rockchip_irq_gc_mask_set_bit(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct rockchip_pin_bank *bank = gc->private;
-- 
2.8.1
