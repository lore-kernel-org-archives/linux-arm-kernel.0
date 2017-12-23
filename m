From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 23 Dec 2017 20:55:15 +0100
Subject: [PATCH] pinctrl: at91: Delete an error message for a failed memory
 allocation in at91_pinctrl_mux_mask()
Message-ID: <b5da388b-7fa2-ad77-7b64-26eadd55b41c@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 23 Dec 2017 20:44:27 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/pinctrl/pinctrl-at91.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 03492e3c09fa..297f1d161211 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1050,10 +1050,8 @@ static int at91_pinctrl_mux_mask(struct at91_pinctrl *info,
 	info->nmux = size / gpio_banks;
 
 	info->mux_mask = devm_kzalloc(info->dev, sizeof(u32) * size, GFP_KERNEL);
-	if (!info->mux_mask) {
-		dev_err(info->dev, "could not alloc mux_mask\n");
+	if (!info->mux_mask)
 		return -ENOMEM;
-	}
 
 	ret = of_property_read_u32_array(np, "atmel,mux-mask",
 					  info->mux_mask, size);
-- 
2.15.1
