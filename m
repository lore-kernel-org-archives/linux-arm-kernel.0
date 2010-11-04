From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  4 Nov 2010 17:34:19 +0100
Subject: [PATCH 3/3] ARM i.MX pcm037 eet: compile fixes
In-Reply-To: <1288888459-7293-1-git-send-email-s.hauer@pengutronix.de>
References: <1288888459-7293-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1288888459-7293-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pcm037 eet extension currently does not compile if
SPI_IMX is enabled. Fix it.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/mach-pcm037_eet.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-pcm037_eet.c b/arch/arm/mach-mx3/mach-pcm037_eet.c
index 99e0894..b93a2d0 100644
--- a/arch/arm/mach-mx3/mach-pcm037_eet.c
+++ b/arch/arm/mach-mx3/mach-pcm037_eet.c
@@ -14,6 +14,7 @@
 
 #include <mach/common.h>
 #include <mach/iomux-mx3.h>
+#include <mach/spi.h>
 
 #include <asm/mach-types.h>
 
@@ -59,14 +60,12 @@ static struct spi_board_info pcm037_spi_dev[] = {
 };
 
 /* Platform Data for MXC CSPI */
-#if defined(CONFIG_SPI_IMX) || defined(CONFIG_SPI_IMX_MODULE)
 static int pcm037_spi1_cs[] = {MXC_SPI_CS(1), IOMUX_TO_GPIO(MX31_PIN_KEY_COL7)};
 
 static const struct spi_imx_master pcm037_spi1_pdata __initconst = {
 	.chipselect = pcm037_spi1_cs,
 	.num_chipselect = ARRAY_SIZE(pcm037_spi1_cs),
 };
-#endif
 
 /* GPIO-keys input device */
 static struct gpio_keys_button pcm037_gpio_keys[] = {
-- 
1.7.2.3
