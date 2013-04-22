From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 22 Apr 2013 16:04:37 +0530
Subject: [PATCH 18/23] dma: coh901318: add devicetree support
In-Reply-To: <1366624770-6786-1-git-send-email-linus.walleij@stericsson.com>
References: <1366624770-6786-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130422103437.GX24632@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 11:59:30AM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This adds support for probing the COH 901 318 DMA controller
> from the device tree.
> 
> Cc: Vinod Koul <vinod.koul@intel.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Vinod Koul <vinod.koul@intel.com>

--
~Vinod
> ---
> Hi Vinod, I'm seeking an ACK on this patch to take it through
> the ARM SoC tree.
> ---
>  drivers/dma/coh901318.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
> index 797940e..2855646 100644
> --- a/drivers/dma/coh901318.c
> +++ b/drivers/dma/coh901318.c
> @@ -2758,11 +2758,16 @@ static int __exit coh901318_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct of_device_id coh901318_dt_match[] = {
> +	{ .compatible = "stericsson,coh901318" },
> +	{},
> +};
>  
>  static struct platform_driver coh901318_driver = {
>  	.remove = __exit_p(coh901318_remove),
>  	.driver = {
>  		.name	= "coh901318",
> +		.of_match_table = coh901318_dt_match,
>  	},
>  };
>  
> -- 
> 1.7.11.3
> 
