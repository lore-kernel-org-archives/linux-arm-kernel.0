From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 18 Aug 2013 22:25:15 +0200
Subject: [PATCH] arm64: wire in generic parport.h
In-Reply-To: <1376841688.11104.8.camel@t520.redhat.com>
References: <1376841688.11104.8.camel@t520.redhat.com>
Message-ID: <CAMuHMdXfXAaNeCAhmxTQb007Um7AjqRdF2=85t1Po_63T7XT5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 18, 2013 at 6:01 PM, Mark Salter <msalter@redhat.com> wrote:
> The arm64 port doesn't provide a parport.h which causes a build failure
> with some configurations:
>
>   drivers/parport/parport_pc.c:67:25: fatal error: asm/parport.h: No such file or directory
>    #include <asm/parport.h>
>
> This patch wires in the generic parport.h for arm64.

Can arm64 have a PC-style parport?

If not, you're better off disabling it in drivers/parport/Kconfig.

You will receive bonus points for introducing ARCH_MAY_HAVE_PC_PARPORT,
cfr. ARCH_MAY_HAVE_PC_FDC.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
