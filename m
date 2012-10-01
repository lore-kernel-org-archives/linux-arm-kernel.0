From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 01 Oct 2012 16:01:11 -0700
Subject: [PATCH] ARM: OMAP: omap_device: fix return value check in
 omap_device_build_ss()
In-Reply-To: <CAPgLHd8ys7uU8wBhMF7JWZEDAddOnGo4vHPu1V_+Q3__WWK-3g@mail.gmail.com>
 (Wei Yongjun's message of "Fri, 21 Sep 2012 14:32:04 +0800")
References: <CAPgLHd8ys7uU8wBhMF7JWZEDAddOnGo4vHPu1V_+Q3__WWK-3g@mail.gmail.com>
Message-ID: <878vbper0o.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wei Yongjun <weiyj.lk@gmail.com> writes:

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> In case of error, the function omap_device_alloc() returns ERR_PTR()
> and never returns NULL pointer. The NULL test in the return value
> check should be replaced with IS_ERR().
>
> dpatch engine is used to auto generated this patch.
> (https://github.com/weiyj/dpatch)
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Acked-by: Kevin Hilman <khilman@ti.com>


> ---
>  arch/arm/plat-omap/omap_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index c490240..3f62de6 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -671,7 +671,7 @@ struct platform_device __init *omap_device_build_ss(const char *pdev_name, int p
>  		dev_set_name(&pdev->dev, "%s", pdev->name);
>  
>  	od = omap_device_alloc(pdev, ohs, oh_cnt, pm_lats, pm_lats_cnt);
> -	if (!od)
> +	if (IS_ERR(od))
>  		goto odbs_exit1;
>  
>  	ret = platform_device_add_data(pdev, pdata, pdata_len);
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
