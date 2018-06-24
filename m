From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 24 Jun 2018 15:28:30 +0200
Subject: [PATCH 4/4] soc: actions: Fix help text in Kconfig for
 OWL_PM_DOMAINS
In-Reply-To: <20180411164036.8046-5-manivannan.sadhasivam@linaro.org>
References: <20180411164036.8046-1-manivannan.sadhasivam@linaro.org>
 <20180411164036.8046-5-manivannan.sadhasivam@linaro.org>
Message-ID: <62ef1835-8db9-f1e8-53b9-4cd74b5d416d@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mani,

Am 11.04.2018 um 18:40 schrieb Manivannan Sadhasivam:
> OWL_PM_DOMAINS is being used by 3 SoCs of OWL family. This fixes
> the wording to use family name OWL instead of SoC name S500.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/soc/actions/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/actions/Kconfig b/drivers/soc/actions/Kconfig
> index 9d68b5a771c3..26c3155d3738 100644
> --- a/drivers/soc/actions/Kconfig
> +++ b/drivers/soc/actions/Kconfig
> @@ -10,7 +10,7 @@ config OWL_PM_DOMAINS
>  	select PM_GENERIC_DOMAINS
>  	help
>  	  Say 'y' here to enable support for Smart Power System (SPS)
> -	  power-gating on Actions Semiconductor S500 SoC.
> +	  power-gating on Actions Semiconductor OWL SoCs.

Thanks for spotting this. However, repeating OWL from the title (which I
think should be spelled Owl in free text, given that I also read Falcon
as another bird for GT9 [*]) does not seem too helpful for people
wondering whether or not to enable the driver.

I would much rather do a patch updating this to "S500 and S700 SoCs"
with Fixes and then just add S900 as part of your preceding patch.

Regards,
Andreas

[*] https://androidpc.es/blog/2015/11/10/actions-gt7/

>  	  If unsure, say 'n'.
>  
>  endif
> 


-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
