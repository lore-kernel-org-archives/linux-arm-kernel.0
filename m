From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 30 Mar 2011 20:15:06 +0100
Subject: [PATCH V5 3/4] ARM: Xilinx: base header files and assembly macros
In-Reply-To: <201103301529.03648.arnd@arndb.de>
References: <1301444651-18008-1-git-send-email-john.linn@xilinx.com>
	<201103301344.45307.arnd@arndb.de>
	<f4872ed7-b6e4-4050-9445-5176f5aa961a@VA3EHSMHS017.ehs.local>
	<201103301529.03648.arnd@arndb.de>
Message-ID: <20110330191506.GD2939@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2011 at 03:29:03PM +0200, Arnd Bergmann wrote:
> On Wednesday 30 March 2011, John Linn wrote:
> > Yes that makes sense.  We don't have immediate plans for PCI and 
> > I was assuming when we add PCI we would need to change that.  
> > 
> > If you think I shouldn't put it off then I'll fix it now.  My 
> > preference was to get the platform supported, then add more features.
> 
> Getting it fixed properly depends a bit on the PCI implementation.
> I've been planning to clean up this part of the ARM architecture
> for some time and I can probably do it for one more platform when
> I get to it.
> 
> My idea for the multiplatform kernel is to have a global I/O space
> window (maybe 1 MB) that is in the same location in the virtual
> address space all the time, so any platform that wants to support
> PCI with direct-mapped I/O space can simply map it in there
> at boot time.

And how do you deal with PCMCIA implementations where each socket has
its own separate IO space, each maybe several MB large and may be spread
across several MB of memory with the PCMCIA attribute and PCMCIA memory
spaces interspersed.  Remember that PCMCIA drivers assume PCI/ISA IO
support.

What about platforms which have a real ISA IO space in addition to the
PCMCIA IO spaces?

Things aren't as simple as you'd like them to be, and sometimes changing
this stuff changes userland too (think PCMCIA needing the IO regions
declared to it from userspace during boot.)
