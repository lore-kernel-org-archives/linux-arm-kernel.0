From: horms@verge.net.au (Simon Horman)
Date: Thu, 5 Dec 2013 11:50:04 +0900
Subject: [PATCH 00/04] ARM: shmobile: Use SoC suffix for INTC compat string
In-Reply-To: <CANqRtoQ4fsCm=-uw8BgN48wFs_iTaG-H_kjDvcZssJXZqE8VTA@mail.gmail.com>
References: <20131127231450.29081.98054.sendpatchset@w520>
 <20131128064555.GA14878@verge.net.au>
 <CANqRtoQ4fsCm=-uw8BgN48wFs_iTaG-H_kjDvcZssJXZqE8VTA@mail.gmail.com>
Message-ID: <20131205025001.GF21443@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 08:21:42PM +0100, Magnus Damm wrote:
> On Thu, Nov 28, 2013 at 7:45 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Nov 28, 2013 at 08:14:50AM +0900, Magnus Damm wrote:
> >> ARM: shmobile: Use SoC suffix for INTC compat string
> >>
> >> [PATCH 01/04] ARM: shmobile: Use sh73a0 suffix for INTC compat string
> >> [PATCH 02/04] ARM: shmobile: Use r8a7740 suffix for INTC compat string
> >> [PATCH 03/04] ARM: shmobile: Use r8a7778 suffix for INTC compat string
> >> [PATCH 04/04] ARM: shmobile: Use r8a7779 suffix for INTC compat string
> >>
> >> Update the DTS for INTC irqpin devices to include the SoC in the compat string.
> >>
> >> Both IRQC and INTC irqpin need documentation for the DT bindings, and this
> >> will happen in incremental patches.
> >
> > I have posted some patches for that a few moments ago :)
> 
> Thanks for that!
> 
> > I am curious to if it is intentional that this series replaces
> > the use of less-specific compat strings with more specific ones
> > while the recent update to the r8a7790 supplemented the
> > less-specific renesas,irqc comat string with the more-specific
> > renesas,irqc-r8a7790 compat string.
> >
> > i.e.
> >         before: "renesas,intc-irqpin"
> >         after:  "renesas,intc-irqpin-sh73a0"
> >
> >         as opposed to
> >
> >         before: "renesas,irqc"
> >         after: "renesas,irqc-r8a7790", "renesas,irqc"
> 
> My intention is to keep them the same. I just checked the intc-irqpin
> patches but they seem to be following the same style as IRQC. On which
> SoC did you observe this difference?

Sorry, ignore this. I was confused.
