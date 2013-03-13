From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 13 Mar 2013 12:12:13 +0100
Subject: ARM: at-91: ARCH_AT91SAM9X5 went missing
In-Reply-To: <1363171688.3137.196.camel@x61.thuisdomein>
References: <1363171688.3137.196.camel@x61.thuisdomein>
Message-ID: <51405F0D.40102@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2013 11:48 AM, Paul Bolle :
> 0) Commit 1e3ce2b8545390a2aee8dbfcd49ca4161b636000
> ("AR[M]: at91: introduce SOC_AT91xxx define to allow to compile SoC core
> support") dropped the Kconfig symbol ARCH_AT91SAM9X5. It seems it missed
> something like this:
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index 6071f4c..2db5370 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -131,6 +131,10 @@ config ARCH_AT91SAM9G45
>         bool "AT91SAM9G45"
>         select SOC_AT91SAM9G45
>  
> +config ARCH_AT91SAM9X5
> +       bool "AT91SAM9X5"
> +       select SOC_AT91SAM9X5
> +
>  config ARCH_AT91X40
>         bool "AT91x40"
>         depends on !MMU
> 
> 1) But before I submit something along those lines: ARCH_AT91* variants
> are still used quite a bit around the tree (both as Kconfig symbols and
> as Kconfig macros). How are the current SOC_AT91* symbols wired back to
> the old ARCH_AT91* symbols? Or are those old symbols and macros _only_
> needed for backwards compatibility?

These ARCH_AT91xxx variables are not used anymore for pure Device Tree
SoCs (I mean: at91sam9x5, at91sam9n12, sama5d3 families). They are used
for non-DT SoCs and for chips that support both legacy board files and DT.
The old ARCH_AT91xxx symbols are selecting the corresponding SOC_AT91xxx
symbol.

ARCH_AT91xxx in Kconfig that are specific to a particular SoC are going
to disappear as we tend to allow the compilation of a particular driver
for a wider range of configurations.

Hope that it helps. Best regards,
-- 
Nicolas Ferre
