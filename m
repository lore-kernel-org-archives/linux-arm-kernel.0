From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 21 Aug 2011 13:59:44 -0400 (EDT)
Subject: [PATCH] arm/imx: use Kconfig choice for low-level debug UART
	selection
In-Reply-To: <20110821091851.GI12028@n2100.arm.linux.org.uk>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
	<1313729819-30301-1-git-send-email-shawn.guo@linaro.org>
	<20110819063533.GR31404@pengutronix.de>
	<20110819110940.GC8918@e102144-lin.cambridge.arm.com>
	<20110819113937.GS31404@pengutronix.de>
	<20110821091851.GI12028@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1108211355580.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 21 Aug 2011, Russell King - ARM Linux wrote:

> On Fri, Aug 19, 2011 at 01:39:37PM +0200, Sascha Hauer wrote:
> > On Fri, Aug 19, 2011 at 12:09:41PM +0100, Will Deacon wrote:
> > > Sascha,
> > > 
> > > On Fri, Aug 19, 2011 at 07:35:33AM +0100, Sascha Hauer wrote:
> > > > On Fri, Aug 19, 2011 at 12:56:59PM +0800, Shawn Guo wrote:
> > > > > Now that the DEBUG_LL UART can be selected by a Kconfig choice,
> > > > > simplify the #ifdefery in debug-macro.S and add entries to the
> > > > > top-level Kconfig.debug instead.
> > > > 
> > > > I'm unsure whether I like this. The ifdeffery does not look very good,
> > > > but the Kconfig snippet is not shorter, also it is in generic arm code
> > > > and not i.MX specific. The old way also makes sure that we do not
> > > > compile in incompatible lowlevel debug code.
> > > 
> > > But it's an unfortunate hinderence to a single zImage kernel which we can
> > > only solve sensibly in the generic ARM code.
> > 
> > My problem is that if this option is enabled the kernel will not run
> > on any other SoC except the one being selected here, at least when
> > earlyprintk is passed on the command line.
> 
> I never liked the idea of coupling this into earlyprintk - and I think
> I said so at the time.  I'll say it again:
> 
> The LL DEBUG stuff is there to be able to do low level "it won't boot"
> debugging.  It's not there as a user option.  You are supposed to know
> exactly what you are doing when using the option.
> 
> If we're going to start having earlyprintk be an argument against this,
> I'll simply rip out the earlyprintk coupling to LL debug, and people
> can go back to patching printk.c to make this work.

But we need a functional earlyprintk.  It has to be usable by simple 
_users_ who are not developers.  ARM is not going to remain this obscur 
embedded architecture forever.

> > One could argue
> > that this option is for people who exactly know what they do only.
> 
> It _IS_ there for people who know what they're doing.  That's something
> I keep on saying about the LL debug stuff.  It's there to allow people
> to debug the early startup of the kernel.  It's not there for users.

That is not sufficient.


Nicolas
