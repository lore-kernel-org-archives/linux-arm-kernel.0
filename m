From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 21 Jan 2010 01:45:30 +0000
Subject: [PATCH 1/2] S3C64XX: Staticise audio platform data
In-Reply-To: <1263992765-28479-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1263992765-28479-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20100121014530.GY10014@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2010 at 01:06:04PM +0000, Mark Brown wrote:
> It's not exported.

applied these all to next-samsung-s3c64xx2, will merge into next-samsung

next time, please add ARM: to the prefix, it would save time when applying
to the tree.
 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/plat-s3c64xx/dev-audio.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c64xx/dev-audio.c b/arch/arm/plat-s3c64xx/dev-audio.c
> index 5b89344..f6b7bfb 100644
> --- a/arch/arm/plat-s3c64xx/dev-audio.c
> +++ b/arch/arm/plat-s3c64xx/dev-audio.c
> @@ -80,7 +80,7 @@ static struct resource s3c64xx_iis0_resource[] = {
>  	},
>  };
>  
> -struct s3c_audio_pdata s3c_i2s0_pdata = {
> +static struct s3c_audio_pdata s3c_i2s0_pdata = {
>  	.cfg_gpio = s3c64xx_i2sv3_cfg_gpio,
>  };
>  
> @@ -113,7 +113,7 @@ static struct resource s3c64xx_iis1_resource[] = {
>  	},
>  };
>  
> -struct s3c_audio_pdata s3c_i2s1_pdata = {
> +static struct s3c_audio_pdata s3c_i2s1_pdata = {
>  	.cfg_gpio = s3c64xx_i2sv3_cfg_gpio,
>  };
>  
> @@ -146,7 +146,7 @@ static struct resource s3c64xx_iisv4_resource[] = {
>  	},
>  };
>  
> -struct s3c_audio_pdata s3c_i2sv4_pdata = {
> +static struct s3c_audio_pdata s3c_i2sv4_pdata = {
>  	.cfg_gpio = s3c64xx_i2sv4_cfg_gpio,
>  };
>  
> -- 
> 1.6.6
> 

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
