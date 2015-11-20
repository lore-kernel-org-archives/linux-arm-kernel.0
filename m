From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 20 Nov 2015 17:56:10 +0100
Subject: [PATCH 3/4] spi: mediatek: remove needless pair of
 writel()/readl()
In-Reply-To: <1447986080-31410-3-git-send-email-leilk.liu@mediatek.com>
References: <1447986080-31410-1-git-send-email-leilk.liu@mediatek.com>
 <1447986080-31410-3-git-send-email-leilk.liu@mediatek.com>
Message-ID: <564F50AA.50000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20/11/15 03:21, Leilk Liu wrote:
> It's not need to re-read and re-write SPI_CMD_REG, so remove it.
>
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>   drivers/spi/spi-mt65xx.c |    3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> index 7840067..6c1a96e 100644
> --- a/drivers/spi/spi-mt65xx.c
> +++ b/drivers/spi/spi-mt65xx.c
> @@ -154,9 +154,6 @@ static int mtk_spi_prepare_message(struct spi_master *master,
>   		reg_val |= SPI_CMD_CPOL;
>   	else
>   		reg_val &= ~SPI_CMD_CPOL;
> -	writel(reg_val, mdata->base + SPI_CMD_REG);
> -
> -	reg_val = readl(mdata->base + SPI_CMD_REG);
>
>   	/* set the mlsbx and mlsbtx */
>   	if (chip_config->tx_mlsb)
>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
