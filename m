From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 17 Feb 2014 10:05:41 +0100
Subject: [PATCH v3 06/15] extcon: max14577: Add max14577 prefix to muic_irqs
In-Reply-To: <1392627950-26927-1-git-send-email-k.kozlowski@samsung.com>
References: <1392627950-26927-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1392627950-26927-7-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add max14577 prefix to muic_irqs array. This prepares for max77836
support in this extcon driver.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/extcon/extcon-max14577.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/extcon/extcon-max14577.c b/drivers/extcon/extcon-max14577.c
index fd48b4909470..fb343f4042d2 100644
--- a/drivers/extcon/extcon-max14577.c
+++ b/drivers/extcon/extcon-max14577.c
@@ -85,7 +85,7 @@ struct max14577_muic_irq {
 	unsigned int virq;
 };
 
-static struct max14577_muic_irq muic_irqs[] = {
+static struct max14577_muic_irq max14577_muic_irqs[] = {
 	{ MAXIM_IRQ_INT1_ADC,		"muic-ADC" },
 	{ MAXIM_IRQ_INT1_ADCLOW,	"muic-ADCLOW" },
 	{ MAXIM_IRQ_INT1_ADCERR,	"muic-ADCError" },
@@ -541,9 +541,9 @@ static irqreturn_t max14577_muic_irq_handler(int irq, void *data)
 	 * However we only need to know whether it was ADC, charger
 	 * or both interrupts so decode IRQ and turn on proper flags.
 	 */
-	for (i = 0; i < ARRAY_SIZE(muic_irqs); i++)
-		if (irq == muic_irqs[i].virq)
-			irq_type = muic_irqs[i].irq;
+	for (i = 0; i < ARRAY_SIZE(max14577_muic_irqs); i++)
+		if (irq == max14577_muic_irqs[i].virq)
+			irq_type = max14577_muic_irqs[i].irq;
 
 	switch (irq_type) {
 	case MAXIM_IRQ_INT1_ADC:
@@ -647,8 +647,8 @@ static int max14577_muic_probe(struct platform_device *pdev)
 	INIT_WORK(&info->irq_work, max14577_muic_irq_work);
 
 	/* Support irq domain for max14577 MUIC device */
-	for (i = 0; i < ARRAY_SIZE(muic_irqs); i++) {
-		struct max14577_muic_irq *muic_irq = &muic_irqs[i];
+	for (i = 0; i < ARRAY_SIZE(max14577_muic_irqs); i++) {
+		struct max14577_muic_irq *muic_irq = &max14577_muic_irqs[i];
 		unsigned int virq = 0;
 
 		virq = regmap_irq_get_virq(maxim_core->irq_data_muic,
-- 
1.7.9.5
