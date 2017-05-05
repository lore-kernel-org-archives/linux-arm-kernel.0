From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 5 May 2017 11:35:53 +0800
Subject: [linux-sunxi] [PATCH v2 01/10] arm: sunxi: add support for R40 SoC
In-Reply-To: <20170504135006.16483-2-icenowy@aosc.io>
References: <20170504135006.16483-1-icenowy@aosc.io>
 <20170504135006.16483-2-icenowy@aosc.io>
Message-ID: <CAGb2v67qVkQhsRoEb_EyX09KrgN7eQ756wSEVbnzuMf_tHRuhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 4, 2017 at 9:49 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> From: Icenowy Zheng <icenowy@aosc.xyz>

Do you want to update your author email address?

>
> Allwinner R40 is a new SoC, with Quad Core Cortex-A7 and peripherals
> like A20.
>
> Add support for it.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Same here.

For the subject, "ARM" should be uppercase.

> ---
>  Documentation/arm/sunxi/README                  | 4 ++++
>  Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
>  arch/arm/mach-sunxi/sunxi.c                     | 1 +
>  3 files changed, 6 insertions(+)
>
> diff --git a/Documentation/arm/sunxi/README b/Documentation/arm/sunxi/README
> index d7b1f016bd62..25c814adcd47 100644
> --- a/Documentation/arm/sunxi/README
> +++ b/Documentation/arm/sunxi/README
> @@ -75,6 +75,10 @@ SunXi family
>          + Datasheet
>            http://linux-sunxi.org/File:Allwinner_V3s_Datasheet_V1.0.pdf
>
> +      - Allwinner R40 (sun8i)
> +        + Datasheet Draft
> +          http://linux-sunxi.org/File:Allwinner_R40_Datasheet_V0.1.pdf

We have the official 1.0 version, don't we? Also please keep the README
entries in alphabetical order


Regards
ChenYu

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
>         NULL,
>  };
>
> --
> 2.12.2
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
