From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 23 Nov 2015 09:06:40 +0100
Subject: Build regressions/improvements in v4.4-rc2
In-Reply-To: <1448265679-7272-1-git-send-email-geert@linux-m68k.org>
References: <1448265679-7272-1-git-send-email-geert@linux-m68k.org>
Message-ID: <CAMuHMdVg9V3w4PNLUL2gY0P90Ftf188MKY=Z+9QwK2Bz_vN1mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 9:01 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.4-rc2[1] to v4.4-rc1[3], the summaries are:
>   - build errors: +11/-10

  + error: debugfs.c: undefined reference to `clk_round_rate':  =>
.text+0x38b054), .text+0x38af08), .text+0x364fb0)
  + error: debugfs.c: undefined reference to `clk_set_parent':  =>
.text+0x16d5d0)
  + error: debugfs.c: undefined reference to `clk_set_rate':  =>
.text+0x1f2334), .text+0x1285e0), .text+0x392fbc), .text+0x128820),
.text+0x3651a4), .text+0x394070), .text+0x167080), .text+0x3940fc),
.text+0x38b0cc), .text+0x171ddc), .text+0x36526c), .text+0x297834),
.text+0x128604)
  + error: last.c: undefined reference to `clk_round_rate':  =>
.text+0x71918), .text+0xd186c), .text+0x72ba0), .text+0x7e388),
.text+0x7ae88), .text+0x79668)
  + error: last.c: undefined reference to `clk_set_parent':  =>
.text+0xd3f38), .text+0xccde8), .text+0xd3f58), .text+0xd79c8)
  + error: last.c: undefined reference to `clk_set_rate':  =>
.text+0xcdc5c), .text+0xdc494), .text+0xd19a0), .text+0x79678),
.text+0xa7fd0), .text+0xd921c), .text+0xd3f64), .text+0x7ae98),
.text+0x71928), .text+0xd92a4), .text+0x7e398), .text+0x72bb0),
.text+0xd96b4), .text+0xdd2c4), .text+0xcae30)

arm-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/9622/ (256 out of 254 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/9597/ (255 out of 254 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
