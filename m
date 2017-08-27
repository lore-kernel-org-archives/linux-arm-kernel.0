From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 27 Aug 2017 21:46:34 +0200
Subject: [PATCH] clocksource: Delete an error message for a failed memory
 allocation in bcm2835_timer_init()
Message-ID: <1907fa5f-e1c3-a2dd-99e0-f06150086351@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 27 Aug 2017 21:38:13 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/clocksource/bcm2835_timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/bcm2835_timer.c b/drivers/clocksource/bcm2835_timer.c
index 82828d3a4739..39e489a96ad7 100644
--- a/drivers/clocksource/bcm2835_timer.c
+++ b/drivers/clocksource/bcm2835_timer.c
@@ -114,7 +114,6 @@ static int __init bcm2835_timer_init(struct device_node *node)
 
 	timer = kzalloc(sizeof(*timer), GFP_KERNEL);
 	if (!timer) {
-		pr_err("Can't allocate timer struct\n");
 		ret = -ENOMEM;
 		goto err_iounmap;
 	}
-- 
2.14.1
