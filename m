From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 15 Apr 2013 09:00:14 +0200
Subject: [PATCH] clk: si5351: make clk-si5351 depend on CONFIG_OF
Message-ID: <1366009214-32234-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Calling clk-si5351 driver non-OF ready was too early. This patch
makes clk-si5351 depend on CONFIG_OF again, until things get sorted out.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Reported-by: Stephen Rottweil <sfr@canb.auug.org.au>
---
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Rob Landley <rob@landley.net>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Dom Cobley <popcornmix@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Rabeeh Khoury <rabeeh@solid-run.com>
Cc: Daniel Mack <zonque@gmail.com>
Cc: Jean-Francois Moine <moinejf@free.fr>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Michal Bachraty <michal.bachraty@streamunlimited.com>
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-doc at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/clk/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 5039e41..6412f55 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -58,6 +58,7 @@ config COMMON_CLK_MAX77686
 config COMMON_CLK_SI5351
 	tristate "Clock driver for SiLabs 5351A/B/C"
 	depends on I2C
+	depends on OF
 	select REGMAP_I2C
 	select RATIONAL
 	---help---
-- 
1.7.10.4
