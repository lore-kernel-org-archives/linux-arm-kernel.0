From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 8 Aug 2017 23:44:38 +0800
Subject: [PATCH] ARM: sunxi: add an help section to the Kconfig Sun8i SoC
 selection
In-Reply-To: <20170808153636.26846-1-clabbe.montjoie@gmail.com>
References: <20170808153636.26846-1-clabbe.montjoie@gmail.com>
Message-ID: <CAGb2v65b6FVN6LrqSAJxDaQJ9_mB6xP1aH0Tnqm2f657AfNHpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 8, 2017 at 11:36 PM, Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
> Since sun8i regroup lots of SoCs, it is helpful to list them in the help
> section of Kconfig.
>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm/mach-sunxi/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index 58153cdf025b..2ffcccda2688 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -42,6 +42,9 @@ config MACH_SUN8I
>         default ARCH_SUNXI
>         select ARM_GIC
>         select MFD_SUN6I_PRCM
> +       help
> +         Select this option if you have one of the following SoC:
> +         A23 A33 A83T H2+ H3 R16 V3S

IIRC Maxime was against having chip names in here, as we would end up
updating this every time a new chip gets added.

Instead, what about using Allwinner's explanation? I.e. sun8i is a
chip with only Cortex-A7's, and sun9i is a chip with Cortex-A15's.
And just tell the user to say yes if they are not sure.

ChenYu

>
>  config MACH_SUN9I
>         bool "Allwinner (sun9i) SoCs support"
> --
> 2.13.0
>
