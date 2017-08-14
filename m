From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 14 Aug 2017 15:48:19 +0200
Subject: [PATCH 02/10] ARM: dts: r8a7779: Use R-Car GPIO Gen1 fallback
 compat string
In-Reply-To: <1502181568-12299-3-git-send-email-horms+renesas@verge.net.au>
References: <1502181568-12299-1-git-send-email-horms+renesas@verge.net.au>
 <1502181568-12299-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdXEsN1GzFUYy_Zcs5L2TXm7n-m6e1A9kxpZA=jHNhfaDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 8, 2017 at 10:39 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Use newly added R-Car GPIO Gen1 fallback compat string
> in place of now deprecated non-generation specific
> R-Car GPIO fallback compat string in DT of r8a7779 SoC.
>
> This should have no run-time effect as the driver matches against
> the per-SoC compat string before considering the fallback compat string.

That is not correct: the driver does not match against "renesas,gpio-r8a7779".
Hence this breaks using a new DTS and an old kernel (which we may decide not
to care about for R-Car Gen1, though).
But at least the DTS change should be postponed until commit d10bbd156926e65d
("gpio: rcar: add gen[123] fallback compatibility strings") has hit mainline.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
