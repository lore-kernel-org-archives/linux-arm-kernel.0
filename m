From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 11 Sep 2015 09:12:17 +0200
Subject: [PATCH/RFC v2 net-next 3/4] ravb: Document binding for r8a7795 SoC
In-Reply-To: <1441936878-18290-4-git-send-email-horms+renesas@verge.net.au>
References: <1441936878-18290-1-git-send-email-horms+renesas@verge.net.au>
 <1441936878-18290-4-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWY+8Cv9ZnnzMcSYskFfArues8EnWgMiCMnQ16sN1TW_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Fri, Sep 11, 2015 at 4:01 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> --- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
> +++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
> @@ -6,8 +6,11 @@ interface contains.
>  Required properties:
>  - compatible: "renesas,etheravb-r8a7790" if the device is a part of R8A7790 SoC.
>               "renesas,etheravb-r8a7794" if the device is a part of R8A7794 SoC.
> +             "renesas,etheravb-r8a7795" if the device is a part of R8A7795 SoC.
>  - reg: offset and length of (1) the register block and (2) the stream buffer.
> -- interrupts: interrupt specifier for the sole interrupt.
> +- interrupts: interrupt specifiers.
> +             One for each entry in interrupt-names the R8A7795 SoC;

... for the R8A7795 SoC

> +             One entry for a multiplexed interrupt otherwise.
>  - phy-mode: see ethernet.txt file in the same directory.
>  - phy-handle: see ethernet.txt file in the same directory.
>  - #address-cells: number of address cells for the MDIO bus, must be equal to 1.
> @@ -18,6 +21,9 @@ Required properties:
>  Optional properties:
>  - interrupt-parent: the phandle for the interrupt controller that services
>                     interrupts for this device.
> +- interrupt-names: One entry per interrupt named "ch%u".
> +                  For the R8A7795 SoC this property is mandatory,
> +                  and "ch0" through "ch24" are mandatory.

This suggests the single multiplexed interrupt on R-Car Gen2 can be called
"ch0". Is that what you want? I know the driver doesn't care.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
