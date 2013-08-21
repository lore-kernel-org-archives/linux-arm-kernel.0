From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Aug 2013 00:19:01 -0700
Subject: [PATCH] ARM: OMAP: fix return value check in
 omap_device_build_from_dt()
In-Reply-To: <CAPgLHd_E8wht4q5c9=TjUTwXxysjbbX+HnZyYe2KJU=w79cK4w@mail.gmail.com>
References: <CAPgLHd_E8wht4q5c9=TjUTwXxysjbbX+HnZyYe2KJU=w79cK4w@mail.gmail.com>
Message-ID: <20130821071901.GR7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

* Wei Yongjun <weiyj.lk@gmail.com> [130704 06:48]:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function omap_device_alloc() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check
> should be replaced with IS_ERR().

Looks like this is still pending, care to take this?

Tony
 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  arch/arm/mach-omap2/omap_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
> index 5cc9287..28e70c0 100644
> --- a/arch/arm/mach-omap2/omap_device.c
> +++ b/arch/arm/mach-omap2/omap_device.c
> @@ -155,7 +155,7 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
>  	}
>  
>  	od = omap_device_alloc(pdev, hwmods, oh_cnt);
> -	if (!od) {
> +	if (IS_ERR(od)) {
>  		dev_err(&pdev->dev, "Cannot allocate omap_device for :%s\n",
>  			oh_name);
>  		ret = PTR_ERR(od);
> 
