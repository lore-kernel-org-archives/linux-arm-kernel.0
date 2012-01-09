From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 9 Jan 2012 13:38:29 +0100
Subject: [PATCH] ARM: PXA: Zipit Z2: Fix oops in z2_power_off
In-Reply-To: <20120109121712.GN21765@n2100.arm.linux.org.uk>
References: <1326011616-3546-1-git-send-email-anarsoul@gmail.com>
 <201201091313.31535.marek.vasut@gmail.com>
 <20120109121712.GN21765@n2100.arm.linux.org.uk>
Message-ID: <201201091338.29680.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Mon, Jan 09, 2012 at 01:13:31PM +0100, Marek Vasut wrote:
> > > 2012/1/9 Marek Vasut <marek.vasut@gmail.com>:
> > > >> Nope, it does not work. Looks like device disables power on memory
> > > >> in deepsleep.
> > > > 
> > > > Why?
> > > 
> > > In deepsleep PXA27x deasserts SYS_EN pin, and looks like when it's
> > > deasserted there's no power on SDRAM (on Zipit). Just guess.
> > 
> > Then maybe implement suspend-to-disk ? There was a patch for omap on the
> > list, maybe it's even merged.
> 
> What are hell you going on about? 

Cool your jets Russell.

> Why would someone want to even try
> implementing suspend-to-disk in the power off hook?

I'm not talking about the powerdown hook anymore, but a way how to avoid it as 
much as possible via standard means.

> Why would you even
> want to try to preserve the system state in a power off hook?

Not in poweroff hook. Btw. I'm still convinced the bootloader should handle this 
-- the powerdown should just reset the thing and tell bootloader to deepsleep 
it.

> 
> Nothing much you've said in this thread makes sense so far.  What is
> the point you're trying to raise, other than a personal dislike for
> using the deep sleep mode to simulate an apparant 'power off' condition?

See above.
