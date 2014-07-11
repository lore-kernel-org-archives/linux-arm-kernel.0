From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Jul 2014 15:07:08 +0200
Subject: [PATCH] ASoC: rockchips: fix build error
Message-ID: <1405084028-1209898-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added rockchip_i2s driver is lacking an include of
linux/module.h, causing a build error in some cases:

../sound/soc/rockchip/rockchip_i2s.c:526:20: error: expected declaration specifiers or '...' before string constant
 MODULE_DESCRIPTION("ROCKCHIP IIS ASoC Interface");

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jianqun Xu <xjq@rock-chips.com>
---
 sound/soc/rockchip/rockchip_i2s.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index af1d8eb94f04..c3e53feba5b9 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/of_gpio.h>
 #include <linux/clk.h>
+#include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <sound/pcm_params.h>
-- 
1.8.3.2
