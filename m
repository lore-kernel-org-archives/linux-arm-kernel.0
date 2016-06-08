From: liviu.dudau@arm.com (Liviu Dudau)
Date: Wed, 8 Jun 2016 11:49:19 +0100
Subject: [PATCH] of: reserved_mem: restore old behavior when no region is
 defined
In-Reply-To: <1465368713-17866-1-git-send-email-m.szyprowski@samsung.com>
References: <20160607143425.GE1165@e106497-lin.cambridge.arm.com>
 <1465368713-17866-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20160608104919.GI1165@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 08:51:53AM +0200, Marek Szyprowski wrote:
> Change return value back to -ENODEV when no region is defined for given
> device. This restores old behavior of this function, as some drivers rely
> on such error code.
> 
> Reported-by: Liviu Dudau <liviu.dudau@arm.com>
> Fixes: 59ce4039727ef40 ("of: reserved_mem: add support for using more than
>        one region for given device")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Reviewed-by: Liviu Dudau <Liviu.Dudau@arm.com>

> ---
>  drivers/of/of_reserved_mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 3cf129f..06af99f 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -334,7 +334,7 @@ int of_reserved_mem_device_init_by_idx(struct device *dev,
>  
>  	target = of_parse_phandle(np, "memory-region", idx);
>  	if (!target)
> -		return -EINVAL;
> +		return -ENODEV;
>  
>  	rmem = __find_rmem(target);
>  	of_node_put(target);
> -- 
> 1.9.2
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
