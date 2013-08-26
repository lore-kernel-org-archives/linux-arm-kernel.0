From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Aug 2013 20:06:46 +0100
Subject: what about mach-shark?
In-Reply-To: <CACRpkdb2QQEAt_bpVv9sifEuDfs_8XdDbUtQ9R+cXA-vBWMKmA@mail.gmail.com>
References: <alpine.LFD.2.00.1107041545480.14596@xanadu.home>
 <CACRpkdb2QQEAt_bpVv9sifEuDfs_8XdDbUtQ9R+cXA-vBWMKmA@mail.gmail.com>
Message-ID: <20130826190646.GG6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 26, 2013 at 09:04:05PM +0200, Linus Walleij wrote:
> On Mon, Jul 4, 2011 at 10:08 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> 
> > Is this used?
> 
> This still goes unanswered after two years.
> 
> Alexander, are you compiling and booting recent kernels on the Shark?
> 
> I recently had a dream to convert some platforms and eventually
> all of the arch/arm machines to GENERIC_CLOCKEVENTS and

You're not going to achieve that pipedream.  Really.  There are platforms
still around which don't have enough timers to be able to do anything but
periodic interrupts at a fixed rate - with nothing available as a clock
source other than the kernel jiffy counter incremented by that periodic
interrupt (which would create a circular dependency.)

Remember: with periodic interrupts, the clock source is read at every
interrupt to discover how many jiffies have passed since the previous
interrupt - which is useless if you have just a single reloading timer.
