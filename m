From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Fri,  2 Oct 2009 16:30:41 +0200
Subject: [PATCH 1/1] mx3: fix small typo preventing mx3-based configurations
	to compile
Message-ID: <1254493841-14974-1-git-send-email-valentin.longchamp@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This should be included an rc fix please.

Signed-off-by: Valentin Longchamp <valentin.longchamp@epfl.ch>
---
 arch/arm/mach-mx3/pcm037_eet.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/pcm037_eet.c b/arch/arm/mach-mx3/pcm037_eet.c
index 8d38600..dc6baf3 100644
--- a/arch/arm/mach-mx3/pcm037_eet.c
+++ b/arch/arm/mach-mx3/pcm037_eet.c
@@ -184,7 +184,7 @@ static int eet_init_devices(void)
 	/* SPI */
 	spi_register_board_info(pcm037_spi_dev, ARRAY_SIZE(pcm037_spi_dev));
 #if defined(CONFIG_SPI_IMX) || defined(CONFIG_SPI_IMX_MODULE)
-	mxc_register_device(&mxc_spi_device0, &pcm037_spi1_master);
+	mxc_register_device(&imx_spi_device0, &pcm037_spi1_master);
 #endif
 
 	platform_device_register(&pcm037_gpio_keys_device);
-- 
1.6.0.4
