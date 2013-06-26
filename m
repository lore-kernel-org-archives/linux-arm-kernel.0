From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 26 Jun 2013 17:06:37 +0530
Subject: [PATCH 2/2] irqchip: exynos-combiner: Staticize combiner_init
In-Reply-To: <1372246597-32323-1-git-send-email-sachin.kamat@linaro.org>
References: <1372246597-32323-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1372246597-32323-2-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

combiner_init() is referenced only in this file. Make it
static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/irqchip/exynos-combiner.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/exynos-combiner.c b/drivers/irqchip/exynos-combiner.c
index a9d2b2f..4c68265 100644
--- a/drivers/irqchip/exynos-combiner.c
+++ b/drivers/irqchip/exynos-combiner.c
@@ -204,10 +204,10 @@ static unsigned int combiner_lookup_irq(int group)
 	return 0;
 }
 
-void __init combiner_init(void __iomem *combiner_base,
-			  struct device_node *np,
-			  unsigned int max_nr,
-			  int irq_base)
+static void __init combiner_init(void __iomem *combiner_base,
+				 struct device_node *np,
+				 unsigned int max_nr,
+				 int irq_base)
 {
 	int i, irq;
 	unsigned int nr_irq;
-- 
1.7.9.5
