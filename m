From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 21 Oct 2013 16:40:15 -0400 (EDT)
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution,
 or is there something better?
In-Reply-To: <52658EBC.8020800@wwwdotorg.org>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020220839.GT2443@sirena.org.uk> <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <52658EBC.8020800@wwwdotorg.org>
Message-ID: <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Oct 2013, Stephen Warren wrote:

> On 10/21/2013 02:00 AM, Nicolas Pitre wrote:
> ...
> > The idea of some firmware to abstract hardware differences in order to 
> > greatly simplify kernel development and maintenance comes up with some 
> > regularity.  In other words, you are far from being the first one to 
> > suggest that.
> > 
> > However this needs some reality check.
> > 
> > Every hardware system has its share of complexity that the software has 
> > to deal with.
> > 
> > If that complexity is not in the kernel, it has to be in the firmware.  
> > Given we already struggles to have proper and bug free hardware support 
> > in the kernel today, even with all the debugging aid and peer review 
> > available from the kernel community, I really don't see how you'd manage 
> > to make it any less complex in some firmware implementation.
> 
> True. Hiding all the HW details sucks in some ways.
> 
> So, if we have chosen not to do that, and instead have the kernel know
> all the details of the HW, then why not simply do that? What do we get
> from DT that we don't get from board files? The driver complexity still
> all needs to be present in the kernel.

Driver complexity: obviously.

DT is only meant to abstract away the configuration part.

> The only thing we can move out is some of the board-specific
> parameterization data. That might reduce the code-size of kernel board
> files a bit (or rather, eliminate them),

That is effectively the point of DT.

> but taking the big picture into
> account, observe that we make life a lot more difficult for distros,
> since they need to get the device tree from somewhere. Distros now are
> forced to work out which DTB goes with which board,

This is not a new problem.  Before you had to figure out which kernel 
would go with which board.

> or perhaps we need
> to define a firmware interface to obtain the DTB and pass it to the
> kernel.

That's the bootloader's job.  Nothing magical actually: just have U-Boot 
or whatever load the DTB from some flash area.

> It'd be a lot simpler just to embed the data into the kernel.

For one target, this is indeed the simplest way.

> I
> think we can still have a hack-free, churn-free, multi-platform kernel
> without requiring DT, but by using board files.

I kinda agree with you, but this is too late for that now.

We have DT, and the best way forward is to fix the process which is, 
arguably, somewhat obstructive and broken at the moment.


Nicolas
