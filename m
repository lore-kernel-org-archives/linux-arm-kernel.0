From: lori.hikichi@broadcom.com (Lori Hikichi)
Date: Thu, 28 Sep 2017 16:50:10 -0700
Subject: [PATCH INTERNAL 1/1] ASoC: cygnus: Remove set_fmt from SPDIF dai
 ops
In-Reply-To: <1506637775-18293-3-git-send-email-lori.hikichi@broadcom.com>
References: <1506637775-18293-1-git-send-email-lori.hikichi@broadcom.com>
 <1506637775-18293-3-git-send-email-lori.hikichi@broadcom.com>
Message-ID: <18d0bb50-7a5d-8099-7d98-57f9e40bd6cd@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 9/28/2017 3:29 PM, Lori Hikichi wrote:
> The SPDIF port cannot modify its format so a set_fmt function is not
> needed. Previously, we used a generic set_fmt for all ports and returned
> an error code for the SPDIF port. It is cleaner to not populate the
> set_fmt field.
>
> Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
> ---
>  sound/soc/bcm/cygnus-ssp.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
> index 15c438f..b9a3bb8d 100644
> --- a/sound/soc/bcm/cygnus-ssp.c
> +++ b/sound/soc/bcm/cygnus-ssp.c
> @@ -1136,6 +1136,13 @@ static int cygnus_ssp_resume(struct snd_soc_dai *cpu_dai)
>  	.set_tdm_slot	= cygnus_set_dai_tdm_slot,
>  };
>  
> +static const struct snd_soc_dai_ops cygnus_spdif_dai_ops = {
> +	.startup	= cygnus_ssp_startup,
> +	.shutdown	= cygnus_ssp_shutdown,
> +	.trigger	= cygnus_ssp_trigger,
> +	.hw_params	= cygnus_ssp_hw_params,
> +	.set_sysclk	= cygnus_ssp_set_sysclk,
> +};
>  
>  #define INIT_CPU_DAI(num) { \
>  	.name = "cygnus-ssp" #num, \
> @@ -1174,7 +1181,7 @@ static int cygnus_ssp_resume(struct snd_soc_dai *cpu_dai)
>  		.formats = SNDRV_PCM_FMTBIT_S16_LE |
>  			SNDRV_PCM_FMTBIT_S32_LE,
>  	},
> -	.ops = &cygnus_ssp_dai_ops,
> +	.ops = &cygnus_spdif_dai_ops,
>  	.suspend = cygnus_ssp_suspend,
>  	.resume = cygnus_ssp_resume,
>  };
Please ignore this patch. It was accidentally included in the patch set and is a
duplicate of another patch already in the patch set.
