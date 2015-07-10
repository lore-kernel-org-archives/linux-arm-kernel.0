From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 10 Jul 2015 15:27:30 +0900
Subject: [PATCH] pinctrl: Drop owner assignment from platform_driver
Message-ID: <1436509650-5218-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_driver does not need to set an owner because
platform_driver_register() will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html
---
 drivers/pinctrl/sirf/pinctrl-atlas7.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-atlas7.c b/drivers/pinctrl/sirf/pinctrl-atlas7.c
index 9384e0aa3996..d6e80fe1c7f7 100644
--- a/drivers/pinctrl/sirf/pinctrl-atlas7.c
+++ b/drivers/pinctrl/sirf/pinctrl-atlas7.c
@@ -4621,7 +4621,6 @@ failed:
 static struct platform_driver atlas7_gpio_driver = {
 	.driver = {
 		.name = "atlas7-gpio",
-		.owner = THIS_MODULE,
 		.of_match_table = atlas7_gpio_ids,
 	},
 	.probe = atlas7_gpio_probe,
-- 
1.9.1
