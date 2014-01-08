From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 8 Jan 2014 13:56:38 +0530
Subject: [PATCH] Fix select-induced Kconfig warning for ZBOOT_ROM
In-Reply-To: <3792319.Wf518ByjFs@wuerfel>
References: <E1Vyl3Q-0005Lt-Lo@rmk-PC.arm.linux.org.uk>
 <CAOh2x==c+O9SwaeCOOSDkFUgSYnY=1Y-7C=Ti_5ceiyUUiQw1Q@mail.gmail.com>
 <3792319.Wf518ByjFs@wuerfel>
Message-ID: <CAKohpo=2qKoffu7TuLHTLtX4vxX3Vs_oPV9DUHOkXiwN_fWCPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 January 2014 13:50, Arnd Bergmann <arnd@arndb.de> wrote:
> It's a weird dependency. You need this hunk:
>
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -3,7 +3,7 @@ config ARCH_MXC
>         select ARCH_REQUIRE_GPIOLIB
>         select ARM_CPU_SUSPEND if PM
>         select ARM_PATCH_PHYS_VIRT
> -       select AUTO_ZRELADDR if !ZBOOT_ROM
> +       select AUTO_ZRELADDR
>         select CLKSRC_MMIO
>         select COMMON_CLK
>         select GENERIC_ALLOCATOR

Exynos already has this:

arch/arm/mach-exynos/Kconfig
config SOC_EXYNOS5440
    ...
    select AUTO_ZRELADDR
