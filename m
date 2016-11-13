From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 13 Nov 2016 19:59:15 +0100
Subject: [linux-sunxi] [PATCH 1/3] ARM: sunxi: add support for H2+ SoC
In-Reply-To: <20161111164654.15273-1-icenowy@aosc.xyz>
References: <20161111164654.15273-1-icenowy@aosc.xyz>
Message-ID: <8b57a230-d113-0a8d-e732-4115d0165910@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11-11-16 17:46, Icenowy Zheng wrote:
> Allwinner H2+ is a quad-core Cortex-A7 SoC.
>
> It is very like H3, that they share the same SoC ID (0x1680), and H3
> memory maps as well as drivers works well on the SoC.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

I agree that given that the chip-id is 1680 for both
this does seem to be the same die as the H3, and given
that we do not have any datasheets, I agree that just
treating the H2+ as a H3 is best for now, we can always
change h2.dtsi to actually differentiate things later.

This entire series LGTM and is:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  Documentation/arm/sunxi/README                  | 4 ++++
>  Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
>  arch/arm/mach-sunxi/sunxi.c                     | 1 +
>  3 files changed, 6 insertions(+)
>
> diff --git a/Documentation/arm/sunxi/README b/Documentation/arm/sunxi/README
> index cd02433..1fe4d99c 100644
> --- a/Documentation/arm/sunxi/README
> +++ b/Documentation/arm/sunxi/README
> @@ -63,6 +63,10 @@ SunXi family
>          + User Manual
>            http://dl.linux-sunxi.org/A33/A33%20user%20manual%20release%201.1.pdf
>
> +      - Allwinner H2+ (sun8i)
> +        + No document available now, but is known to be working properly with
> +          H3 drivers and memory map.
> +
>        - Allwinner H3 (sun8i)
>          + Datasheet
>            http://dl.linux-sunxi.org/H3/Allwinner_H3_Datasheet_V1.0.pdf
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
> index 3975d0a..0c0f277 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.txt
> +++ b/Documentation/devicetree/bindings/arm/sunxi.txt
> @@ -13,5 +13,6 @@ using one of the following compatible strings:
>    allwinner,sun8i-a33
>    allwinner,sun8i-a83t
>    allwinner,sun8i-h3
> +  allwinner,sun8i-h2plus
>    allwinner,sun9i-a80
>    nextthing,gr8
> diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> index 2e2bde2..3647ad7 100644
> --- a/arch/arm/mach-sunxi/sunxi.c
> +++ b/arch/arm/mach-sunxi/sunxi.c
> @@ -63,6 +63,7 @@ static const char * const sun8i_board_dt_compat[] = {
>  	"allwinner,sun8i-a23",
>  	"allwinner,sun8i-a33",
>  	"allwinner,sun8i-a83t",
> +	"allwinner,sun8i-h2plus",
>  	"allwinner,sun8i-h3",
>  	NULL,
>  };
>
