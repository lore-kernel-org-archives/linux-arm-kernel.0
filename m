From: arnd@arndb.de (Arnd Bergmann)
Date: Mon,  8 Feb 2016 15:29:49 +0100
Subject: [PATCH] pinctrl: coh901: fix initconst annotation
Message-ID: <1454941800-2776480-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clang correctly points out that the section attribute for u300_gpio_confdata
is in the wrong place:

drivers/pinctrl/pinctrl-coh901.c:130:37: error: '__section__' attribute only applies to functions and global variables

This moves it from the type name to the variable, so it actually gets
discarded.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pinctrl/pinctrl-coh901.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-coh901.c b/drivers/pinctrl/pinctrl-coh901.c
index cf7788df0f95..741b39eaeb8b 100644
--- a/drivers/pinctrl/pinctrl-coh901.c
+++ b/drivers/pinctrl/pinctrl-coh901.c
@@ -127,7 +127,7 @@ struct u300_gpio_confdata {
 }
 
 /* Initial configuration */
-static const struct __initconst u300_gpio_confdata
+static const struct u300_gpio_confdata __initconst
 bs335_gpio_config[U300_GPIO_NUM_PORTS][U300_GPIO_PINS_PER_PORT] = {
 	/* Port 0, pins 0-7 */
 	{
-- 
2.7.0
