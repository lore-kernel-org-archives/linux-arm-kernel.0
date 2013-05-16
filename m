From: tony@atomide.com (Tony Lindgren)
Date: Thu, 16 May 2013 10:48:47 -0700
Subject: [PATCH] ARM: OMAP: fix error return code in
 omap1_system_dma_init()
In-Reply-To: <CAPgLHd8iPa4efHsYsCmGE-j-GzZw7DtWdSaQqpEuF60-BRtmbg@mail.gmail.com>
References: <CAPgLHd8iPa4efHsYsCmGE-j-GzZw7DtWdSaQqpEuF60-BRtmbg@mail.gmail.com>
Message-ID: <20130516174847.GD5600@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Wei Yongjun <weiyj.lk@gmail.com> [130512 21:30]:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fix to return -ENOMEM in the d->chan alloc error handling
> case instead of 0, as done elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Thanks, applying into omap-for-v3.10/fixes.

Regards,

Tony

> ---
>  arch/arm/mach-omap1/dma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
> index 68ab858..a94b3a7 100644
> --- a/arch/arm/mach-omap1/dma.c
> +++ b/arch/arm/mach-omap1/dma.c
> @@ -345,6 +345,7 @@ static int __init omap1_system_dma_init(void)
>  		dev_err(&pdev->dev,
>  			"%s: Memory allocation failed for d->chan!\n",
>  			__func__);
> +		ret = -ENOMEM;
>  		goto exit_release_d;
>  	}
>  
> 
