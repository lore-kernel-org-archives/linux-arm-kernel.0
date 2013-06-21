From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 21 Jun 2013 09:30:14 +0200
Subject: [PATCH RESEND] media: coda: Fix DT-driver data pointer for i.MX27
In-Reply-To: <1371746796-16123-1-git-send-email-shc_work@mail.ru>
References: <1371746796-16123-1-git-send-email-shc_work@mail.ru>
Message-ID: <1371799814.4320.3.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 20.06.2013, 20:46 +0400 schrieb Alexander Shiyan:
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/media/platform/coda.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/coda.c b/drivers/media/platform/coda.c
> index 48b8d7a..1c77781 100644
> --- a/drivers/media/platform/coda.c
> +++ b/drivers/media/platform/coda.c
> @@ -1924,7 +1924,7 @@ MODULE_DEVICE_TABLE(platform, coda_platform_ids);
>  
>  #ifdef CONFIG_OF
>  static const struct of_device_id coda_dt_ids[] = {
> -	{ .compatible = "fsl,imx27-vpu", .data = &coda_platform_ids[CODA_IMX27] },
> +	{ .compatible = "fsl,imx27-vpu", .data = &coda_devdata[CODA_IMX27] },
>  	{ .compatible = "fsl,imx53-vpu", .data = &coda_devdata[CODA_IMX53] },
>  	{ /* sentinel */ }
>  };

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

thanks
Philipp
