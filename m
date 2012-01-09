From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Jan 2012 13:21:01 +0000
Subject: [PATCH] ARM: PXA: Zipit Z2: Fix oops in z2_power_off
In-Reply-To: <201201091338.29680.marek.vasut@gmail.com>
References: <1326011616-3546-1-git-send-email-anarsoul@gmail.com>
 <201201091313.31535.marek.vasut@gmail.com>
 <20120109121712.GN21765@n2100.arm.linux.org.uk>
 <201201091338.29680.marek.vasut@gmail.com>
Message-ID: <20120109132100.GO21765@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2012 at 01:38:29PM +0100, Marek Vasut wrote:
> > On Mon, Jan 09, 2012 at 01:13:31PM +0100, Marek Vasut wrote:
> > > > 2012/1/9 Marek Vasut <marek.vasut@gmail.com>:
> > > > >> Nope, it does not work. Looks like device disables power on memory
> > > > >> in deepsleep.
> > > > > 
> > > > > Why?
> > > > 
> > > > In deepsleep PXA27x deasserts SYS_EN pin, and looks like when it's
> > > > deasserted there's no power on SDRAM (on Zipit). Just guess.
> > > 
> > > Then maybe implement suspend-to-disk ? There was a patch for omap on the
> > > list, maybe it's even merged.
> > 
> > What are hell you going on about? 
> 
> Cool your jets Russell.
> 
> > Why would someone want to even try
> > implementing suspend-to-disk in the power off hook?
> 
> I'm not talking about the powerdown hook anymore, but a way how to avoid it as 
> much as possible via standard means.

Maybe you should state that you are deviating from the subject of this
email thread to aid your readers understanding?

> > Why would you even
> > want to try to preserve the system state in a power off hook?
> 
> Not in poweroff hook. Btw. I'm still convinced the bootloader should handle this 
> -- the powerdown should just reset the thing and tell bootloader to deepsleep 
> it.

Why should the boot loader be involved?  The boot loader is all about
bringing the system _up_, not taking it down.
