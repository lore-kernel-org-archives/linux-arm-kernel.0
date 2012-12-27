From: jic23@kernel.org (Jonathan Cameron)
Date: Thu, 27 Dec 2012 11:25:14 +0000
Subject: [PATCH 1/3 V2] iio: mxs: Remove unused struct mxs_lradc_chan
In-Reply-To: <1355449598-15980-1-git-send-email-marex@denx.de>
References: <1355449598-15980-1-git-send-email-marex@denx.de>
Message-ID: <50DC301A.4040103@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/14/2012 01:46 AM, Marek Vasut wrote:
> This structure definition seems to be some kind of remnant from
> previous development that accidentally made it mainline. Remove
> it as it's unused.
> 
> Remove unused "enable" field from struct mxs_lradc as well. This
> seems to be remnant of early development too.
> 
Added to togreg branch of

git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

Jonathan
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/staging/iio/adc/mxs-lradc.c |    7 -------
>  1 file changed, 7 deletions(-)
> 
> V2: The patch is now combination of previously two separate patches:
> [PATCH 1/4] iio: mxs: Remove unused struct mxs_lradc_chan
> [PATCH 2/4] iio: mxs: Remove unused fields from mxs_lradc
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index ca7c1fa..6249957 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -75,11 +75,6 @@ static const char * const mxs_lradc_irq_name[] = {
>  	"mxs-lradc-button1",
>  };
>  
> -struct mxs_lradc_chan {
> -	uint8_t				slot;
> -	uint8_t				flags;
> -};
> -
>  struct mxs_lradc {
>  	struct device		*dev;
>  	void __iomem		*base;
> @@ -90,8 +85,6 @@ struct mxs_lradc {
>  
>  	struct mutex		lock;
>  
> -	uint8_t			enable;
> -
>  	struct completion	completion;
>  };
>  
> 
