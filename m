From: vitalywool@gmail.com (Vitaly Wool)
Date: Thu, 17 Mar 2011 22:32:43 +0100
Subject: [PATCH 1/9] lpc2k: Core support
In-Reply-To: <1300377264-10843-2-git-send-email-ithamar.adema@team-embedded.nl>
References: <1300377264-10843-1-git-send-email-ithamar.adema@team-embedded.nl>
	<1300377264-10843-2-git-send-email-ithamar.adema@team-embedded.nl>
Message-ID: <AANLkTik1fJKs81fRW+a6N24tFf-wmG+c4p68kVOAxqeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 17, 2011 at 4:54 PM, Ithamar R. Adema
<ithamar.adema@team-embedded.nl> wrote:
> Core files (including IRQ handling) for NXP LPC2K architecture.

<snip>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e34bf02..331540d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -490,6 +490,18 @@ config ARCH_LOKI
> ? ? ? ?help
> ? ? ? ? ?Support for the Marvell Loki (88RC8480) SoC.
>
> +config ARCH_LPC2K
> + ? ? ? bool "NXP LPC2K Family"
> + ? ? ? depends on !MMU
> + ? ? ? select CPU_ARM7TDMI
> + ? ? ? select ARM_VIC
> + ? ? ? select GENERIC_TIME
> + ? ? ? select GENERIC_CLOCKEVENTS
> + ? ? ? help
> + ? ? ? ? Support for NXP LPC2K family of SoCs. These SoCs are based on
> + ? ? ? ? an ARM7TDMI-S core, and have optional on-chip flash and SRAM,
> + ? ? ? ? also UART, I2C, SPI, SSP, CAN, RTC, and other peripherals.
> +
> ?config ARCH_LPC32XX
> ? ? ? ?bool "NXP LPC32XX"
> ? ? ? ?select CPU_ARM926T
> @@ -928,6 +940,8 @@ source "arch/arm/mach-ks8695/Kconfig"
>
> ?source "arch/arm/mach-loki/Kconfig"
>
> +source "arch/arm/mach-lpc2k/Kconfig"
> +

is there any good reason why you don't add your stuff to lpc32xx?

~Vitaly
