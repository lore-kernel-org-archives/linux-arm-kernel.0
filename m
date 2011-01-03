From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 03 Jan 2011 19:55:19 +0900
Subject: [PATCH] ARM: S3C64xx: Clear DMA_HALT upon start
In-Reply-To: <1294019615-18532-1-git-send-email-jassisinghbrar@gmail.com>
References: <1294019615-18532-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <01b501cbab34$b9b977e0$2d2c67a0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jassi Brar wrote:
> 
> From: Jassi Brar <jassi.brar@samsung.com>
> 
> The stop function sets the DMA_HALT bit, which prevents
> the DMA transfer to resume after stop, for example during
> audio PAUSE/PLAY cycle. Clear the HALT bit during start.
> 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
> ---
>  arch/arm/mach-s3c64xx/dma.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/dma.c b/arch/arm/mach-s3c64xx/dma.c
> index e7d03ab..d9aa072 100644
> --- a/arch/arm/mach-s3c64xx/dma.c
> +++ b/arch/arm/mach-s3c64xx/dma.c
> @@ -212,6 +212,7 @@ static int s3c64xx_dma_start(struct s3c2410_dma_chan
> *chan)
> 
>  	config = readl(chan->regs + PL080S_CH_CONFIG);
>  	config |= PL080_CONFIG_ENABLE;
> +	config &= ~PL080_CONFIG_HALT;
> 
>  	pr_debug("%s: writing config %08x\n", __func__, config);
>  	writel(config, chan->regs + PL080S_CH_CONFIG);
> --

Ok...will apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
