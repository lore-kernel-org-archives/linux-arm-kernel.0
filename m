From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Fri, 15 Oct 2010 01:00:01 +0200
Subject: [PATCH 1/5] mach-pcm037_eet: fix compile errors
Message-ID: <1287097205-18595-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch fix the following errors :
arch/arm/mach-mx3/mach-pcm037_eet.c:62: error: implicit declaration of function 'MXC_SPI_CS'
arch/arm/mach-mx3/mach-pcm037_eet.c:185: error: implicit declaration of function 'imx35_add_spi_imx0'

from the Kconfig pcm037 is i.MX31 based and not i.MX35 so replace
imx35_add_spi_imx0 by imx31_add_spi_imx0

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx3/mach-pcm037_eet.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-pcm037_eet.c b/arch/arm/mach-mx3/mach-pcm037_eet.c
index c8b9821..2ee5d09 100644
--- a/arch/arm/mach-mx3/mach-pcm037_eet.c
+++ b/arch/arm/mach-mx3/mach-pcm037_eet.c
@@ -14,11 +14,13 @@
 
 #include <mach/common.h>
 #include <mach/iomux-mx3.h>
+#include <mach/spi.h>
 
 #include <asm/mach-types.h>
 
 #include "pcm037.h"
 #include "devices.h"
+#include "devices-imx31.h"
 
 static unsigned int pcm037_eet_pins[] = {
 	/* Reserve and hardwire GPIO 57 high - S6E63D6 chipselect */
@@ -181,7 +183,7 @@ static int eet_init_devices(void)
 	/* SPI */
 	spi_register_board_info(pcm037_spi_dev, ARRAY_SIZE(pcm037_spi_dev));
 #if defined(CONFIG_SPI_IMX) || defined(CONFIG_SPI_IMX_MODULE)
-	imx35_add_spi_imx0(&pcm037_spi1_pdata);
+	imx31_add_spi_imx0(&pcm037_spi1_pdata);
 #endif
 
 	platform_device_register(&pcm037_gpio_keys_device);
-- 
1.7.0.4
