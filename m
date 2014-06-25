From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Wed, 25 Jun 2014 17:49:04 +0200
Subject: [PATCH] pinctrl: st: add IRQCHIP_SKIP_SET_WAKE flag
Message-ID: <1403711344-17335-1-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David PARIS <david.paris@st.com>

no .irq_set_wake API is available for pinctrl-st driver.
Add the IRQCHIP_SKIP_SET_WAKE flag to inform irq handler
not to call this API.

Signed-off-by: David Paris <david.paris@st.com>
---
 drivers/pinctrl/pinctrl-st.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index fb601fe..d881406 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -1530,6 +1530,7 @@ static struct irq_chip st_gpio_irqchip = {
 	.irq_set_type	= st_gpio_irq_set_type,
 	.irq_startup	= st_gpio_irq_startup,
 	.irq_shutdown	= st_gpio_irq_shutdown,
+	.flags		= IRQCHIP_SKIP_SET_WAKE,
 };
 
 static int st_gpio_irq_domain_map(struct irq_domain *h,
-- 
1.9.1
