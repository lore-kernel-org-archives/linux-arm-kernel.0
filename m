From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Wed, 27 Jan 2016 23:10:18 +0100
Subject: [PATCH 15/15] Revert "of/platform: export
 of_default_bus_match_table"
In-Reply-To: <1453868872-26300-16-git-send-email-wangkefeng.wang@huawei.com>
References: <1453868872-26300-1-git-send-email-wangkefeng.wang@huawei.com>
 <1453868872-26300-16-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <56A9404A.7050900@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/2016 05:27 AM, Kefeng Wang wrote:
> This reverts commit b80443c2211c7daaabd20fbbe9e7beb3fa3408e0.
> 
> After covering to use helper of_platform_default_populate() to populate
> the default bus, no need to export of_default_bus_match_table anymore.
> 
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com> 
> Cc: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/of/platform.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 8d103e4..af98343 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -31,7 +31,6 @@ const struct of_device_id of_default_bus_match_table[] = {
>  #endif /* CONFIG_ARM_AMBA */
>  	{} /* Empty terminated list */
>  };
> -EXPORT_SYMBOL(of_default_bus_match_table);
>  
>  static int of_dev_node_match(struct device *dev, void *data)
>  {
> 

Is of_default_bus_match_table still accessed or can it be made static
and the header file entry removed?

Thanks for cleaning up all the drivers, I just needed it for one driver.

Hauke
