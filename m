From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Dec 2015 10:40:01 +0100
Subject: [PATCH v2 3/9] ARM: hisi: enable Hi3519 soc
In-Reply-To: <1449110565-23590-1-git-send-email-xuejiancheng@huawei.com>
References: <1449110565-23590-1-git-send-email-xuejiancheng@huawei.com>
Message-ID: <8647404.sBOFNLAMdU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 December 2015 10:42:45 Jiancheng Xue wrote:
> --- a/arch/arm/mach-hisi/Kconfig
> +++ b/arch/arm/mach-hisi/Kconfig
> @@ -12,6 +12,14 @@ if ARCH_HISI
>  
>  menu "Hisilicon platform type"
>  
> +config ARCH_HI3519
> +       bool "Hisilicon Hi3519 Soc" if ARCH_MULTI_V7
> +       select HAVE_ARM_ARCH_TIMER
> +       select ARCH_HAS_RESET_CONTROLLER
> +
> +       help
> +         Support for Hisilicon Hi3519 Soc
> +
>  config ARCH_HI3xxx
>         bool "Hisilicon Hi36xx family" if ARCH_MULTI_V7
>         select CACHE_L2X0

Do those need to be separate? I would just extend the Hi36xx
to cover all Hi3xxx, if nothing in the platform code really
depends on this.

> +
> +static const char *const hi3519_compat[] __initconst = {
> +       "hisilicon,hi3519",
> +       NULL,
> +};
> +
> +DT_MACHINE_START(HI3519_DT, "Hisilicon Hi3519 (Flattened Device Tree)")
> +       .dt_compat      = hi3519_compat,
> +MACHINE_END

Also drop the "(Flattened Device Tree)" part of the name, we don't
support any other kind anyway.

	Arnd
