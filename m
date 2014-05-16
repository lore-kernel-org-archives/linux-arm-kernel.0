From: horms@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 15:13:34 +0900
Subject: [PATCH] ARM: shmobile: Use shmobile_init_late() on r8a7740
In-Reply-To: <CANqRtoSAHF1uX42LPGhK5r7sFPHDKEaBCFWaP2yqdagRhHFejA@mail.gmail.com>
References: <20140511231050.19908.86623.sendpatchset@w520>
 <CAMuHMdW4-r8khvk-hJcx1OXqwT0nGsVm3zEnmW6TUhyeDRPWdg@mail.gmail.com>
 <20140513081019.GA10412@verge.net.au>
 <20140516040844.GA2503@verge.net.au>
 <CANqRtoSKosY3HLc-Hgbf2_ToDeL71QzqamWEd97xX9iaD=2oUQ@mail.gmail.com>
 <20140516044548.GA7185@verge.net.au>
 <CANqRtoSAHF1uX42LPGhK5r7sFPHDKEaBCFWaP2yqdagRhHFejA@mail.gmail.com>
Message-ID: <20140516061329.GB7185@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 01:48:00PM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Fri, May 16, 2014 at 1:45 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Fri, May 16, 2014 at 01:39:11PM +0900, Magnus Damm wrote:
> >> Hi Simon,
> >>
> >> On Fri, May 16, 2014 at 1:08 PM, Simon Horman <horms@verge.net.au> wrote:
> >> > On Tue, May 13, 2014 at 05:10:20PM +0900, Simon Horman wrote:
> >> >> On Mon, May 12, 2014 at 09:42:15AM +0200, Geert Uytterhoeven wrote:
> >> >> > On Mon, May 12, 2014 at 1:10 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> >> >> > > From: Magnus Damm <damm+renesas@opensource.se>
> >> >> > >
> >> >> > > Hook up ->init_late for r8a7740 to initialize Suspend-to-RAM
> >> >> > > and CPUIdle in case of C-code less board support for r8a7740.
> >> >> > >
> >> >> > > Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> >> >> >
> >> >> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >> >>
> >> >> Thanks, I will queue this up.
> >> >
> >> > Hi Magnus, Hi Geert,
> >> >
> >> > As I am currently doing some work for the r8a7779
> >> > I am wondering if a change like this one is appropriate for that SoC.
> >> > If so I'll cook one up.
> >>
> >> Yes, we want all SoCs to be converted over. Please take care that some
> >> DTS change may be needed to specify maximum frequency, so this may
> >> require a DTB update for the user. Which makes it less nice user
> >> experience for legacy code - if we care about that at this point. But
> >> legacy code also often tends to use early devices and other stuff, so
> >> this probably affects DT SoC code and DT reference board code mostly.
> >
> > Does CPU frequency affect this patch (shmobile_init_late) as
> > well as the ones to use shmobile_init_delay?
> 
> Oops, wrong patch from my side. =) Please ignore my comment.
> 
> But we still want the SoCs to be converted over.

Thanks. I'll start with a patch for the r8a7779.
