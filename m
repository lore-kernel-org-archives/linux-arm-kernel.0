From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 11 Dec 2015 10:45:38 +0100
Subject: [PATCH/RFC 00/19] r8a7793, gose: Add i2c and audio support to
 device tree
In-Reply-To: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
References: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWh4t+-V=CbGpKWfWJLGrEtBhkEBmy__g9449Ay-St9nA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Fri, Dec 11, 2015 at 3:52 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> this series adds support to r8a7793 and gose device trees for:
> * i2c and iic
> * rcar sound: first in PIO mode then using DMA
>
> i2c support is a pre-requisite for rcar sound support.

This series looks fine, when comparing the resulting DTS of
r8a7793 and r8a7791, and taking into account the i2c/iic alias differences.

Except for the missing audmapp.

You can add my
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
to all but 8.

> Unfortunately there appears to be some problem with DMA
> for rcar sound that I have been unable to track down. On booting I see:
>
> rcar_sound ec500000.sound: dma allocate failed
> rcar_sound ec500000.sound: ssi[0] fallback to PIO mode
> rcar_sound ec500000.sound: ssi[1] fallback to PIO mode
> rcar_sound ec500000.sound: probed
>
> I would appreciate any insights regarding the above.

Missing periperi?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
