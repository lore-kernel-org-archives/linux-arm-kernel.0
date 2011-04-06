From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 6 Apr 2011 20:31:51 +0300
Subject: [PATCH] video: imx-fb: just depend on IMX_HAVE_PLATFORM_IMX_FB
In-Reply-To: <1302100144-17176-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1302100144-17176-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110406173151.GA7592@nataf.siach.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Wed, Apr 06, 2011 at 04:29:04PM +0200, Uwe Kleine-K?nig wrote:
> All machines having a imx-fb device now select IMX_HAVE_PLATFORM_IMX_FB,
> so HAVE_FB_IMX can go away and there is no need anymore to explicitly
> depend on ARCH_MX1 or ARCH_MX2.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---

Sascha has already sent a patch for this. See 
http://article.gmane.org/gmane.linux.ports.arm.kernel/109067.

baruch

> Hello,
> 
> should this go via Sascha's or Paul's tree?
> 
> Best regards
> Uwe
> 
>  arch/arm/plat-mxc/devices/Kconfig |    1 -
>  drivers/video/Kconfig             |    5 +----
>  2 files changed, 1 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
> index b9ab1d5..e4dcf49 100644
> --- a/arch/arm/plat-mxc/devices/Kconfig
> +++ b/arch/arm/plat-mxc/devices/Kconfig
> @@ -24,7 +24,6 @@ config IMX_HAVE_PLATFORM_IMXDI_RTC
>  
>  config IMX_HAVE_PLATFORM_IMX_FB
>  	bool
> -	select HAVE_FB_IMX
>  
>  config IMX_HAVE_PLATFORM_IMX_I2C
>  	bool
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index e6a8d8c..62f337a 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -8,9 +8,6 @@ menu "Graphics support"
>  config HAVE_FB_ATMEL
>  	bool
>  
> -config HAVE_FB_IMX
> -	bool
> -
>  config SH_MIPI_DSI
>  	tristate
>  	depends on (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
> @@ -359,7 +356,7 @@ config FB_SA1100
>  
>  config FB_IMX
>  	tristate "Freescale i.MX LCD support"
> -	depends on FB && (HAVE_FB_IMX || ARCH_MX1 || ARCH_MX2)
> +	depends on FB && IMX_HAVE_PLATFORM_IMX_FB
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> -- 

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
