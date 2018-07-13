From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 13 Jul 2018 10:33:17 +0200
Subject: [PATCH/RFC] ARM: shmobile: Always enable ARCH_TIMER on SoCs with
 A7 and/or A15
In-Reply-To: <CAMuHMdUrgP=YOrgeEnpQ0XVOoC_8Dz9Lt2FJ4P5GKb53KRNpNw@mail.gmail.com>
References: <20180712160857.31471-1-geert+renesas@glider.be>
 <20180713080823.l4tng6oclhr6nxrh@verge.net.au>
 <CAMuHMdUrgP=YOrgeEnpQ0XVOoC_8Dz9Lt2FJ4P5GKb53KRNpNw@mail.gmail.com>
Message-ID: <CAMuHMdUsHHDo_2unzUZN9W0kY2p5YW+yGkfsdXE-8ZHuBAuxnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Fri, Jul 13, 2018 at 10:19 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, Jul 13, 2018 at 10:08 AM Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Jul 12, 2018 at 06:08:57PM +0200, Geert Uytterhoeven wrote:
> > > R-Mobile APE6, R-Car Gen2, and RZ/G1 SoCs have Cortex-A7 and/or
> > > Cortex-A15 CPU cores, all of which have ARM architectured timers.
> > >
> > > Force use of the ARM architectured timer on these SoCs.
> > > This allows to:
> > >   - Remove the calls to shmobile_init_delay() from the corresponding
> > >     machine vectors,
> > >   - Remove a check in timer setup specific to R-Car Gen2,
> > >   - Remove a check in shmobile_init_delay().
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > on which boards did you test this?
>
> On APE6EVM and Koelsch (R-Car M2-W).
> I can give it a spin on a few more remote R-Car Gen2 boards if you want.

I don't expect any issues, as shmobile_defconfig already enables
CONFIG_HAVE_ARM_ARCH_TIMER, and shmobile_init_delay() was already
a no-op in that case.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
