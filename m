From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 3 Dec 2009 22:01:39 +0000
Subject: [PATCH 1/7] S3C64XX: Staticise platform data for PCM devices
In-Reply-To: <1259340239-12067-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20091127164312.GA11913@rakim.wolfsonmicro.main>
	<1259340239-12067-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20091203220139.GQ4808@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2009 at 04:43:53PM +0000, Mark Brown wrote:
> The symbols aren't declared and don't need to be exported, they go
> along with the device structure.

hmm, the platform data configuration patch seems to be missing, is this
based on something earlier that has been missed?
 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/plat-s3c64xx/dev-audio.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c64xx/dev-audio.c b/arch/arm/plat-s3c64xx/dev-audio.c
> index 9e07344..a21a88f 100644
> --- a/arch/arm/plat-s3c64xx/dev-audio.c
> +++ b/arch/arm/plat-s3c64xx/dev-audio.c
> @@ -118,7 +118,7 @@ static struct resource s3c64xx_pcm0_resource[] = {
>  	},
>  };
>  
> -struct s3c_audio_pdata s3c_pcm0_pdata = {
> +static struct s3c_audio_pdata s3c_pcm0_pdata = {
>  	.cfg_gpio = s3c64xx_pcm_cfg_gpio,
>  };
>  
> @@ -151,7 +151,7 @@ static struct resource s3c64xx_pcm1_resource[] = {
>  	},
>  };
>  
> -struct s3c_audio_pdata s3c_pcm1_pdata = {
> +static struct s3c_audio_pdata s3c_pcm1_pdata = {
>  	.cfg_gpio = s3c64xx_pcm_cfg_gpio,
>  };
>  
> -- 
> 1.6.5.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
