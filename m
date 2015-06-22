From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 22 Jun 2015 18:04:18 +0000
Subject: [PATCH] Re: Linkstation Mini and __machine_arch_type problem,
 not booting since 3.8
In-Reply-To: <1434995379.5657.49.camel@dolka.fr>
References: <5583DD23.90505@arm.com> <1434716194.17448.28.camel@x60s>
 <20150619131315.GR7557@n2100.arm.linux.org.uk>
 <d6d361113992920900137899ae4d1f7b@dolka.fr>
 <20150619152552.GF2936@io.lakedaemon.net>
 <20150619154850.GT7557@n2100.arm.linux.org.uk>
 <20150619171346.GG2936@io.lakedaemon.net>
 <1434908275.5657.17.camel@dolka.fr>
 <20150622120829.GL2936@io.lakedaemon.net>
 <1434995379.5657.49.camel@dolka.fr>
Message-ID: <20150622180418.GO2936@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 22, 2015 at 07:49:39PM +0200, Benjamin Cama wrote:
> Le lundi 22 juin 2015 ?? 12:08 +0000, Jason Cooper a ??crit :
> > On Sun, Jun 21, 2015 at 07:37:55PM +0200, Benjamin Cama wrote:
> > > Le vendredi 19 juin 2015 ?? 17:13 +0000, Jason Cooper a ??crit :
> > > > On Fri, Jun 19, 2015 at 04:48:50PM +0100, Russell King - ARM Linux wrote:
> > > > > On Fri, Jun 19, 2015 at 03:25:52PM +0000, Jason Cooper wrote:
> > > > > > Let's just get the dts patch reviewed and merged first.  Russell
> > > > > > actually wrote the patch to do what he's describing for mach-dove.
> > > > > > 
> > > > > >   http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/309684.html
> > > > > > 
> > > > > > Although, it looks like it never got updated for submission...
> > > > > > 
> > > > > >   http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/311800.html
> > > > > 
> > > > > I do still have that patch, it's based on v4.0 though - like all my
> > > > > Dove work, it only builds on the previous -final kernel release.
> > > > 
> > > > Benjamin, after the dts, would you mind picking up Russell's dove patch and
> > > > making a cooresponding orion5x patch?
> > > 
> > > If the plan is to move to DT, is it still needed?
> > 
> > Sure, because orion5x is slow-going.  There aren't that many users.
> > Since we prefer tested patches, we need to grab the opportunity when it
> > comes a long.  It could be another year or more before we see more
> > patches for orion5x.  Fully converting orion5x to DT doesn't have a
> > schedule, it's as we encounter devs willing to post patches for their
> > boards.
> 
> According to rmk, letting their board break may be a quicker way to get
> the patches ;-) (and I agree with that: I wouldn't have moved to DT so
> fast if the build didn't break, it is a good incentive).

Oddly enough, that's how I got roped into being a maintainer.  :-P

> > The opportunity here is that you were just booting a legacy board file
> > on an orion5x SoC.  Therefore, you're in the best position to write/test
> > the irq change.
> 
> OK, I understand. I'll try to find the time to test the non-DT case and
> offer a patch. About Russell's one: how is the Signed-off-by going in
> this case? I put his and then mine?

Well, it looks like it applies cleanly to linux-next, so we can probably
take it as is.  My request was wrt the original patch I linked to, which
would have needed a rebase.

So, no need to do anything with rmk's patch.  Just use it as a base for
the orion5x case if you need to.

thx,

Jason.
