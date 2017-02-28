From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 28 Feb 2017 18:19:15 +0000
Subject: [linux-sunxi] [PATCH 2/5] arm64: only select PINCTRL_SUNXI for
 Allwinner platforms
In-Reply-To: <20170228172444.59655-2-icenowy@aosc.xyz>
References: <20170228172444.59655-1-icenowy@aosc.xyz>
 <20170228172444.59655-2-icenowy@aosc.xyz>
Message-ID: <c878ba53-a33a-e042-2d65-11f86a47b844@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 28/02/17 17:24, Icenowy Zheng wrote:
> As the pinctrl driver selecting is refactored in Kconfig file of
> pinctrl-sunxi, now we can select only PINCTRL_SUNXI for Allwinner
> platform, and the default value of several pinctrl drivers useful on
> ARM64 Allwinner SoCs will become Y.
> 
> Drop the select of per-SoC pinctrl choices, but select PINCTRL_SUNXI.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
>  arch/arm64/Kconfig.platforms | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 129cc5ae4091..f6db2a938b1e 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -4,7 +4,7 @@ config ARCH_SUNXI
>  	bool "Allwinner sunxi 64-bit SoC Family"
>  	select GENERIC_IRQ_CHIP
>  	select PINCTRL
> -	select PINCTRL_SUN50I_A64
> +	select PINCTRL_SUNXI

Why do we need to add this generic PINCTRL_SUNXI here? This is selected
already by the SoC specific PINCTRL symbols (see your previous patch).

Cheers,
Andre.

>  	help
>  	  This enables support for Allwinner sunxi based SoCs like the A64.
>  
> 
