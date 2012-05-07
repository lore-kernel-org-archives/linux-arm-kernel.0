From: marex@denx.de (Marek Vasut)
Date: Tue, 8 May 2012 01:38:13 +0200
Subject: [PATCH 3/6] dma: mxs-dma: make platform_device_id more generic
In-Reply-To: <1336400595-12964-4-git-send-email-shawn.guo@linaro.org>
References: <1336400595-12964-1-git-send-email-shawn.guo@linaro.org>
 <1336400595-12964-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <201205080138.13235.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Rewrite mxs_dma_is_apbh and mxs_dma_is_apbx in order to support
> other SoCs like imx6q and reform the platform_device_id for the
> better further dt support.
> 
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Huang Shijie <b32955@freescale.com>
> Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/mach-mxs/devices/platform-dma.c |   14 ++--
>  drivers/clk/mxs/clk-imx23.c              |    4 +-
>  drivers/clk/mxs/clk-imx28.c              |    4 +-
>  drivers/dma/mxs-dma.c                    |  115
> ++++++++++++++++++++--------- include/linux/fsl/mxs-dma.h              |  
> 12 +---
>  5 files changed, 93 insertions(+), 56 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/devices/platform-dma.c
> b/arch/arm/mach-mxs/devices/platform-dma.c index 6a0202b..aff4813 100644
> --- a/arch/arm/mach-mxs/devices/platform-dma.c
> +++ b/arch/arm/mach-mxs/devices/platform-dma.c
> @@ -32,17 +32,19 @@ static struct platform_device *__init mxs_add_dma(const
> char *devid,
> 
>  static int __init mxs_add_mxs_dma(void)
>  {
> -	char *apbh = "mxs-dma-apbh";
> -	char *apbx = "mxs-dma-apbx";
> +	char *mx23_apbh = "imx23-dma-apbh";
> +	char *mx23_apbx = "imx23-dma-apbx";
> +	char *mx28_apbh = "imx28-dma-apbh";
> +	char *mx28_apbx = "imx28-dma-apbx";

Oh well ... :-)
