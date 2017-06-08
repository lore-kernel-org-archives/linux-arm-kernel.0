From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 8 Jun 2017 10:26:46 +0200
Subject: [PATCH] ARM: debug-ll: Add support for r8a7743
In-Reply-To: <1496908117-19368-1-git-send-email-chris.paterson2@renesas.com>
References: <1496908117-19368-1-git-send-email-chris.paterson2@renesas.com>
Message-ID: <CAMuHMdUg2Ox7ATSBKMiCua=VekEaoPZLpyQXGg=45XWV+12imA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Thu, Jun 8, 2017 at 9:48 AM, Chris Paterson
<chris.paterson2@renesas.com> wrote:
> Enable low-level debugging support for RZ/G1M (r8a7743). RZ/G1M uses
> SCIF0 for the debug console, like most of the R-Car Gen2 SoCs.

Thanks for your patch!

While the recommended debug method these days is "earlycon", DEBUG_LL is
indeed still useful to debug issues before earlycon is initialized.
Let's hope you will never encounter such issues on arm64, which doesn't
have DEBUG_LL per policy decision...

> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -895,12 +895,13 @@ choice
>                   via SCIF2 on Renesas R-Car H1 (R8A7779).
>
>         config DEBUG_RCAR_GEN2_SCIF0
> -               bool "Kernel low-level debugging messages via SCIF0 on R8A7790/R8A7791/R8A7792/R8A7793"
> -               depends on ARCH_R8A7790 || ARCH_R8A7791 || ARCH_R8A7792 || ARCH_R8A7793
> +               bool "Kernel low-level debugging messages via SCIF0 on R8A7743/R8A7790/R8A7791/R8A7792/R8A7793"

This line is becoming a bit long, and it'll only become worse in the future.
What about "Kernel low-level debugging messages via SCIF0 on R-Car Gen2"?
The full list of SoCs is still available in the extended help text.

> +               depends on ARCH_R8A7743 || ARCH_R8A7790 || ARCH_R8A7791 || \
> +                       ARCH_R8A7792 || ARCH_R8A7793
>                 help
>                   Say Y here if you want kernel low-level debugging support
> -                 via SCIF0 on Renesas R-Car H2 (R8A7790), M2-W (R8A7791), V2H
> -                 (R8A7792), or M2-N (R8A7793).
> +                 via SCIF0 on Renesas RZ/G1M (R8A7743), R-Car H2 (R8A7790),
> +                 M2-W (R8A7791), V2H (R8A7792), or M2-N (R8A7793).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
