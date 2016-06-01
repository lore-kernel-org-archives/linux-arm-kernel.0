From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 1 Jun 2016 09:47:12 +0200
Subject: [PATCH 04/13] ARM: shmobile: r8a7792: basic SoC support
In-Reply-To: <2352834.cNFKgiQiVO@wasted.cogentembedded.com>
References: <13205049.n7pM8utpHF@wasted.cogentembedded.com>
 <2352834.cNFKgiQiVO@wasted.cogentembedded.com>
Message-ID: <CAMuHMdXtqwby6_E-izx=h=ryQfH2LsXvNyP+14rnaF-TksmEbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Wed, Jun 1, 2016 at 12:18 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> --- renesas.orig/arch/arm/mach-shmobile/Kconfig
> +++ renesas/arch/arm/mach-shmobile/Kconfig
> @@ -86,6 +86,11 @@ config ARCH_R8A7791
>         select ARCH_RCAR_GEN2
>         select I2C
>
> +config ARCH_R8A7792
> +       bool "R-Car V2H (R8A77920)"
> +       select ARCH_RCAR_GEN2
> +       select I2C

I2c is selected for the other SoCs because of regulator-quirk-rcar-gen2.
I do not have schematics for Blanche, so I don't know if it has DA9063 and
DA9210 regulators sharing the same interrupt.
If yes, you should make sure regulator-quirk-rcar-gen2 is updated for Blanche,
and built.
If no, you should drop the select.

If the above is clarified:

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
