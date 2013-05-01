From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed,  1 May 2013 02:58:29 +0200
Subject: [PATCH 2/2] clk: si5351: Allow to build without CONFIG_OF
In-Reply-To: <1367369910-20402-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1367369910-20402-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1367369910-20402-3-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With of_clk_provider stubs for CONFIG_OF not set, we can now also enable
clk-si5351 on those architectures.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Daniel Mack <zonque@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Marek Belisko <marek.belisko@streamunlimited.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/clk/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 0357ac4..186dd0e 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -58,7 +58,6 @@ config COMMON_CLK_MAX77686
 config COMMON_CLK_SI5351
 	tristate "Clock driver for SiLabs 5351A/B/C"
 	depends on I2C
-	depends on OF
 	select REGMAP_I2C
 	select RATIONAL
 	---help---
-- 
1.7.10.4
