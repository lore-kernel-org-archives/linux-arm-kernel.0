From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 17 May 2010 11:51:58 +0200
Subject: [PATCH 3/6] arm/mach-mx3: add watchdog device to Phytec-boards
In-Reply-To: <1272528202-24159-4-git-send-email-w.sang@pengutronix.de>
References: <1272528202-24159-1-git-send-email-w.sang@pengutronix.de>
	<1272528202-24159-4-git-send-email-w.sang@pengutronix.de>
Message-ID: <20100517095158.GW31199@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 29, 2010 at 10:03:19AM +0200, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-mx3/mach-pcm037.c |    1 +
>  arch/arm/mach-mx3/mach-pcm043.c |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)

Applied to mxc-master (also 4/6)

Sascha

> 
> diff --git a/arch/arm/mach-mx3/mach-pcm037.c b/arch/arm/mach-mx3/mach-pcm037.c
> index 2df1ec5..5024284 100644
> --- a/arch/arm/mach-mx3/mach-pcm037.c
> +++ b/arch/arm/mach-mx3/mach-pcm037.c
> @@ -449,6 +449,7 @@ static int __init pcm037_camera_alloc_dma(const size_t buf_size)
>  static struct platform_device *devices[] __initdata = {
>  	&pcm037_flash,
>  	&pcm037_sram_device,
> +	&imx_wdt_device0,
>  	&pcm037_mt9t031,
>  	&pcm037_mt9v022,
>  };
> diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
> index 1bf1ec2..78d9185 100644
> --- a/arch/arm/mach-mx3/mach-pcm043.c
> +++ b/arch/arm/mach-mx3/mach-pcm043.c
> @@ -150,6 +150,7 @@ static struct i2c_board_info pcm043_i2c_devices[] = {
>  static struct platform_device *devices[] __initdata = {
>  	&pcm043_flash,
>  	&mxc_fec_device,
> +	&imx_wdt_device0,
>  };
>  
>  static struct pad_desc pcm043_pads[] = {
> -- 
> 1.7.0
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
