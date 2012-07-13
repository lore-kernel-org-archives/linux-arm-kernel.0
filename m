From: y@pengutronix.de (y at pengutronix.de)
Date: Fri, 13 Jul 2012 14:32:14 +0200
Subject: [PATCH 11/11] gpio/gpio-omap: make platformdata used as
 of_device_id.data const
In-Reply-To: <1342182734-321-1-git-send-email-y>
References: <1342182734-321-1-git-send-email-y>
Message-ID: <1342182734-321-13-git-send-email-y>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/gpio/gpio-omap.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 019cb7b..12ab547 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1430,19 +1430,19 @@ static struct omap_gpio_reg_offs omap4_gpio_regs = {
 	.fallingdetect =	OMAP4_GPIO_FALLINGDETECT,
 };
 
-static struct omap_gpio_platform_data omap2_pdata = {
+const static struct omap_gpio_platform_data omap2_pdata = {
 	.regs = &omap2_gpio_regs,
 	.bank_width = 32,
 	.dbck_flag = false,
 };
 
-static struct omap_gpio_platform_data omap3_pdata = {
+const static struct omap_gpio_platform_data omap3_pdata = {
 	.regs = &omap2_gpio_regs,
 	.bank_width = 32,
 	.dbck_flag = true,
 };
 
-static struct omap_gpio_platform_data omap4_pdata = {
+const static struct omap_gpio_platform_data omap4_pdata = {
 	.regs = &omap4_gpio_regs,
 	.bank_width = 32,
 	.dbck_flag = true,
-- 
1.7.10.4
