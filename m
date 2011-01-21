From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 21 Jan 2011 16:33:51 +0100
Subject: [PATCH] mmc: mmc_mxc: Allow selection only for the correct
	platforms
In-Reply-To: <1295542979-10329-1-git-send-email-fabio.estevam@freescale.com>
References: <1295542979-10329-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20110121153351.GR14956@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hallo,

On Thu, Jan 20, 2011 at 03:02:59PM -0200, Fabio Estevam wrote:
> Currently MMC_MXC driver can be selected by all i.MX devices.
> 
> Restrict its use only for the appropriate processors.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/mmc/host/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index d618e86..a3a9ec1 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -288,7 +288,7 @@ config MMC_MSM
>  
>  config MMC_MXC
>  	tristate "Freescale i.MX2/3 Multimedia Card Interface support"
> -	depends on ARCH_MXC
> +	depends on MACH_MX21 || MACH_MX27 || ARCH_MX31
What about

	depends IMX_HAVE_PLATFORM_MXC_MMC

?  Then if i.MX29 has the same IP you don't need to touch this again.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
