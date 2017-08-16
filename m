From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 16 Aug 2017 10:12:57 +0200
Subject: [PATCH] ARM: debug-ll: Add support for r8a7745
In-Reply-To: <1502814088-29767-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1502814088-29767-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <CAMuHMdXoYF28SrRKKc3=fvt9avoiKdthZzN-V7nGotB1gkt0ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabrizio,

On Tue, Aug 15, 2017 at 6:21 PM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Enable low-level debugging support for RZ/G1E (r8a7745). RZ/G1E uses
> SCIF4 for the debug console.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>

> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug

> @@ -1568,6 +1576,7 @@ config DEBUG_UART_PHYS
>         default 0xe6c40000 if DEBUG_RMOBILE_SCIFA0
>         default 0xe6c50000 if DEBUG_RMOBILE_SCIFA1
>         default 0xe6c80000 if DEBUG_RMOBILE_SCIFA4
> +       default 0xe6ee0000 if DEBUG_RCAR_GEN2_SCIF4

Please keep the list sorted by physical address.

>         default 0xe6e58000 if DEBUG_RCAR_GEN2_SCIF2
>         default 0xe6e60000 if DEBUG_RCAR_GEN2_SCIF0
>         default 0xe8008000 if DEBUG_R7S72100_SCIF2

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
