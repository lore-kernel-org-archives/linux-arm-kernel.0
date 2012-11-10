From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 10 Nov 2012 16:00:54 +0100
Subject: [PATCH 1/2] ARM: S3C64XX: Remove duplicated camera clock
In-Reply-To: <509e602f.a766980a.0f91.14f4@mx.google.com>
References: <509e602f.a766980a.0f91.14f4@mx.google.com>
Message-ID: <2289245.SN9NHa7Y7x@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

On Saturday 10 of November 2012 18:07:56 dron0gus at gmail.com wrote:
> From: Andrey Gusakov <dron_gus@mail.ru>
> 
> Camera clock defined two times. One in init_clocks_off array with
> "cam" name, second in clksrcs array with "camera" name. Leave
> second definition because clock have divider.
> 
> Signed-off-by: Andrey Gusakov <dron0gus@gmail.com>
> ---
>  arch/arm/mach-s3c64xx/clock.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/clock.c
> b/arch/arm/mach-s3c64xx/clock.c index cacbe45..b2d08fa 100644
> --- a/arch/arm/mach-s3c64xx/clock.c
> +++ b/arch/arm/mach-s3c64xx/clock.c
> @@ -319,10 +319,6 @@ static struct clk init_clocks_off[] = {
>  		.enable		= s3c64xx_sclk_ctrl,
>  		.ctrlbit	= S3C_CLKCON_SCLK_MFC,
>  	}, {
> -		.name		= "cam",
> -		.enable		= s3c64xx_sclk_ctrl,
> -		.ctrlbit	= S3C_CLKCON_SCLK_CAM,
> -	}, {
>  		.name		= "sclk_jpeg",
>  		.enable		= s3c64xx_sclk_ctrl,
>  		.ctrlbit	= S3C_CLKCON_SCLK_JPEG,

Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>

Best regards,
Tomasz Figa
