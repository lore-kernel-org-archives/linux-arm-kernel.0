From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 20 Jun 2016 09:54:02 +0900
Subject: [PATCH -next] PM / devfreq: event: Fix return value check in
 exynos_nocp_parse_dt()
In-Reply-To: <1466187003-19823-1-git-send-email-weiyj_lk@163.com>
References: <CGME20160617181052epcas1p34d888fccc7f58186cd2b0e2b1fed3e39@epcas1p3.samsung.com>
 <1466187003-19823-1-git-send-email-weiyj_lk@163.com>
Message-ID: <57673EAA.2020506@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wei,

On 2016? 06? 18? 03:10, weiyj_lk at 163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function platform_get_resource() returns NULL
> pointer not ERR_PTR(). Remove unneeded error handling on the result
> of a call to platform_get_resource() since the value is passed to
> devm_ioremap_resource().

This same patch was already merged to devfreq git[1].

[1] https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/commit/?h=fixes&id=482c27865b9784831dad45b31c2b0a5c42376802

Thanks,
Chanwoo Choi

> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/devfreq/event/exynos-nocp.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/devfreq/event/exynos-nocp.c b/drivers/devfreq/event/exynos-nocp.c
> index 6b6a5f3..a584140 100644
> --- a/drivers/devfreq/event/exynos-nocp.c
> +++ b/drivers/devfreq/event/exynos-nocp.c
> @@ -220,9 +220,6 @@ static int exynos_nocp_parse_dt(struct platform_device *pdev,
>  
>  	/* Maps the memory mapped IO to control nocp register */
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (IS_ERR(res))
> -		return PTR_ERR(res);
> -
>  	base = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
