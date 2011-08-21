From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 21 Aug 2011 14:28:46 -0400 (EDT)
Subject: [PATCH] arm/imx: use Kconfig choice for low-level debug UART
	selection
In-Reply-To: <20110821181728.GH28546@n2100.arm.linux.org.uk>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
	<1313729819-30301-1-git-send-email-shawn.guo@linaro.org>
	<20110819063533.GR31404@pengutronix.de>
	<20110819110940.GC8918@e102144-lin.cambridge.arm.com>
	<20110819113937.GS31404@pengutronix.de>
	<20110821091851.GI12028@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211355580.20358@xanadu.home>
	<20110821181728.GH28546@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1108211425400.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 21 Aug 2011, Russell King - ARM Linux wrote:

> On Sun, Aug 21, 2011 at 01:59:44PM -0400, Nicolas Pitre wrote:
> > On Sun, 21 Aug 2011, Russell King - ARM Linux wrote:
> > > I never liked the idea of coupling this into earlyprintk - and I think
> > > I said so at the time.  I'll say it again:
> > > 
> > > The LL DEBUG stuff is there to be able to do low level "it won't boot"
> > > debugging.  It's not there as a user option.  You are supposed to know
> > > exactly what you are doing when using the option.
> > > 
> > > If we're going to start having earlyprintk be an argument against this,
> > > I'll simply rip out the earlyprintk coupling to LL debug, and people
> > > can go back to patching printk.c to make this work.
> > 
> > But we need a functional earlyprintk.  It has to be usable by simple 
> > _users_ who are not developers.  ARM is not going to remain this obscur 
> > embedded architecture forever.
> 
> I repeat: that is not the point of DEBUG_LL.  DEBUG_LL is there for
> *developers* to debug their initial board bringup.  Nothing else.
> 
> I repeat: I'm not going to have DEBUG_LL buggered up by do-gooders
> and people wanting BIOS shite and then have to re-invent it so that
> we can have decent debugging again.  That's NOT going to happen.  No
> way at all.
> 
> > > > One could argue
> > > > that this option is for people who exactly know what they do only.
> > > 
> > > It _IS_ there for people who know what they're doing.  That's something
> > > I keep on saying about the LL debug stuff.  It's there to allow people
> > > to debug the early startup of the kernel.  It's not there for users.
> > 
> > That is not sufficient.
> 
> Tough.  That's the way it is and it has to be lived with.  Early board
> bring up has absolutely nothing to do with users.  If users are doing
> early board bringup, they are kernel developers by definition.

So be it if you insist.  We'll then have to invent a better 
infrastructure in parallel to be able to do early enough serial output 
for users, both for earlyprintk and the zImage decompressor.


Nicolas
