From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 28 May 2017 22:57:57 +0800
Subject: [PATCH v3 01/10] arm: sunxi: add support for R40 SoC
In-Reply-To: <20170527102308.1988-2-icenowy@aosc.io>
References: <20170527102308.1988-1-icenowy@aosc.io>
 <20170527102308.1988-2-icenowy@aosc.io>
Message-ID: <CAGb2v66WY=qjWMcocX+pn11iT6S7-6DQE6Ei06NOB_GY69G+ZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 27, 2017 at 6:22 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> Allwinner R40 is a new SoC, with Quad Core Cortex-A7 and peripherals
> like A20.
>
> Add support for it.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v3:
> - Use V1.0 documents.
>
>  Documentation/arm/sunxi/README                  | 6 ++++++
>  Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
>  arch/arm/mach-sunxi/sunxi.c                     | 1 +
>  3 files changed, 8 insertions(+)
>
> diff --git a/Documentation/arm/sunxi/README b/Documentation/arm/sunxi/README
> index d7b1f016bd62..af56321137e8 100644
> --- a/Documentation/arm/sunxi/README
> +++ b/Documentation/arm/sunxi/README
> @@ -75,6 +75,12 @@ SunXi family
>          + Datasheet
>            http://linux-sunxi.org/File:Allwinner_V3s_Datasheet_V1.0.pdf
>
> +      - Allwinner R40 (sun8i)
> +        + Datasheet
> +          https://github.com/tinalinux/docs/blob/r40-v1.y/R40_Datasheet_V1.0.pdf
> +        + User Manual
> +          https://github.com/tinalinux/docs/blob/r40-v1.y/Allwinner_R40_User_Manual_V1.0.pdf
> +
>      * Quad ARM Cortex-A15, Quad ARM Cortex-A7 based SoCs
>        - Allwinner A80
>          + Datasheet
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
> index d2c46449b4eb..b3ffe6cf821a 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.txt
> +++ b/Documentation/devicetree/bindings/arm/sunxi.txt
> @@ -14,6 +14,7 @@ using one of the following compatible strings:
>    allwinner,sun8i-a83t
>    allwinner,sun8i-h2-plus
>    allwinner,sun8i-h3
> +  allwinner-sun8i-r40

v3s is missing from this list. Can you send a separate patch to add it?

>    allwinner,sun9i-a80
>    allwinner,sun50i-a64
>    nextthing,gr8
> diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> index f44e3acb5c90..aea616759451 100644
> --- a/arch/arm/mach-sunxi/sunxi.c
> +++ b/arch/arm/mach-sunxi/sunxi.c
> @@ -66,6 +66,7 @@ static const char * const sun8i_board_dt_compat[] = {
>         "allwinner,sun8i-h2-plus",
>         "allwinner,sun8i-h3",
>         "allwinner,sun8i-v3s",
> +       "allwinner,sun8i-r40",

Prefer to have them in alphabetical order.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

>         NULL,
>  };
>
> --
> 2.12.2
>
