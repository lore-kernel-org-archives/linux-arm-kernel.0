From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 29 Aug 2017 11:34:27 +0200
Subject: [PATCH 9/9] clocksource/drivers/bcm2835: Remove message on memory
 allocation failure
In-Reply-To: <1503999271-15712-1-git-send-email-daniel.lezcano@linaro.org>
References: <20170829093354.GA2572@mai>
 <1503999271-15712-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1503999271-15712-9-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>

The bcm2835_timer_init() function emits an error message in case of a memory
allocation failure. This is pointless as the mm core already do that.

Remove this message.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/bcm2835_timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/bcm2835_timer.c b/drivers/clocksource/bcm2835_timer.c
index 82828d3..39e489a 100644
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
2.7.4
