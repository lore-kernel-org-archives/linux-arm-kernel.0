From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 6 Jun 2011 10:50:51 +0200
Subject: [PATCH v4 0/2] Move plat-mxc gpio driver into drivers/gpio
In-Reply-To: <1307290075-7062-1-git-send-email-shawn.guo@linaro.org>
References: <1307290075-7062-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110606085051.GA23771@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2011 at 12:07:53AM +0800, Shawn Guo wrote:
> The patch set moves plat-mxc gpio driver into drivers/gpio, and
> migrates mach-imx and mach-mx5 to the new driver.
> 
> Changes since v3:
>  * Reorganize the patch set per Grant's comments
> 
> Shawn Guo (2):
>       gpio/mxc: Move Freescale MXC gpio driver to drivers/gpio
>       gpio/mxc: Change gpio-mxc into an upstanding gpio driver
> 
>  arch/arm/plat-mxc/include/mach/common.h            |   12 +-
>  arch/arm/plat-mxc/include/mach/devices-common.h    |    2 +
>  arch/arm/plat-mxc/include/mach/gpio.h              |   27 ---
>  drivers/gpio/Kconfig                               |    4 +
>  drivers/gpio/Makefile                              |    1 +
>  .../arm/plat-mxc/gpio.c => drivers/gpio/gpio-mxc.c |  217 +++++++++++++-------

While at renaming I'd prefer naming this file gpio-imx.c. We currently
have inconsistent naming between mxc vs. imx and I'd like to get rid
of the former.

Otherwise:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
