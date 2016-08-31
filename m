From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 31 Aug 2016 16:25:27 +0800
Subject: [PATCH 4/6] ARM: sunxi: Support the Nextthing GR8
In-Reply-To: <20160831081817.5191-5-maxime.ripard@free-electrons.com>
References: <20160831081817.5191-1-maxime.ripard@free-electrons.com>
 <20160831081817.5191-5-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66CDdSJMN4STHug1bGU2fnRK=Y24kwKS_8EtD6PZg3T-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2016 at 4:18 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The GR8 is an SoC made by Nextthing Co, loosely based on the sun5i family.
>
> It has a number of new controllers compared to the A10s and A13 (SPDIF, I2S),
> but some controllers missing too (Ethernet, less I2C, less UARTs).
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
>  MAINTAINERS                                     | 1 +
>  arch/arm/mach-sunxi/sunxi.c                     | 1 +

Please update Documentation/arm/sunxi/README as well. I don't suppose
there's a datasheet available?

ChenYu

>  3 files changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
> index 7e79fcc36b0d..3975d0a0e4c2 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.txt
> +++ b/Documentation/devicetree/bindings/arm/sunxi.txt
> @@ -14,3 +14,4 @@ using one of the following compatible strings:
>    allwinner,sun8i-a83t
>    allwinner,sun8i-h3
>    allwinner,sun9i-a80
> +  nextthing,gr8
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 20bb1d00098c..c6a9e6fda1d0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -982,6 +982,7 @@ M:  Chen-Yu Tsai <wens@csie.org>
>  L:     linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  S:     Maintained
>  N:     sun[x456789]i
> +F:     arch/arm/boot/dts/gr8*
>
>  ARM/Allwinner SoC Clock Support
>  M:     Emilio L?pez <emilio@elopez.com.ar>
> diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> index 95dca8c2c9ed..2e2bde271205 100644
> --- a/arch/arm/mach-sunxi/sunxi.c
> +++ b/arch/arm/mach-sunxi/sunxi.c
> @@ -22,6 +22,7 @@ static const char * const sunxi_board_dt_compat[] = {
>         "allwinner,sun5i-a10s",
>         "allwinner,sun5i-a13",
>         "allwinner,sun5i-r8",
> +       "nextthing,gr8",
>         NULL,
>  };
>
> --
> 2.9.2
>
