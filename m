From: tony@atomide.com (Tony Lindgren)
Date: Wed, 8 May 2013 15:23:21 -0700
Subject: [PATCH] ARM: OMAP: RX-51: change probe order of touchscreen
 and panel SPI devices
In-Reply-To: <1367427597-30060-1-git-send-email-aaro.koskinen@iki.fi>
References: <1367427597-30060-1-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <20130508222320.GL32546@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [130501 10:06]:
> Commit 9fdca9df (spi: omap2-mcspi: convert to module_platform_driver)
> broke the SPI display/panel driver probe on RX-51/N900. The exact cause is
> not fully understood, but it seems to be related to the probe order. SPI
> communication to the panel driver (spi1.2) fails unless the touchscreen
> (spi1.0) has been probed/initialized before. When the omap2-mcspi driver
> was converted to a platform driver, it resulted in that the devices are
> probed immediately after the board registers them in the order they are
> listed in the board file.
> 
> Fix the issue by moving the touchscreen before the panel in the SPI
> device list.
> 
> The patch fixes the following failure:
> 
> [    1.260955] acx565akm spi1.2: invalid display ID
> [    1.265899] panel-acx565akm display0: acx_panel_probe panel detect error
> [    1.273071] omapdss CORE error: driver probe failed: -19

Thanks for updating the description, applying into omap-for-v3.10/fixes.

Regards,

Tony
