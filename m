From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 5 Jun 2012 08:47:14 +0200
Subject: [PATCH v2 REBASE] ASoC: fsl_ssi: convert to use devm_clk_get
In-Reply-To: <1338774174-3960-1-git-send-email-richard.zhao@freescale.com>
References: <1338774174-3960-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120605064714.GL30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 04, 2012 at 09:42:53AM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> Acked-by: Timur Tabi <timur@freescale.com>
> ---
> 
> Rebase to 3.5rc1.
> 
>  sound/soc/fsl/fsl_ssi.c |    7 ++-----
>  1 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 4ed2afd..b10a427 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -725,7 +725,7 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
>  		u32 dma_events[2];
>  		ssi_private->ssi_on_imx = true;
>  
> -		ssi_private->clk = clk_get(&pdev->dev, NULL);
> +		ssi_private->clk = devm_clk_get(&pdev->dev, NULL);

Have you tried compiling this on PowerPC? devm_clk_get is only available
with CONFIG_CLKDEV_LOOKUP, I think on PowerPC this is not the case.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
