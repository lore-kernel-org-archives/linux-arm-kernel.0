From: horms@verge.net.au (Simon Horman)
Date: Wed, 14 Jan 2015 09:29:24 +0900
Subject: [GIT PULL] Renesas ARM Based SoC sh73a0 CCF Updates for v3.20
In-Reply-To: <CAMuHMdUgfKQtbjB81_bw8XLGL_zrwNxWt32f7v52KOdb7bNo5A@mail.gmail.com>
References: <cover.1419809955.git.horms+renesas@verge.net.au>
 <20150112223415.GJ22090@quad.lixom.net>
 <20150113003823.GC27284@verge.net.au>
 <CAMuHMdUgfKQtbjB81_bw8XLGL_zrwNxWt32f7v52KOdb7bNo5A@mail.gmail.com>
Message-ID: <20150114002923.GB30021@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 09:12:53AM +0100, Geert Uytterhoeven wrote:
> On Tue, Jan 13, 2015 at 1:38 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Mon, Jan 12, 2015 at 02:34:15PM -0800, Olof Johansson wrote:
> >> On Mon, Dec 29, 2014 at 10:46:58AM +0900, Simon Horman wrote:
> >> > Hi Olof, Hi Kevin, Hi Arnd,
> >> >
> >> > Please consider these Renesas ARM based SoC sh73a0 CCF updates for v3.20.
> >> >
> >> >
> >> > The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> >> >
> >> >   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> >> >
> >> > are available in the git repository at:
> >> >
> >> >   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-sh73a0-ccf-for-v3.20
> >> >
> >> > for you to fetch changes up to 09bd745b555c262d1e2c851777317f3adf3cf3d4:
> >> >
> >> >   ARM: shmobile: sh73a0: disable legacy clock initialization (2014-12-21 17:09:25 +0900)
> >>
> >> This could really have been sliced slightly differently with the drivers/clk
> >> change going in a drivers branch, but that might be a bit too messy given that
> >> this is better done as a mostly-atomic switch over.
> >>
> >> I've merged this into next/drivers as a whole now. Please be careful with
> >> conflicts against this branch with other new additions this cycle.
> >
> > Thanks. The motivation for this branch arrangement was indeed
> > the atomic switch over.
> 
> Please correct me if I'm wrong, but IMHO there's no atomicity needed here,
> as this won't be used until sh73a0 multi-platform support is in.

Ok, it seems that I was slightly mistaken. But we are working towards
multi-platform support for v3.20, right?

Could you take a moment to look at what is currently queued up in
the sh73a0-multiplatform-for-v3.20 branch, which is based on this
pull-request and see if you think any re-arrangement of that branch
is in order.

To be clear, I'm not suggesting changing this pull-request which has
already been accepted.

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
