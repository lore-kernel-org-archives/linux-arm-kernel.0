From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 13 Jan 2018 11:09:27 +0100
Subject: [PATCH] pinctrl/nomadik/abx500: Use seq_putc() in
 abx500_gpio_dbg_show()
Message-ID: <88354751-0a61-4893-35ad-9a7c7337ebce@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 13 Jan 2018 11:04:29 +0100

A single character (line break) should be put into a sequence.
Thus use the corresponding function "seq_putc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/pinctrl/nomadik/pinctrl-abx500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-abx500.c b/drivers/pinctrl/nomadik/pinctrl-abx500.c
index b32c0d602024..ed47ae5b0682 100644
--- a/drivers/pinctrl/nomadik/pinctrl-abx500.c
+++ b/drivers/pinctrl/nomadik/pinctrl-abx500.c
@@ -633,7 +633,7 @@ static void abx500_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	for (i = 0; i < chip->ngpio; i++, gpio++) {
 		/* On AB8500, there is no GPIO0, the first is the GPIO 1 */
 		abx500_gpio_dbg_show_one(s, pctldev, chip, i + 1, gpio);
-		seq_printf(s, "\n");
+		seq_putc(s, '\n');
 	}
 }
 
-- 
2.15.1
