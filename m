From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 20 Aug 2014 10:09:56 +0200
Subject: [PATCH] spi/rockchip: fixup incorrect dma direction setting
In-Reply-To: <1408506462-3686-1-git-send-email-addy.ke@rock-chips.com>
References: <1408506462-3686-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <3440626.YssIeyfVzZ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Addy,

please always remember to add a real commit message, something similar to:

"Fix typo that caused the tx direction to be set twice and left out the rx 
direction."

for example.

> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> ---
>  drivers/spi/spi-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index cb8fd6f..4ef3fd3 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -679,7 +679,7 @@ static int rockchip_spi_probe(struct platform_device
> *pdev) rs->dma_tx.addr = (dma_addr_t)(mem->start + ROCKCHIP_SPI_TXDR);
> rs->dma_rx.addr = (dma_addr_t)(mem->start + ROCKCHIP_SPI_RXDR);
> rs->dma_tx.direction = DMA_MEM_TO_DEV;
> -		rs->dma_tx.direction = DMA_DEV_TO_MEM;
> +		rs->dma_rx.direction = DMA_DEV_TO_MEM;
> 
>  		master->can_dma = rockchip_spi_can_dma;
>  		master->dma_tx = rs->dma_tx.ch;
