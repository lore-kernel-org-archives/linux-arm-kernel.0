From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 12 May 2017 13:53:04 +0200
Subject: [PATCH] soc: imx: gpc: build gpc only if hardware has gpc
In-Reply-To: <20170511161215.GA24214@ohlf-Precision-7720>
References: <20170511161215.GA24214@ohlf-Precision-7720>
Message-ID: <1494589984.15454.30.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 11.05.2017, 18:12 +0200 schrieb Marc Ohlf:
> Add CONFIG_HAVE_IMX_GPC to goal definition of gpc.o,
> to avoid building it for hardware that does not need it.
> 
> Signed-off-by: Marc Ohlf <ohlf@mkt-sys.de>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/soc/imx/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
> index 5b6e396..aab41a5c 100644
> --- a/drivers/soc/imx/Makefile
> +++ b/drivers/soc/imx/Makefile
> @@ -1,2 +1,2 @@
> -obj-y += gpc.o
> +obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
>  obj-$(CONFIG_IMX7_PM_DOMAINS) += gpcv2.o
