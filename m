From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 6 May 2015 12:04:46 +0200
Subject: [PATCH 1/6] ARM: sunxi: Introduce Allwinner H3 support
In-Reply-To: <1430904693-1404-2-git-send-email-jenskuske@gmail.com>
References: <1430904693-1404-1-git-send-email-jenskuske@gmail.com>
 <1430904693-1404-2-git-send-email-jenskuske@gmail.com>
Message-ID: <20150506100446.GA11057@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 06, 2015 at 11:31:28AM +0200, Jens Kuske wrote:
> The Allwinner H3 is a quad-core Cortex-A7-based SoC. It is very similar
> to other sun8i family SoCs like the A23.
> 
> Signed-off-by: Jens Kuske <jenskuske@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
>  arch/arm/mach-sunxi/Kconfig                     | 2 +-
>  arch/arm/mach-sunxi/sunxi.c                     | 3 ++-
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
> index 42941fd..3cb4b94 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.txt
> +++ b/Documentation/devicetree/bindings/arm/sunxi.txt
> @@ -9,4 +9,5 @@ using one of the following compatible strings:
>    allwinner,sun6i-a31
>    allwinner,sun7i-a20
>    allwinner,sun8i-a23
> +  allwinner,sun8i-h3
>    allwinner,sun9i-a80
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index 81502b9..47ac5b4 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -35,7 +35,7 @@ config MACH_SUN7I
>  	select SUN5I_HSTIMER
>  
>  config MACH_SUN8I
> -	bool "Allwinner A23 (sun8i) SoCs support"
> +	bool "Allwinner A23 / H3 (sun8i) SoCs support"

I'd prefer that we have something similar to sun9i, just mentionning
the family here, instead of an ever-growing list of SoCs.

This used to be easy to maintain, with the new naming scheme, we
already have at least 4 SoCs part of sun8i.

>  	default ARCH_SUNXI
>  	select ARM_GIC
>  	select MFD_SUN6I_PRCM
> diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> index 1bc811a..bc63748 100644
> --- a/arch/arm/mach-sunxi/sunxi.c
> +++ b/arch/arm/mach-sunxi/sunxi.c
> @@ -67,10 +67,11 @@ MACHINE_END
>  
>  static const char * const sun8i_board_dt_compat[] = {
>  	"allwinner,sun8i-a23",
> +	"allwinner,sun8i-h3",
>  	NULL,
>  };
>  
> -DT_MACHINE_START(SUN8I_DT, "Allwinner sun8i (A23) Family")
> +DT_MACHINE_START(SUN8I_DT, "Allwinner sun8i (A23/H3) Family")

Same comment here.

Could you also update Documentation/arm/sunxi/README with these infos
(and ideally, updating it with the new SoCs we've heard about) ?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150506/f42da871/attachment.sig>
