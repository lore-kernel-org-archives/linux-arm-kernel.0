From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 19 Jul 2016 14:02:53 +0200
Subject: [PATCH] Fix shmobile build with CONFIG_SMP=n
In-Reply-To: <20160719115703.GJ1041@n2100.armlinux.org.uk>
References: <20160719115703.GJ1041@n2100.armlinux.org.uk>
Message-ID: <CAMuHMdWfqbv4MXuThRPL2hsdN4Hq53Ng=1cp8DBB7o7XGzM9Zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Jul 19, 2016 at 1:57 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> Shmobile currently fails to build when CONFIG_SMP is disabled:
>
> arch/arm/mach-shmobile/built-in.o: In function `shmobile_smp_init_fallback_ops':
> pm-rcar-gen2.c:(.init.text+0x744): undefined reference to `platform_can_secondary_boot'
> make[1]: *** [vmlinux] Error 1
>
> Fix this by providing a stub for this function.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Arnd send a smaller one https://patchwork.kernel.org/patch/9207413/,
which seems have fallen through the cracks.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
