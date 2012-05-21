From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 21 May 2012 09:16:00 +0800
Subject: [PATCH 2/4] GPMI-NAND: Fixup compile issue
In-Reply-To: <1337562140-5739-2-git-send-email-marex@denx.de>
References: <1337562140-5739-1-git-send-email-marex@denx.de>
 <1337562140-5739-2-git-send-email-marex@denx.de>
Message-ID: <20120521011558.GM5427@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This one has been fixed on arm-soc.

Regards,
Shawn

On Mon, May 21, 2012 at 03:02:18AM +0200, Marek Vasut wrote:
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Huang Shijie <b32955@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> index f5f3d761..33111a9 100644
> --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> @@ -486,7 +486,7 @@ static int __devinit acquire_resources(struct gpmi_nand_data *this)
>  	if (ret)
>  		goto exit_dma_channels;
>  
> -	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +	pinctrl = devm_pinctrl_get_select_default(&this->pdev->dev);
>  	if (IS_ERR(pinctrl)) {
>  		ret = PTR_ERR(pinctrl);
>  		goto exit_pin;
> -- 
> 1.7.10
> 
