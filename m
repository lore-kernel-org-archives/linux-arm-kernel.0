From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 27 Jan 2011 14:00:27 +0100
Subject: [PATCH 07/13] ARM i.MX27 eukrea mbimx27: remove unnecessary
	CONFIG_SPI_IMX ifdefs
In-Reply-To: <1296133233-1062-1-git-send-email-s.hauer@pengutronix.de>
References: <1296133233-1062-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1296133233-1062-8-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
index 275c858..b6d68cf 100644
--- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
@@ -357,13 +357,11 @@ void __init eukrea_mbimx27_baseboard_init(void)
 	ads7846_dev_init();
 #endif
 
-#if defined(CONFIG_SPI_IMX) || defined(CONFIG_SPI_IMX_MODULE)
 	/* SPI_CS0 init */
 	mxc_gpio_mode(GPIO_PORTD | 28 | GPIO_GPIO | GPIO_OUT);
 	imx27_add_spi_imx0(&eukrea_mbimx27_spi0_data);
 	spi_register_board_info(eukrea_mbimx27_spi_board_info,
 			ARRAY_SIZE(eukrea_mbimx27_spi_board_info));
-#endif
 
 	/* Leds configuration */
 	mxc_gpio_mode(GPIO_PORTF | 16 | GPIO_GPIO | GPIO_OUT);
-- 
1.7.2.3
