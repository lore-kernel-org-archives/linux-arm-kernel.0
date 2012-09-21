From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 21 Sep 2012 10:49:23 +0800
Subject: [PATCH 25/34] dma: imx-dma: remove mach/hardware.h inclusion
In-Reply-To: <20120917075814.GO6180@pengutronix.de>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <1347860103-4141-26-git-send-email-shawn.guo@linaro.org>
 <20120917075814.GO6180@pengutronix.de>
Message-ID: <20120921024921.GL2450@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 09:58:14AM +0200, Sascha Hauer wrote:
> From 3094908fcbb4532056034539ea57042cd60abf47 Mon Sep 17 00:00:00 2001
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Date: Mon, 17 Sep 2012 09:39:30 +0200
> Subject: [PATCH] ARM i.MX DMA: Fixup clock lookups after platform_device_id conversion
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-imx/clk-imx1.c          |    3 ++-
>  arch/arm/mach-imx/clk-imx21.c         |    4 ++--
>  arch/arm/mach-imx/clk-imx27.c         |    4 ++--
>  include/linux/platform_data/dma-imx.h |    4 +++-
>  4 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx1.c b/arch/arm/mach-imx/clk-imx1.c
> index 7b76bc3..e8d9242 100644
> --- a/arch/arm/mach-imx/clk-imx1.c
> +++ b/arch/arm/mach-imx/clk-imx1.c
> @@ -82,7 +82,8 @@ int __init mx1_clocks_init(unsigned long fref)
>  			pr_err("imx1 clk %d: register failed with %ld\n",
>  				i, PTR_ERR(clk[i]));
>  
> -	clk_register_clkdev(clk[dma_gate], "ahb", "imx-dma");
> +	clk_register_clkdev(clk[dma_gate], "ahb", "imx1-dma");
> +	clk_register_clkdev(clk[hclk], "ipg", "imx1-dma");

I guess the clock names should be inverted?

Shawn

>  	clk_register_clkdev(clk[mma_gate], "mma", NULL);
>  	clk_register_clkdev(clk[usbd_gate], NULL, "imx_udc.0");
>  	clk_register_clkdev(clk[per1], "per", "imx-gpt.0");
