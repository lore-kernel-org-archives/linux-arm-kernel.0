From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 8 Jul 2011 12:58:51 +0200
Subject: [PATCH 2/6] spi/imx: use soc name in spi device type naming scheme
In-Reply-To: <1310113654-25887-3-git-send-email-shawn.guo@linaro.org>
References: <1310113654-25887-1-git-send-email-shawn.guo@linaro.org>
	<1310113654-25887-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110708105851.GF6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 04:27:30PM +0800, Shawn Guo wrote:
> Software defined version number is not stable enough to be used
> in device type naming scheme.  The patch changes it to use implicit
> soc name for spi device type definition.  In this way, we can easily
> align the naming scheme with device tree binding, which comes later.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
>  arch/arm/mach-imx/clock-imx25.c              |    7 +-
>  arch/arm/mach-mx5/clock-mx51-mx53.c          |   11 +-
>  arch/arm/plat-mxc/devices/platform-spi_imx.c |   12 +-
>  drivers/spi/Kconfig                          |   15 -
>  drivers/spi/spi-imx.c                        |  423 ++++++++++++--------------
>  5 files changed, 219 insertions(+), 249 deletions(-)

Generally this patch is too big for me to get the warm feeling that
everything will just work. Renaming from spi_ver_xy to imx_xy is fine,
but should be done in smaller steps and where possible not across
subsystems.

I increasingly see patches touching arch/ and drivers/ and I think
there's a high risk of merge conflicts upstream. This will not help
making Linus happy.

Please try harder to make patches orthogonal and don't try to do too
much at once.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
