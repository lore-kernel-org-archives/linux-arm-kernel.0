From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 08 Dec 2011 10:49:54 +0900
Subject: [PATCH] ARM: S3C64XX: Gate some more clocks by default
In-Reply-To: <1323106048-7342-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1323106048-7342-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <04cb01ccb54b$aed0b5b0$0c722110$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> Gate the AC'97 and CF clocks by default. The drivers will enable them
> required.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/clock.c |   20 ++++++++++----------
>  1 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
> index d79986f..ff01112 100644
> --- a/arch/arm/mach-s3c64xx/clock.c
> +++ b/arch/arm/mach-s3c64xx/clock.c
> @@ -207,6 +207,15 @@ static struct clk init_clocks_off[] = {
>  		.enable		= s3c64xx_sclk_ctrl,
>  		.ctrlbit	= S3C_CLKCON_SCLK_MMC2_48,
>  	}, {
> +		.name		= "ac97",
> +		.parent		= &clk_p,
> +		.ctrlbit	= S3C_CLKCON_PCLK_AC97,
> +	}, {
> +		.name		= "cfcon",
> +		.parent		= &clk_h,
> +		.enable		= s3c64xx_hclk_ctrl,
> +		.ctrlbit	= S3C_CLKCON_HCLK_IHOST,
> +	}, {
>  		.name		= "dma0",
>  		.parent		= &clk_h,
>  		.enable		= s3c64xx_hclk_ctrl,
> @@ -390,16 +399,7 @@ static struct clk init_clocks[] = {
>  		.name		= "watchdog",
>  		.parent		= &clk_p,
>  		.ctrlbit	= S3C_CLKCON_PCLK_WDT,
> -	}, {
> -		.name		= "ac97",
> -		.parent		= &clk_p,
> -		.ctrlbit	= S3C_CLKCON_PCLK_AC97,
> -	}, {
> -		.name		= "cfcon",
> -		.parent		= &clk_h,
> -		.enable		= s3c64xx_hclk_ctrl,
> -		.ctrlbit	= S3C_CLKCON_HCLK_IHOST,
> -	}
> +	},
>  };
> 
>  static struct clk clk_hsmmc0 = {
> --
> 1.7.7.3

Yes, will apply.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
