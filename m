From: axel.lin@ingics.com (Axel Lin)
Date: Wed, 14 May 2014 19:01:36 +0800
Subject: [PATCH] mmc: wmt-sdmmc: Use GFP_KERNEL instead of hard-coded value
In-Reply-To: <1398646711.10750.0.camel@phoenix>
References: <1398646711.10750.0.camel@phoenix>
Message-ID: <CAFRkauBCjiePz-Nj46JmDoTmgOM7ch7BoA0s5SxQ2pn29F5aNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-04-28 8:58 GMT+08:00 Axel Lin <axel.lin@ingics.com>:
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/mmc/host/wmt-sdmmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
> index 34231d5..3605c37 100644
> --- a/drivers/mmc/host/wmt-sdmmc.c
> +++ b/drivers/mmc/host/wmt-sdmmc.c
> @@ -852,7 +852,7 @@ static int wmt_mci_probe(struct platform_device *pdev)
>         priv->dma_desc_buffer = dma_alloc_coherent(&pdev->dev,
>                                                    mmc->max_blk_count * 16,
>                                                    &priv->dma_desc_device_addr,
> -                                                  208);
> +                                                  GFP_KERNEL);

Hi Ulf,
This is a pretty trivial patch.
Would you pick up this patch?

Regards,
Axel
