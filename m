From: tony@atomide.com (Tony Lindgren)
Date: Mon, 15 Aug 2016 09:07:22 -0700
Subject: [PATCH 0/3] ARM: omap: fix 4.7 gpmc networking regression
In-Reply-To: <2fde63f3-62b1-75a0-524a-f858ff1de459@ti.com>
References: <1469362260-20066-1-git-send-email-johan@kernel.org>
 <20160802103505.GD28140@atomide.com>
 <9cf04231-091c-4ac3-bfb8-8d8be3d591eb@ti.com>
 <20160803080149.GB15860@localhost>
 <2fde63f3-62b1-75a0-524a-f858ff1de459@ti.com>
Message-ID: <20160815160722.GQ28140@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roger Quadros <rogerq@ti.com> [160803 02:56]:
> On 03/08/16 11:01, Johan Hovold wrote:
> > On Wed, Aug 03, 2016 at 10:46:24AM +0300, Roger Quadros wrote:
> >> On 02/08/16 13:35, Tony Lindgren wrote:
> >>> * Johan Hovold <johan@kernel.org> [160724 05:11]:
> >>>> Networking is currently broken for Overo boards due to a regression in
> >>>> 4.7. I bisected it down to
> >>>>
> >>>> 	d2d00862dfbb ("memory: omap-gpmc: Support general purpose input
> >>>> 	for WAITPINs")
> >>> ...
> >>>
> >>>> Note that simply fixing the Overo NAND issue would fix the Overo
> >>>> networking regression, but by restoring the 4.6 gpmc-probe behaviour
> >>>> similar regressions on other OMAP systems are also avoided.
> >>>
> >>> Roger, got a better fix in mind?
> >>>
> >>
> >> Nope. I'll take patch 1 in my omap-gpmc queue for v4.8.
> >> Thanks for the fixes Johan.
> > 
> > Now that 4.7 has been released, you may want to consider adding a stable
> > tag also for the first patch to avoid similar issues on other systems
> > when they get updated to 4.7-stable.
> > 
> 
> Yes, that was my plan as well.

OK and I'm now finally applying the dts fixes into omap-for-v4.8/fixes.
Sorry for the delay.

Tony
