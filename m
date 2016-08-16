From: jon.mason@broadcom.com (Jon Mason)
Date: Tue, 16 Aug 2016 13:52:52 -0400
Subject: [PATCH soc/next?] ARM: BCM53573: Initial support for Broadcom
 BCM53573 SoCs
In-Reply-To: <1470990396-23701-1-git-send-email-zajec5@gmail.com>
References: <1470990396-23701-1-git-send-email-zajec5@gmail.com>
Message-ID: <CAC3K-4qMynoE3kL+C3FJenD1WATpET29UAroVxLndZj1Hk1NZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 12, 2016 at 4:26 AM, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
> From: Rafa? Mi?ecki <rafal@milecki.pl>
>
> BCM53573 series is a new family with embedded wireless. By marketing
> people it's sometimes called Northstar but it uses different CPU and has
> different architecture so we need a new symbol for it.
> Fortunately it shares some peripherals with other iProc based SoCs so we
> will be able to reuse some drivers/bindings.
>
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
> ---
> Resending as linux-arm-kernel ML rejected my e-mail due to the wrong address:
> bcm-kernel-feedback-list at broadcom.com>
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
> index 5832dba..9a6c3ae 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -76,6 +76,21 @@ config ARCH_BCM_5301X
>           different SoC or with the older BCM47XX and BCM53XX based
>           network SoC using a MIPS CPU, they are supported by arch/mips/bcm47xx
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

This will put it under the "iProc" section.  I think we would want it
under the "Other Architectures" section.

Thanks,
Jon

>  comment "KONA architected SoCs"
>
>  config ARCH_BCM_MOBILE
> --
> 1.8.4.5
>
