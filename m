From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sat, 30 Aug 2014 11:32:30 +0200
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: Enable shmobile platforms
In-Reply-To: <3598124.ze8sbSR9ui@wuerfel>
References: <1409234429-1916-1-git-send-email-geert+renesas@glider.be>
 <1965890.bT7bZyQJt8@amdc1032> <3598124.ze8sbSR9ui@wuerfel>
Message-ID: <CAMuHMdXXUrq3tsiaEym_uuoiYXNt66c5sm+1mSAfX6cHgMbEOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, Aug 29, 2014 at 10:11 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> A related problem that I think is more significant is that
> some platforms 'select' a particular driver and when you
> disable the platform, that driver is suddenly removed from the
> defconfig for all other platforms as well. This has bitten
> us a few times in the past, and I'd really like to fix those
> cases first.

Indeed. "select" is evil, and has a devastating effect on minimal
defconfigs (lots of churn and nasty surprises like the one you mentioned).

So it actually makes more sense to derive multi_v7_defconfig
from the individual platform's defconfigs.
I also have a script for that, which I wrote to create m68k's multi_defconfig
a long time ago:
https://github.com/geertu/linux-scripts/blob/master/linux-config-merge

In the long run, I think creating defconfigs from DTS is the way to go.
Extracting dependencies from the build system (both Makefile and
the myriad of complex dependencies in Kconfig) are the biggest hurdles to
solve.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
