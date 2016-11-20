From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 20 Nov 2016 19:44:39 +0000
Subject: [PATCH] arm: spin one more cycle in timer-based delays
In-Reply-To: <CAD=FV=WQCfpvVrn64LjxfeG2S7peU5ZWKVGsRyU83-zNCVZmxg@mail.gmail.com>
References: <582B0F61.6030903@free.fr> <20161118120630.GJ13470@arm.com>
 <20161118125409.GK1041@n2100.armlinux.org.uk>
 <582F0DD2.3030805@free.fr> <20161119071702.GA25647@afzalpc>
 <20161119110301.GQ1041@n2100.armlinux.org.uk>
 <58309A02.4030804@free.fr>
 <CAD=FV=WQCfpvVrn64LjxfeG2S7peU5ZWKVGsRyU83-zNCVZmxg@mail.gmail.com>
Message-ID: <20161120194439.GY1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 20, 2016 at 11:18:48AM -0800, Doug Anderson wrote:
> Hi,
> 
> On Sat, Nov 19, 2016 at 10:29 AM, Mason <slash.tmp@free.fr> wrote:
> >> Exactly - and the reason for that (as I've explained several times in
> >> the past) the "standard" software delay loop calibrated against the
> >> timer interrupt is _always_ going to be short.
> >
> > OK, so loop-based delays are known to be short. Would you or Linus
> > accept a patch that adds a X% cushion *in the implementation* ?
> >
> > You are saying "people shouldn't expect udelay(10) to delay at least
> > 10 ?s, thus they should write udelay(10+N)".
> >
> > Why not hide that implementation detail inside the implementation,
> > so as not to force the pessimization on every other implementation
> > behind the udelay/ndelay wrapper?

Try sending Linus a patch for it.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
