From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 27 Jan 2016 22:40:19 +0900
Subject: [PATCH 11/15] bus: uniphier-system-bus: use
 of_platform_default_populate() to populate default bus
In-Reply-To: <1453868872-26300-12-git-send-email-wangkefeng.wang@huawei.com>
References: <1453868872-26300-1-git-send-email-wangkefeng.wang@huawei.com>
 <1453868872-26300-12-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <CAK7LNAQWd3fchwtyE8hAC=ZZ+mk4gyqReJ9SSxvaY0u1SoSkvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kefeng,

2016-01-27 13:27 GMT+09:00 Kefeng Wang <wangkefeng.wang@huawei.com>:
> Use helper of_platform_default_populate() in linux/of_platform
> when possible, instead of calling of_platform_populate() with
> the default match table.
>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/bus/uniphier-system-bus.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/bus/uniphier-system-bus.c b/drivers/bus/uniphier-system-bus.c
> index 834a2ae..f50bd6d 100644
> --- a/drivers/bus/uniphier-system-bus.c
> +++ b/drivers/bus/uniphier-system-bus.c
> @@ -257,8 +257,7 @@ static int uniphier_system_bus_probe(struct platform_device *pdev)
>         uniphier_system_bus_set_reg(priv);
>
>         /* Now, the bus is configured.  Populate platform_devices below it */
> -       return of_platform_populate(dev->of_node, of_default_bus_match_table,
> -                                   NULL, dev);
> +       return of_platform_default_populate(dev->of_node, NULL, dev);
>  }
>
>  static const struct of_device_id uniphier_system_bus_match[] = {


I did not notice the existence of of_platform_default_populate().

If I had used this function, commit b80443cc22 would have not been
needed in the first place...

Thanks for cleaning this!

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


-- 
Best Regards
Masahiro Yamada
