From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 27 Jan 2016 22:48:55 +0900
Subject: [PATCH 14/15] Revert "bus: uniphier: allow only built-in driver"
In-Reply-To: <1453868872-26300-15-git-send-email-wangkefeng.wang@huawei.com>
References: <1453868872-26300-1-git-send-email-wangkefeng.wang@huawei.com>
 <1453868872-26300-15-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <CAK7LNAR=E5kYzsO9=YDeAVzp9cLWd9C8ANeVGJOvM=BSM4aTjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-01-27 13:27 GMT+09:00 Kefeng Wang <wangkefeng.wang@huawei.com>:
> This reverts commit 326ea45aa827da6686c78b5907f9839f91ef5782.
>
> After covering to use helper of_platform_default_populate() to
> populate the default bus, no error in build uniphier driver as
> a module.

This statement is weird.
There is no error for building this driver as a module
at the point of v4.5-rc1.

The of_platform_default_populate() conversion (11/15) is unrelated
to fixing the build error.

BTW, I had already posted an equivalent patch a few days before:

https://patchwork.kernel.org/patch/8096991/




> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/bus/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index 129d47b..9a92c07 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -132,7 +132,7 @@ config SUNXI_RSB
>           and AC100/AC200 ICs.
>
>  config UNIPHIER_SYSTEM_BUS
> -       bool "UniPhier System Bus driver"
> +       tristate "UniPhier System Bus driver"
>         depends on ARCH_UNIPHIER && OF
>         default y
>         help
> --
> 2.6.0.GIT
>


-- 
Best Regards
Masahiro Yamada
