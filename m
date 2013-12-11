From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 11 Dec 2013 04:26:21 +0100
Subject: [PATCH 01/10] sh-pfc: Turn unsigned indices into unsigned int
In-Reply-To: <1386732390-31724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1386732390-31724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1386732390-31724-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some indices take positive values only, make them unsigned.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/core.c | 8 ++++----
 drivers/pinctrl/sh-pfc/gpio.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index d77ece5..06e648b 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -29,7 +29,7 @@
 static int sh_pfc_ioremap(struct sh_pfc *pfc, struct platform_device *pdev)
 {
 	struct resource *res;
-	int k;
+	unsigned int k;
 
 	if (pdev->num_resources == 0)
 		return -EINVAL;
@@ -147,7 +147,7 @@ static void sh_pfc_config_reg_helper(struct sh_pfc *pfc,
 				     unsigned long *maskp,
 				     unsigned long *posp)
 {
-	int k;
+	unsigned int k;
 
 	*mapped_regp = sh_pfc_phys_to_virt(pfc, crp->reg);
 
@@ -196,7 +196,7 @@ static int sh_pfc_get_config_reg(struct sh_pfc *pfc, u16 enum_id,
 {
 	const struct pinmux_cfg_reg *config_reg;
 	unsigned long r_width, f_width, curr_width, ncomb;
-	int k, m, n, pos, bit_pos;
+	unsigned int k, m, n, pos, bit_pos;
 
 	k = 0;
 	while (1) {
@@ -238,7 +238,7 @@ static int sh_pfc_mark_to_enum(struct sh_pfc *pfc, u16 mark, int pos,
 			      u16 *enum_idp)
 {
 	const u16 *data = pfc->info->gpio_data;
-	int k;
+	unsigned int k;
 
 	if (pos) {
 		*enum_idp = data[pos + 1];
diff --git a/drivers/pinctrl/sh-pfc/gpio.c b/drivers/pinctrl/sh-pfc/gpio.c
index 04bf52b..3d30e6e 100644
--- a/drivers/pinctrl/sh-pfc/gpio.c
+++ b/drivers/pinctrl/sh-pfc/gpio.c
@@ -204,7 +204,7 @@ static void gpio_pin_set(struct gpio_chip *gc, unsigned offset, int value)
 static int gpio_pin_to_irq(struct gpio_chip *gc, unsigned offset)
 {
 	struct sh_pfc *pfc = gpio_to_pfc(gc);
-	int i, k;
+	unsigned int i, k;
 
 	for (i = 0; i < pfc->info->gpio_irq_size; i++) {
 		unsigned short *gpios = pfc->info->gpio_irq[i].gpios;
-- 
1.8.3.2
