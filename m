From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Aug 2013 01:08:21 -0700
Subject: [PATCH] ARM: OMAP: dma: fix error return code in
 omap_system_dma_probe()
In-Reply-To: <CAPgLHd-yE_qW1NeK5KkPSUtA1wGfQcnROywrcfa7cH+Dtwfezw@mail.gmail.com>
References: <CAPgLHd-yE_qW1NeK5KkPSUtA1wGfQcnROywrcfa7cH+Dtwfezw@mail.gmail.com>
Message-ID: <20130821080820.GE7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Wei Yongjun <weiyj.lk@gmail.com> [130716 05:17]:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.

Thanks applying into omap-for-v3.12/fixes-non-critical.

Tony
 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  arch/arm/plat-omap/dma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 4d463ca..0376606 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -2083,6 +2083,7 @@ static int omap_system_dma_probe(struct platform_device *pdev)
>  		dma_irq = platform_get_irq_byname(pdev, irq_name);
>  		if (dma_irq < 0) {
>  			dev_err(&pdev->dev, "failed: request IRQ %d", dma_irq);
> +			ret = dma_irq;
>  			goto exit_dma_lch_fail;
>  		}
>  		ret = setup_irq(dma_irq, &omap24xx_dma_irq);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
