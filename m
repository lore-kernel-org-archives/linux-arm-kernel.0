From: horms@verge.net.au (Simon Horman)
Date: Wed, 20 Apr 2016 08:53:22 +1000
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v4.6
In-Reply-To: <CAMuHMdUJmZyAmn4HUdQTNVTTTnx2Z_W0fz96WcqB__z+XYcs_A@mail.gmail.com>
References: <cover.1460339328.git.horms+renesas@verge.net.au>
 <CAMuHMdUwuabK2Ajo5dMWEf014Xvk-1WYz4YBTw1jVScrTKSx0g@mail.gmail.com>
 <20160411230253.GB1589@verge.net.au>
 <20160418041206.GC3578@verge.net.au>
 <CAMuHMdUJmZyAmn4HUdQTNVTTTnx2Z_W0fz96WcqB__z+XYcs_A@mail.gmail.com>
Message-ID: <20160419225321.GC9826@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 09:23:10AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Mon, Apr 18, 2016 at 6:12 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Tue, Apr 12, 2016 at 08:02:54AM +0900, Simon Horman wrote:
> >> On Mon, Apr 11, 2016 at 09:11:19AM +0200, Geert Uytterhoeven wrote:
> >> > On Mon, Apr 11, 2016 at 3:52 AM, Simon Horman
> >> > <horms+renesas@verge.net.au> wrote:
> >> > > Hi Olof, Hi Kevin, Hi Arnd,
> >> > >
> >> > > Please consider these Renesas ARM based SoC fixes for v4.6.
> >> > >
> >> > >
> >> > > Allow serial to work once again on the Porter board (Revision B) which
> >> > > does not have the oscillator in question mounted.
> >> >
> >> > Have you tested this on Porter?
> >>
> >> I don't have working access to a porter at this time.
> >>
> >> > I believe there's another change to be made for this revert to actually work,
> >> > cfr. "[PATCH] ARM: dts: r8a7791: Don't disable referenced optional clocks"
> >> > (https://lkml.org/lkml/2016/4/6/350)
> >>
> >> Ok, understood.
> >>
> >> Could someone verify that?
> >
> > I have added "ARM: dts: r8a7791: Don't disable referenced optional clocks"
> > to the fixes-for-v4.6 branch and plan to push it in a fresh renesas-next
> > tag a little later today.
> 
> Thanks!
> 
> I would queue
> 
>     ARM: dts: r8a7791: Don't disable referenced optional clocks
> 
> before
> 
>     Revert "ARM: dts: porter: Enable SCIF_CLK frequency and pins"
> 
> to preserve bisectability. So please reorder these two commits.

Thanks, I have reordered the commits as you suggest.

> > I would appreciate any review and/or testing on porter of that branch.
> 
> I've provided my Reviewed-By in the original thread.

Thanks, got it.
