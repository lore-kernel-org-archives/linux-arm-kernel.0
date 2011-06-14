From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 14 Jun 2011 22:32:08 +0200
Subject: [RFC,PATCH] Cleanup PC parallel port Kconfig
In-Reply-To: <20110614190850.GA13526@linux-mips.org>
References: <20110614190850.GA13526@linux-mips.org>
Message-ID: <BANLkTikuVsFS-UbS+Dap2Zy-f1+qLc1TLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2011 at 21:08, Ralf Baechle <ralf@linux-mips.org> wrote:
> The PC parallel port Kconfig as acquired one of those messy terms to
> describe it's architecture dependencies:
>
> ? ? ? depends on (!SPARC64 || PCI) && !SPARC32 && !M32R && !FRV && \
> ? ? ? ? ? ? ? (!M68K || ISA) && !MN10300 && !AVR32 && !BLACKFIN
>
> This isn't just ugly - it also almost certainly describes the dependencies
> too coarse grainedly. ?This is an attempt at cleaing the mess up.

> --- a/arch/m68k/Kconfig.mmu
> +++ b/arch/m68k/Kconfig.mmu
> @@ -399,6 +399,7 @@ config ISA
> ? ? ? ?bool
> ? ? ? ?depends on Q40 || AMIGA_PCMCIA
> ? ? ? ?default y
> + ? ? ? select PARPORT_PC

Why do you select PARPORT_PC here instead of HAVE_PC_PARPORT?

Gr{oetje,eeting}s,

? ? ? ? ? ? ? ? ? ? ? ? Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
? ? ? ? ? ? ? ? ? ? ? ? ? ?? ?? -- Linus Torvalds
