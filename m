From: horms@verge.net.au (Simon Horman)
Date: Wed, 15 Jan 2014 08:53:27 +0900
Subject: [PATCH V2 0/3] SoC and board integration for QSPI on
 r8a7791/koelsch
In-Reply-To: <CAMuHMdWYqv41RwyZROmuSeD9F9RfFFyOuCxn+66NgJ3MbhsJvw@mail.gmail.com>
References: <1389524433-2823-1-git-send-email-geert@linux-m68k.org>
 <20140114004638.GE18217@verge.net.au>
 <CAMuHMdWYqv41RwyZROmuSeD9F9RfFFyOuCxn+66NgJ3MbhsJvw@mail.gmail.com>
Message-ID: <20140114235327.GC8769@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 10:05:28AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Tue, Jan 14, 2014 at 1:46 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Sun, Jan 12, 2014 at 12:00:29PM +0100, Geert Uytterhoeven wrote:
> >> This series adds support for the Spansion s25fl512s SPI FLASH on the
> >> r8a7791-based Koelsch board. It is based on
> >> renesas-devel-v3.13-rc7-20140109v2, with Valentine's i2c pinctrl and
> >> Laurent's SCIF DT work applied on top.
> >> [Simon: I don't know in which order you will merge these. If you want me
> >>  to rebase my patches, just ask! Thanks!]
> >
> > I see that Laruent has taken patch 1/4.
> >
> > Is it possible for me to merge patches 2-4/4 independently of that patch?
> > That is, can I apply them and still produce a kernel that boots. If so,
> > that is my preferred option. If not I will talk to Laurent about a branch
> > to base things on.
> 
> Yes you can. Note that RSPI still won't be enabled without "spi: rspi: Remove
> dependency on DMAE for SHMOBILE" (which has now landed in the spi tree).
> And with that patch applied, you'll get warnings like:
> 
>     pinmux core: sh-pfc does not support function qspi
>     sh-pfc pfc-r8a7791: invalid function qspi in map table
>     pinmux core: sh-pfc does not support function qspi
>     sh-pfc pfc-r8a7791: invalid function qspi in map table
> 
> which are harmless, and spi will still work, as that's the default pin config
> anyway.

Thanks, that is perfectly fine.

> > Also, I would like to get an Ack from Magnus.
> 
> Sure.
> 
> Thanks!
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
