From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Mon, 5 Oct 2009 10:04:51 +0200 (CEST)
Subject: [PATCH] fix pcm037_eet compilation with the new SPI driver
Message-ID: <Pine.LNX.4.64.0910051001500.4337@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At some point the SPI device name in arch/arm/mach-mx3/devices.c has 
changed, which then broke compilation of pcm037_eet with the new SPI 
driver. Use the correct name.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
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
