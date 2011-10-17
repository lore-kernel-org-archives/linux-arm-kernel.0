From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 17 Oct 2011 22:24:26 +0100
Subject: [PATCH 1/2] gpio/samsung: Explicitly index samsung_gpio_cfgs
Message-ID: <1318886667-3320-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make it easier to follow the by number references into samsung_gpio_cfgs
by putting the indexes into the code initialising the array, improving
readability a bit. Ideally we wouldn't be using magic array indexes at all
but this is easier than coming up with a better way.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/gpio/gpio-samsung.c |   29 +++++++++++++++++++----------
 1 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
index 0680f92..ce15c7f 100644
--- a/drivers/gpio/gpio-samsung.c
+++ b/drivers/gpio/gpio-samsung.c
@@ -467,33 +467,42 @@ static struct samsung_gpio_cfg s5p64x0_gpio_cfg_rbank = {
 #endif
 
 static struct samsung_gpio_cfg samsung_gpio_cfgs[] = {
-	{
+	[0] = {
 		.cfg_eint	= 0x0,
-	}, {
+	},
+	[1] = {
 		.cfg_eint	= 0x3,
-	}, {
+	},
+	[2] = {
 		.cfg_eint	= 0x7,
-	}, {
+	},
+	[3] = {
 		.cfg_eint	= 0xF,
-	}, {
+	},
+	[4] = {
 		.cfg_eint	= 0x0,
 		.set_config	= samsung_gpio_setcfg_2bit,
 		.get_config	= samsung_gpio_getcfg_2bit,
-	}, {
+	},
+	[5] = {
 		.cfg_eint	= 0x2,
 		.set_config	= samsung_gpio_setcfg_2bit,
 		.get_config	= samsung_gpio_getcfg_2bit,
-	}, {
+	},
+	[6] = {
 		.cfg_eint	= 0x3,
 		.set_config	= samsung_gpio_setcfg_2bit,
 		.get_config	= samsung_gpio_getcfg_2bit,
-	}, {
+	},
+	[7] = {
 		.set_config	= samsung_gpio_setcfg_2bit,
 		.get_config	= samsung_gpio_getcfg_2bit,
-	}, {
+	},
+	[8] = {
 		.set_pull	= exynos4_gpio_setpull,
 		.get_pull	= exynos4_gpio_getpull,
-	}, {
+	},
+	[9] = {
 		.cfg_eint	= 0x3,
 		.set_pull	= exynos4_gpio_setpull,
 		.get_pull	= exynos4_gpio_getpull,
-- 
1.7.6.3
