From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 5 Feb 2013 20:48:24 +0100
Subject: [PATCH 03/14] mfd: ab8500: ensure new AB8500 pinctrl driver is probed
 correctly
In-Reply-To: <1360093715-6348-1-git-send-email-linus.walleij@stericsson.com>
References: <1360093715-6348-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1360093715-6348-4-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>

The old, BROKEN AB8500 GPIO driver has been revamped as a shiny
new pinctrl driver and has been renamed as such. So, if we would
like to make use of it, we need to register it via its new name.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Sam, it'd be nice if you could ACK these first four patches,
the series basically simplifies things a lot by not cascading
the AB8500 IRQs and duplicate code in the pinctrl driver.
---
 drivers/mfd/ab8500-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index aa5937e..bad3fe2 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -1080,7 +1080,7 @@ static struct mfd_cell ab8500_bm_devs[] = {
 
 static struct mfd_cell ab8500_devs[] = {
 	{
-		.name = "ab8500-gpio",
+		.name = "pinctrl-ab8500",
 		.of_compatible = "stericsson,ab8500-gpio",
 	},
 	{
-- 
1.7.11.3
