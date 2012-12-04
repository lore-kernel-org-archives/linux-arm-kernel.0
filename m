From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 Dec 2012 16:43:36 +0000
Subject: [PATCH 3/3] MMC: sdhci-dove: allow GPIOs to be used for card
 detection on Dove
In-Reply-To: <87zk1tg5tc.fsf@octavius.laptop.org>
References: <E1TbgcZ-0007Kt-35@rmk-PC.arm.linux.org.uk>
 <20121123083117.GA25754@S2100-06.ap.freescale.net>
 <20121123085726.GK5764@n2100.arm.linux.org.uk>
 <20121123121422.GA26168@S2100-06.ap.freescale.net>
 <20121123125507.GO5764@n2100.arm.linux.org.uk>
 <871ufh8lza.fsf@octavius.laptop.org>
 <Pine.LNX.4.64.1211260955070.11501@axis700.grange>
 <87y5hfhrwg.fsf@octavius.laptop.org>
 <Pine.LNX.4.64.1212041651500.26918@axis700.grange>
 <87zk1tg5tc.fsf@octavius.laptop.org>
Message-ID: <20121204164336.GI14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 04, 2012 at 11:06:39AM -0500, Chris Ball wrote:
> Hi Guennadi,
> 
> On Tue, Dec 04 2012, Guennadi Liakhovetski wrote:
> >> They both sound pretty attractive.  Maybe we start out with (1), which
> >> would create a patch we could more reasonably send to stable@ to get
> >> slot-gpio handling the reset during transfers properly in older kernels,
> >> and then refactor into (2) later?
> >
> > Just posted 3 patches for this, have a look if that's what you were 
> > thinking about. Not sure though why this is needed for stable, but I'm 
> > probably just missing some crucial information on the topic.
> 
> Thanks!  I'll take a look.  I agree that this isn't definitely needed
> in -stable, but I'm glad we have the option if someone finds that their
> host isn't functioning after card removal during a transfer.
> 
> Russell, are you happy with switching sdhci-dove over to slot-gpio with
> this patchset?

I'd rather not until I've moved my cubox kernel tree to v3.7 (when it's
out.)  Keeping stuff straight between that tree and mainline is far from
easy - I'm having to maintain two independent patches for each change,
one against each kernel tree, one gets tested (the one in the cubox tree)
the other (against mainline) does not.
