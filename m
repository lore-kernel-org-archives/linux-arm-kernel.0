From: olof@lixom.net (Olof Johansson)
Date: Mon, 28 Apr 2014 10:02:40 -0700
Subject: [linux-sunxi] [PATCH 1/2] ARM: sunxi: Split the various SoCs
 support in Kconfig
In-Reply-To: <1398529014-1152-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1398529014-1152-1-git-send-email-maxime.ripard@free-electrons.com>
 <1398529014-1152-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAOesGMiYRwmBnynw8dg6hBWens4_ncbvE2wN5rnJoW5DV_YB5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Apr 26, 2014 at 9:16 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> This will allow to better isolate various options, and reduce the overall
> kernel size if we're interested in only one of the SoCs.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/mach-sunxi/Kconfig | 35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index b57d7d53b9d3..23575010ff49 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -1,14 +1,37 @@
>  config ARCH_SUNXI
> -       bool "Allwinner A1X SOCs" if ARCH_MULTI_V7
> -       select ARCH_HAS_RESET_CONTROLLER
> +       bool "Allwinner SoCs" if ARCH_MULTI_V7
>         select ARCH_REQUIRE_GPIOLIB
> -       select ARM_GIC
> -       select ARM_PSCI
>         select CLKSRC_MMIO
>         select GENERIC_IRQ_CHIP
> -       select HAVE_ARM_ARCH_TIMER
>         select PINCTRL
>         select PINCTRL_SUNXI
> -       select RESET_CONTROLLER
>         select SUN4I_TIMER
> +
> +if ARCH_SUNXI
> +
> +menu "Allwinner SoCs variants"
> +
> +config MACH_SUN4I
> +       bool "Allwinner A10 (sun4i) SoCs support"

If you add "default MACH_SUNXI" then you don't have to churn the
defconfigs, but it'll still make it possible for people to turn it
off.


-Olof
