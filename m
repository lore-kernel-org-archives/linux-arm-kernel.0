From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 27 Jan 2011 14:00:28 +0100
Subject: [PATCH 08/13] ARM i.MX31 pcm037 eet: remove unnecessary
	CONFIG_SPI_IMX ifdefs
In-Reply-To: <1296133233-1062-1-git-send-email-s.hauer@pengutronix.de>
References: <1296133233-1062-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1296133233-1062-9-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/mach-pcm037_eet.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-pcm037_eet.c b/arch/arm/mach-mx3/mach-pcm037_eet.c
index fda5654..df6fb07 100644
--- a/arch/arm/mach-mx3/mach-pcm037_eet.c
+++ b/arch/arm/mach-mx3/mach-pcm037_eet.c
@@ -180,9 +180,7 @@ static int __init eet_init_devices(void)
 
 	/* SPI */
 	spi_register_board_info(pcm037_spi_dev, ARRAY_SIZE(pcm037_spi_dev));
-#if defined(CONFIG_SPI_IMX) || defined(CONFIG_SPI_IMX_MODULE)
 	imx31_add_spi_imx0(&pcm037_spi1_pdata);
-#endif
 
 	platform_device_register(&pcm037_gpio_keys_device);
 
-- 
1.7.2.3
