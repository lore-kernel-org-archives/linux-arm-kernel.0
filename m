From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 20 Jul 2017 09:00:41 +0200
Subject: [PATCH] powerpc/asm/cacheflush: Cleanup cacheflush function params
In-Reply-To: <20170720062850.2195-1-matthew.brown.dev@gmail.com>
References: <20170720062850.2195-1-matthew.brown.dev@gmail.com>
Message-ID: <CAMuHMdVxnqD-90fDH+dqo8iJ94etcLHih27cqdVppi_AbFzbbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 8:28 AM, Matt Brown <matthew.brown.dev@gmail.com> wrote:
> The cacheflush prototypes currently use start and stop values and each
> call requires typecasting the address to an unsigned long.
> This patch changes the cacheflush prototypes to follow the x86 style of
> using a base and size values, with base being a void pointer.
>
> All callers of the cacheflush functions, including drivers, have been
> modified to conform to the new prototypes.
>
> The 64 bit cacheflush functions which were implemented in assembly code
> (flush_dcache_range, flush_inval_dcache_range) have been translated into
> C for readability and coherence.
>
> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>

>  drivers/spi/spi-bfin5xx.c                    | 10 +++---
>  drivers/usb/musb/blackfin.c                  |  6 ++--

These are used on blackfin, so changing them without changing the blackfin
cache ops will break the build.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
