From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 2 Mar 2011 09:16:48 +0100
Subject: [PATCH] ARM: imx/mx25_3ds: Fix build failure
In-Reply-To: <1299028552-13186-1-git-send-email-festevam@gmail.com>
References: <1299028552-13186-1-git-send-email-festevam@gmail.com>
Message-ID: <20110302081648.GA22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 01, 2011 at 10:15:52PM -0300, Fabio Estevam wrote:
> Commit
> ca8d906 (ARM: mach-imx: mx25_3ds: add write-protect and card-detect for SD)
> 
> assigned a non-existing member .cd_gpio in a struct esdhc_platform_data.
> This field can be added later after the esdhc patches are merged.
> Fix the build for now.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-imx/mach-mx25_3ds.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-mx25_3ds.c b/arch/arm/mach-imx/mach-mx25_3ds.c
> index 561f07f..11c25f9 100644
> --- a/arch/arm/mach-imx/mach-mx25_3ds.c
> +++ b/arch/arm/mach-imx/mach-mx25_3ds.c
> @@ -208,7 +208,6 @@ static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
>  
>  static const struct esdhc_platform_data mx25pdk_esdhc_pdata __initconst = {
>  	.wp_gpio = SD1_GPIO_WP,
> -	.cd_gpio = SD1_GPIO_CD,
>  };
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
