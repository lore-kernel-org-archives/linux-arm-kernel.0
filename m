From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 30 Dec 2011 02:28:15 +0000
Subject: [PATCH 1/2] ARM: S3C64XX: Enable power management for disk on
 Cragganmore
Message-ID: <1325212096-13420-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can happily let the MMC stack do power management for the MMC card
that is our main disk on Cragganmore so let's enable it.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 93b578e..139d16e 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -21,6 +21,7 @@
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <linux/delay.h>
+#include <linux/mmc/host.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
 #include <linux/pwm_backlight.h>
@@ -707,6 +708,7 @@ static struct s3c_sdhci_platdata crag6410_hsmmc0_pdata = {
 	.max_width		= 4,
 	.cd_type		= S3C_SDHCI_CD_INTERNAL,
 	.cfg_gpio		= crag6410_cfg_sdhci0,
+	.host_caps		= MMC_CAP_POWER_OFF_CARD,
 };
 
 static const struct gpio_led gpio_leds[] = {
-- 
1.7.7.3
