From: axel.lin@ingics.com (Axel Lin)
Date: Fri, 23 May 2014 16:39:00 +0800
Subject: [RESEND][PATCH] mmc: wmt-sdmmc: Remove deprecated IRQF_DISABLED
In-Reply-To: <1398594331.6291.4.camel@phoenix>
References: <1398594331.6291.4.camel@phoenix>
Message-ID: <CAFRkauB7OsS8kDy81BnMhZkR55p6JsjqL4atqohDxTFKYXWx3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-04-27 18:25 GMT+08:00 Axel Lin <axel.lin@ingics.com>:
> It's a NOOP since 2.6.35 and it will be removed one day.
> This is not trivial because current code uses hard coded 32 instead of
> IRQF_DISABLED in the request_irq call.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> This patch was sent on:
> http://www.spinics.net/lists/linux-mmc/msg22644.html
>
>  drivers/mmc/host/wmt-sdmmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
> index 5501c9f..8a48a50 100644
> --- a/drivers/mmc/host/wmt-sdmmc.c
> +++ b/drivers/mmc/host/wmt-sdmmc.c
> @@ -829,7 +829,7 @@ static int wmt_mci_probe(struct platform_device *pdev)
>                 goto fail3;
>         }
>
> -       ret = request_irq(dma_irq, wmt_mci_dma_isr, 32, "sdmmc", priv);
> +       ret = request_irq(dma_irq, wmt_mci_dma_isr, 0, "sdmmc", priv);


Hi Ulf,
Would you pick up this one?

I have no idea why current uses hard-coded 32 rather than IRQF_DISABLED.
IRQF_DISABLED is marked as DEPRECATED anyway, so just set 0 for the flags
field of request_irq.

Regards,
Axel
