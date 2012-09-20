From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 20 Sep 2012 10:51:42 +0200
Subject: [PATCH 4/6] pinctrl: exynos: Mark exynos_irq_demux_eint as inline
In-Reply-To: <1348131104-24828-1-git-send-email-t.figa@samsung.com>
References: <1348131104-24828-1-git-send-email-t.figa@samsung.com>
Message-ID: <1348131104-24828-5-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The exynos_irq_demux_eint utility function is used in chained IRQ
handler for EINT16-31 to handle multiplexed interrupts. Inlining it
should improve the performance a bit.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/pinctrl/pinctrl-exynos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-exynos.c b/drivers/pinctrl/pinctrl-exynos.c
index 5648971..49ef5a2 100644
--- a/drivers/pinctrl/pinctrl-exynos.c
+++ b/drivers/pinctrl/pinctrl-exynos.c
@@ -376,7 +376,7 @@ static void exynos_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static void exynos_irq_demux_eint(int irq_base, unsigned long pend,
+static inline void exynos_irq_demux_eint(int irq_base, unsigned long pend,
 					struct irq_domain *domain)
 {
 	unsigned int irq;
-- 
1.7.12
