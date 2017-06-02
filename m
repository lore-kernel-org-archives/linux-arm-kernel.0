From: tklauser@distanz.ch (Tobias Klauser)
Date: Fri,  2 Jun 2017 13:29:58 +0200
Subject: [PATCH] pinctrl: sunxi: constify irq_domain_ops
Message-ID: <20170602112958.3882-1-tklauser@distanz.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct irq_domain_ops is not modified, so it can be made const.

Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 58774acfc814..0dfd7fa66c48 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -979,7 +979,7 @@ static int sunxi_pinctrl_irq_of_xlate(struct irq_domain *d,
 	return 0;
 }
 
-static struct irq_domain_ops sunxi_pinctrl_irq_domain_ops = {
+static const struct irq_domain_ops sunxi_pinctrl_irq_domain_ops = {
 	.xlate		= sunxi_pinctrl_irq_of_xlate,
 };
 
-- 
2.13.0
