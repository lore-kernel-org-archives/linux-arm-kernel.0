From: wfp5p@virginia.edu (Bill Pemberton)
Date: Mon, 19 Nov 2012 13:25:13 -0500
Subject: [PATCH 364/493] pinctrl: remove use of __devinitconst
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353349642-3677-364-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devinitconst is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Stephen Warren <swarren@wwwdotorg.org> 
Cc: Linus Walleij <linus.walleij@linaro.org> 
Cc: Barry Song <baohua.song@csr.com> 
Cc: linux-rpi-kernel at lists.infradead.org 
Cc: linux-arm-kernel at lists.infradead.org 
---
 drivers/pinctrl/pinctrl-bcm2835.c | 6 +++---
 drivers/pinctrl/pinctrl-sirf.c    | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-bcm2835.c b/drivers/pinctrl/pinctrl-bcm2835.c
index 98bc987..1ccef36 100644
--- a/drivers/pinctrl/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/pinctrl-bcm2835.c
@@ -372,7 +372,7 @@ static int bcm2835_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 	return irq_linear_revmap(pc->irq_domain, offset);
 }
 
-static struct gpio_chip bcm2835_gpio_chip __devinitconst = {
+static struct gpio_chip bcm2835_gpio_chip = {
 	.label = MODULE_NAME,
 	.owner = THIS_MODULE,
 	.request = bcm2835_gpio_request,
@@ -931,7 +931,7 @@ static struct pinctrl_desc bcm2835_pinctrl_desc = {
 	.owner = THIS_MODULE,
 };
 
-static struct pinctrl_gpio_range bcm2835_pinctrl_gpio_range __devinitconst = {
+static struct pinctrl_gpio_range bcm2835_pinctrl_gpio_range = {
 	.name = MODULE_NAME,
 	.npins = BCM2835_NUM_GPIOS,
 };
@@ -1052,7 +1052,7 @@ static int __devexit bcm2835_pinctrl_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id bcm2835_pinctrl_match[] __devinitconst = {
+static struct of_device_id bcm2835_pinctrl_match[] = {
 	{ .compatible = "brcm,bcm2835-gpio" },
 	{}
 };
diff --git a/drivers/pinctrl/pinctrl-sirf.c b/drivers/pinctrl/pinctrl-sirf.c
index 290caa3..c776046 100644
--- a/drivers/pinctrl/pinctrl-sirf.c
+++ b/drivers/pinctrl/pinctrl-sirf.c
@@ -1305,7 +1305,7 @@ out_no_gpio_remap:
 	return ret;
 }
 
-static const struct of_device_id pinmux_ids[] __devinitconst = {
+static const struct of_device_id pinmux_ids[] = {
 	{ .compatible = "sirf,prima2-pinctrl" },
 	{ .compatible = "sirf,marco-pinctrl" },
 	{}
-- 
1.8.0
