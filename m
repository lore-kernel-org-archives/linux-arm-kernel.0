From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 23 Feb 2018 10:27:16 +0100
Subject: [PATCH 6/6] arm64: dts: renesas: r8a77965: Add #interrupt-cells
 property
In-Reply-To: <1519326370-15805-7-git-send-email-jacopo+renesas@jmondi.org>
References: <1519326370-15805-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519326370-15805-7-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <CAMuHMdUSS_kFU+Zg40UHvtJ=PteftQW_tvViAr-d4r+jmVNfNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 22, 2018 at 8:06 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Add "#interrupt-cells" property and "interrupt-controller" label to
> "interrupt-controller at e61c0000" device node.
>
> This silences the following DTC compiler warnings:
> Warning (interrupts_property): Missing interrupt-controller or
> interrupt-map property in /soc/interrupt-controller at e61c0000
> Warning (interrupts_property): Missing #interrupt-cells in
> interrupt-parent /soc/interrupt-controller at e61c000
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> @@ -316,6 +316,8 @@
>                 };
>
>                 intc_ex: interrupt-controller at e61c0000 {
> +                       #interrupt-cells = <2>;
> +                       interrupt-controller;
>                         reg = <0 0xe61c0000 0 0x200>;
>                         /* placeholder */

(bikeshedding) Should the placeholder be at the top of the node?

>                 };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
