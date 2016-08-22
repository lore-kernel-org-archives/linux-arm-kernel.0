From: jon.mason@broadcom.com (Jon Mason)
Date: Mon, 22 Aug 2016 17:24:42 -0400
Subject: [PATCH V2 soc/next?] ARM: BCM53573: Initial support for Broadcom
 BCM53573 SoCs
In-Reply-To: <20160821170138.21259-1-zajec5@gmail.com>
References: <1470990396-23701-1-git-send-email-zajec5@gmail.com>
 <20160821170138.21259-1-zajec5@gmail.com>
Message-ID: <CAC3K-4pY8ZEm6BvDHqU1KOWcGpZGajwP2re74HrOnNEYJ9JE4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 21, 2016 at 1:01 PM, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
> From: Rafa? Mi?ecki <rafal@milecki.pl>
>
> BCM53573 series is a new family with embedded wireless. By marketing
> people it's sometimes called Northstar but it uses different CPU and has
> different architecture so we need a new symbol for it.
> Fortunately it shares some peripherals with other iProc based SoCs so we
> will be able to reuse some drivers/bindings.
>
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>

Looks good to me!

Acked-by: Jon Mason <jon.mason@broadcom.com>


> ---
> V2: Put new symbol under "Other Architectures"
> ---
>  MAINTAINERS               |  7 +++++++
>  arch/arm/mach-bcm/Kconfig | 15 +++++++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7304d2e..9e2db2e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2517,6 +2517,13 @@ F:       arch/arm/mach-bcm/bcm_5301x.c
>  F:     arch/arm/boot/dts/bcm5301x.dtsi
>  F:     arch/arm/boot/dts/bcm470*
>
> +BROADCOM BCM53573 ARM ARCHITECTURE
> +M:     Rafa? Mi?ecki <rafal@milecki.pl>
> +L:     linux-arm-kernel at lists.infradead.org
> +S:     Maintained
> +F:     arch/arm/boot/dts/bcm53573*
> +F:     arch/arm/boot/dts/bcm47189*
> +
>  BROADCOM BCM63XX ARM ARCHITECTURE
>  M:     Florian Fainelli <f.fainelli@gmail.com>
>  L:     linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index 5832dba..6dfdc82 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -157,6 +157,21 @@ config ARCH_BCM2835
>           This enables support for the Broadcom BCM2835 and BCM2836 SoCs.
>           This SoC is used in the Raspberry Pi and Roku 2 devices.
>
> +config ARCH_BCM_53573
> +       bool "Broadcom BCM53573 SoC series support"
> +       depends on ARCH_MULTI_V7
> +       select ARCH_BCM_IPROC
> +       select HAVE_ARM_ARCH_TIMER
> +
> +       help
> +         BCM53573 series is set of SoCs using ARM Cortex-A7 CPUs with wireless
> +         embedded in the chipset.
> +         This SoC line is mostly used in home routers and is some cheaper
> +         alternative for Northstar family.
> +
> +         The base chip is BCM53573 and there are some packaging modifications
> +         like BCM47189 and BCM47452.
> +
>  config ARCH_BCM_63XX
>         bool "Broadcom BCM63xx DSL SoC"
>         depends on ARCH_MULTI_V7
> --
> 2.9.3
>
