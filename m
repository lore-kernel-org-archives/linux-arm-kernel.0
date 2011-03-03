From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 3 Mar 2011 15:48:58 +0200
Subject: [PATCH 4/6] video i.MX: remove mx1 compile time dependencies
In-Reply-To: <1299159060-9289-5-git-send-email-s.hauer@pengutronix.de>
References: <1299159060-9289-1-git-send-email-s.hauer@pengutronix.de>
	<1299159060-9289-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20110303134858.GH20423@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Thu, Mar 03, 2011 at 02:30:58PM +0100, Sascha Hauer wrote:
> remove usage of CONFIG_ARCH_MX1. It's mostly unused anyway, replace
> it with cpu_is_mx1() where necessary. Also, depend on
> IMX_HAVE_PLATFORM_IMX_FB instead of the architectures directly.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/video/Kconfig |    2 +-
>  drivers/video/imxfb.c |   28 ++++++----------------------
>  2 files changed, 7 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 6bafb51b..59c1e97 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -422,7 +422,7 @@ config FB_SA1100
>  
>  config FB_IMX
>  	tristate "Freescale i.MX LCD support"
> -	depends on FB && (HAVE_FB_IMX || ARCH_MX1 || ARCH_MX2)
> +	depends on FB && IMX_HAVE_PLATFORM_IMX_FB

The HAVE_FB_IMX symbol becomes redundant, then. We should remove it entirely 
from drivers/video/Kconfig and arch/arm/plat-mxc/devices/Kconfig.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
