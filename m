From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 28 Jun 2013 09:53:04 +0200
Subject: [PATCH] ARM: zImage: fix path to fonts which moved to lib/fonts
In-Reply-To: <1372363940-13023-1-git-send-email-khilman@linaro.org>
References: <1372363940-13023-1-git-send-email-khilman@linaro.org>
Message-ID: <CAMuHMdVoqKTwgYLCu2ktcWEOYHy+jGo4YZ7ithAgQ6EN0Nhnqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 27, 2013 at 10:12 PM, Kevin Hilman <khilman@linaro.org> wrote:
> commit 1affee67 (lib: Move fonts from drivers/video/console/ to lib/fonts/)
> moved fonts from drivers/video/console/ to lib/fonts, but the ARM zImage
> build still references the old location.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>
> ---
> Found due to build failures on ARM in next-20130627.
>
> Rather than go through the ARM tree, this should probably be included
> with the original series from Geert.

Thanks! Sorry for missing this.

There's a similar one in the unicore32 boot code, and a few stale references
in comments and documentation. I'll fold all of these in the original commit.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
