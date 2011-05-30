From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 30 May 2011 08:45:02 +0200
Subject: [PATCH v2 0/2] Move Freescale MXS gpio driver into drivers/gpio
In-Reply-To: <1306595374-25178-1-git-send-email-shawn.guo@linaro.org>
References: <1306595374-25178-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110530064502.GC23771@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant,

I suppose we should take this through the architecture tree. Can I have
your Ack for this?

Sascha

On Sat, May 28, 2011 at 11:09:32PM +0800, Shawn Guo wrote:
> The patch set moves Freescale MXS gpio driver from mach-mxs into
> drivers/gpio.
> 
> Changes since v1:
>  * Squash the 4 gpio-mxs patches into one
>  * Do not add new gpio Kconfig option and use ARCH_MXS directly
>  * Clean up platform-gpio-mxs.c per Arnd's comments
>  * Add device mxs_apbh_bus and set it as the parent of gpio devices
> 
> Shawn Guo (2):
>       gpio: gpio-mxs: add gpio driver for Freescale MXS architecture
>       ARM: mxs: use gpio-mxs driver by adding platform device
> 
>  arch/arm/mach-mxs/Makefile                         |    2 +-
>  arch/arm/mach-mxs/devices.c                        |   11 +
>  arch/arm/mach-mxs/devices/Makefile                 |    1 +
>  arch/arm/mach-mxs/devices/platform-gpio-mxs.c      |   53 +++++
>  arch/arm/mach-mxs/gpio.h                           |   34 ---
>  arch/arm/mach-mxs/include/mach/devices-common.h    |    2 +
>  arch/arm/mach-mxs/mach-mx28evk.c                   |    1 -
>  arch/arm/mach-mxs/mm-mx23.c                        |    1 -
>  arch/arm/mach-mxs/mm-mx28.c                        |    1 -
>  drivers/gpio/Makefile                              |    1 +
>  .../arm/mach-mxs/gpio.c => drivers/gpio/gpio-mxs.c |  228 ++++++++++++--------
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
