From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 6 Jul 2016 15:04:25 +0200
Subject: [PATCH] oxnas: select reset controller framework
In-Reply-To: <20160706124826.1563413-1-arnd@arndb.de>
References: <20160706124826.1563413-1-arnd@arndb.de>
Message-ID: <CAA3gFWsg7E3tczzroQfNLayiUQhdoWxa-rYJys83Z5saJ6kMaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-07-06 14:48 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
> For unknown reasons, we have to enable three symbols for a platform
> to use a reset controller driver, otherwise we get a Kconfig
> warning:
>
> warning: (MACH_OX810SE) selects RESET_OXNAS which has unmet direct dependencies (RESET_CONTROLLER)
>
> This selects the other two symbols for oxnas.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-oxnas/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/mach-oxnas/Kconfig b/arch/arm/mach-oxnas/Kconfig
> index 2dde0acf01fd..b6a36d660e6f 100644
> --- a/arch/arm/mach-oxnas/Kconfig
> +++ b/arch/arm/mach-oxnas/Kconfig
> @@ -11,11 +11,13 @@ if ARCH_OXNAS
>
>  config MACH_OX810SE
>         bool "Support OX810SE Based Products"
> +       select ARCH_HAS_RESET_CONTROLLER

This is strange since this is selected by CONFIG_ARCH_OXNAS !

>         select ARM_TIMER_SP804
>         select COMMON_CLK_OXNAS
>         select CPU_ARM926T
>         select MFD_SYSCON
>         select PINCTRL_OXNAS
> +       select RESET_CONTROLLER

Same here, it should be selected by ARCH_HAS_RESET_CONTROLLER

>         select RESET_OXNAS
>         select VERSATILE_FPGA_IRQ
>         help
> --
> 2.9.0
>

If it makes the warning disappear,
Acked-by: Neil Armstrong <narmstrong@baylibre.com>

In this current form it will fail to apply of arm-soc for-next branch
since Olof applied my TIMER_SP804 replacement.

Thanks,
Neil
