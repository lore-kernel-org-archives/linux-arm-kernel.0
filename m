From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 15 Jan 2016 12:24:16 +0100
Subject: [PATCH] spi: fix counting in spi-loopback-test code
In-Reply-To: <7416604.jejCLcpcOT@wuerfel>
References: <7416604.jejCLcpcOT@wuerfel>
Message-ID: <CAMuHMdUT500KRLsnxf_PzfU3sSxVACES-NZxENRcX+x_NxPeaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2016 at 9:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> These variables are always used uninitialized:
>
> drivers/spi/spi-loopback-test.c: In function 'spi_test_run_iter':
> drivers/spi/spi-loopback-test.c:768:17: warning: 'rx_count' may be used uninitialized in this function [-Wmaybe-uninitialized]
> drivers/spi/spi-loopback-test.c:762:17: warning: 'tx_count' may be used uninitialized in this function [-Wmaybe-uninitialized]
>
> Adding an explicit initialization seems to be the only
> workable solution here, to make the code behave correctly
> and build without warning.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 84e0c4e5e2c4 ("spi: add loopback test driver to allow for spi_master regression tests")

Just noticed the same, so
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
