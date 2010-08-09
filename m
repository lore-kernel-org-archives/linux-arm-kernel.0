From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Mon, 09 Aug 2010 20:51:01 +0200
Subject: [PATCH 2/8] ARM i.MX dma-mx1-mx2: use wrapper
In-Reply-To: <1281344743-2029-3-git-send-email-s.hauer@pengutronix.de>
References: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
	<1281344743-2029-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <4C604E15.3010808@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

> diff --git a/arch/arm/mach-imx/dma-v1.c b/arch/arm/mach-imx/dma-v1.c
> index 3e8c47c..d141458 100644
> --- a/arch/arm/mach-imx/dma-v1.c
> +++ b/arch/arm/mach-imx/dma-v1.c
> @@ -35,6 +35,7 @@
...
> @@ -503,7 +517,7 @@ void imx_dma_disable(int channel)
>  	struct imx_dma_channel *imxdma = &imx_dma_channels[channel];
>  	unsigned long flags;
>  
> -	pr_debug("imxdma%d: imx_dma_disable\n", channel);
> +	pr_info("imxdma%d: imx_dma_disable\n", channel);

With this change imx_dma_enable() uses pr_debug() while imx_dma_disable uses pr_info(). Shouldn't both use the same pr_*() since the functions are paired?


Regards, Magnus
