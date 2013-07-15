From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Jul 2013 12:40:28 -0600
Subject: [PATCH V2 4/5] gpio: implement gpio-ranges binding document fix
In-Reply-To: <1373913629-32179-1-git-send-email-swarren@wwwdotorg.org>
References: <1373913629-32179-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1373913629-32179-4-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Use the new of_parse_phandle_with_fixed_args() to implement the
corrected gpio-ranges DT property definition.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/gpio/gpiolib-of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 665f953..48cda3c 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -194,8 +194,8 @@ static void of_gpiochip_add_pin_range(struct gpio_chip *chip)
 		return;
 
 	for (;; index++) {
-		ret = of_parse_phandle_with_args(np, "gpio-ranges",
-				"#gpio-range-cells", index, &pinspec);
+		ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3,
+				index, &pinspec);
 		if (ret)
 			break;
 
-- 
1.8.1.5
