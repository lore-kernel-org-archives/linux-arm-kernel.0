From: axel.lin@ingics.com (Axel Lin)
Date: Mon, 05 Nov 2012 21:23:50 +0800
Subject: [PATCH] pinctrl: at91: Staticize non-exported symbols
Message-ID: <1352121830.14769.2.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/pinctrl/pinctrl-at91.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 65f066c..b9e2cbd 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -566,9 +566,9 @@ static int at91_pmx_get_groups(struct pinctrl_dev *pctldev, unsigned selector,
 	return 0;
 }
 
-int at91_gpio_request_enable(struct pinctrl_dev *pctldev,
-			    struct pinctrl_gpio_range *range,
-			    unsigned offset)
+static int at91_gpio_request_enable(struct pinctrl_dev *pctldev,
+				    struct pinctrl_gpio_range *range,
+				    unsigned offset)
 {
 	struct at91_pinctrl *npct = pinctrl_dev_get_drvdata(pctldev);
 	struct at91_gpio_chip *at91_chip;
@@ -598,9 +598,9 @@ int at91_gpio_request_enable(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
-void at91_gpio_disable_free(struct pinctrl_dev *pctldev,
-			   struct pinctrl_gpio_range *range,
-			   unsigned offset)
+static void at91_gpio_disable_free(struct pinctrl_dev *pctldev,
+				   struct pinctrl_gpio_range *range,
+				   unsigned offset)
 {
 	struct at91_pinctrl *npct = pinctrl_dev_get_drvdata(pctldev);
 
@@ -952,7 +952,7 @@ err:
 	return ret;
 }
 
-int __devexit at91_pinctrl_remove(struct platform_device *pdev)
+static int __devexit at91_pinctrl_remove(struct platform_device *pdev)
 {
 	struct at91_pinctrl *info = platform_get_drvdata(pdev);
 
@@ -1249,9 +1249,11 @@ static int at91_gpio_irq_map(struct irq_domain *h, unsigned int virq,
 	return 0;
 }
 
-int at91_gpio_irq_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
-			const u32 *intspec, unsigned int intsize,
-			irq_hw_number_t *out_hwirq, unsigned int *out_type)
+static int at91_gpio_irq_domain_xlate(struct irq_domain *d,
+				      struct device_node *ctrlr,
+				      const u32 *intspec, unsigned int intsize,
+				      irq_hw_number_t *out_hwirq,
+				      unsigned int *out_type)
 {
 	struct at91_gpio_chip *at91_gpio = d->host_data;
 	int ret;
-- 
1.7.9.5
