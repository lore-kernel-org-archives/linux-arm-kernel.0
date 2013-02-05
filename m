From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 5 Feb 2013 20:48:25 +0100
Subject: [PATCH 04/14] mfd: ab8500: allow AB9540 based devices to use ABX500
 pinctrl
In-Reply-To: <1360093715-6348-1-git-send-email-linus.walleij@stericsson.com>
References: <1360093715-6348-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1360093715-6348-5-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>

The old AB8500 GPIO driver has been un-BROKEN and converted into a
multi-platform pinctrl driver. If any AB9540 based devices wish to
request any GPIO pins that it offers, they can after this patch.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Sam, it'd be nice if you could ACK these first four patches,
the series basically simplifies things a lot by not cascading
the AB8500 IRQs and duplicate code in the pinctrl driver.
---
 drivers/mfd/ab8500-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index bad3fe2..a0a3f72 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -1097,7 +1097,8 @@ static struct mfd_cell ab8500_devs[] = {
 
 static struct mfd_cell ab9540_devs[] = {
 	{
-		.name = "ab8500-gpio",
+		.name = "pinctrl-ab9540",
+		.of_compatible = "stericsson,ab9540-gpio",
 	},
 	{
 		.name = "ab9540-usb",
-- 
1.7.11.3
