From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 12 Feb 2015 13:57:09 -0800
Subject: [PATCH 03/11] ARM: BCM: put back ARCH_MULTI_V7 dependency for
 mobile
In-Reply-To: <1423770163-583064-4-git-send-email-arnd@arndb.de>
References: <1423770163-583064-1-git-send-email-arnd@arndb.de>
 <1423770163-583064-4-git-send-email-arnd@arndb.de>
Message-ID: <CAGVrzcbmshyZooXTvy1Tono8wjPR=DizNSSA2i8oN6_GRSDP5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-02-12 11:42 GMT-08:00 Arnd Bergmann <arnd@arndb.de>:
> A recent cleanup rearranged the Kconfig file for mach-bcm and
> accidentally dropped the dependency on ARCH_MULTI_V7, which
> makes it possible to now build the two mobile SoC platforms
> on an ARMv6-only kernel, resulting in a log of Kconfig
> warnings like
>
> warning: ARCH_BCM_MOBILE selects ARM_ERRATA_775420 which has unmet direct dependencies (CPU_V7)
>
> and which of course cannot work on any machine.
>
> This puts back the dependencies as before.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 64e74aa788f99 ("ARM: mach-bcm: ARCH_BCM_MOBILE: remove one level of menu from Kconfig")
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Christian Daudt <bcm@fixthebug.org>
> Cc: Scott Branden <sbranden@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  arch/arm/mach-bcm/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index aaeec78c3ec4..8b11f44bb36e 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -68,7 +68,7 @@ config ARCH_BCM_MOBILE
>           This enables support for systems based on Broadcom mobile SoCs.
>
>  config ARCH_BCM_281XX
> -       bool "Broadcom BCM281XX SoC family"
> +       bool "Broadcom BCM281XX SoC family" if ARCH_MULTI_V7
>         select ARCH_BCM_MOBILE
>         select HAVE_SMP
>         help
> @@ -77,7 +77,7 @@ config ARCH_BCM_281XX
>           variants.
>
>  config ARCH_BCM_21664
> -       bool "Broadcom BCM21664 SoC family"
> +       bool "Broadcom BCM21664 SoC family" if ARCH_MULTI_V7
>         select ARCH_BCM_MOBILE
>         select HAVE_SMP
>         help
> --
> 2.1.0.rc2
>



-- 
Florian
