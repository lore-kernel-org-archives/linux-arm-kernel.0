From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Oct 2015 16:18:22 +0100
Subject: [PATCH] clocksource; armada-370: implement ARM delay timer
In-Reply-To: <20151019151550.GF26387@lunn.ch>
References: <E1ZoByF-0002E9-9O@rmk-PC.arm.linux.org.uk>
 <20151019151550.GF26387@lunn.ch>
Message-ID: <20151019151822.GJ32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 05:15:50PM +0200, Andrew Lunn wrote:
> On Mon, Oct 19, 2015 at 04:03:31PM +0100, Russell King wrote:
> > Implement an ARM delay timer to be used for udelay() on Armada 37x
> > platforms.  This allows us to skip the delay loop calibration at boot,
> > saving 180ms on the boot time of the kernel (which is around 10%).
> > 
> > It also means that udelay() will be unaffected by CPU frequency changes
> > when cpufreq is enabled on these platforms.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  arch/arm/Kconfig                         |  1 +
> >  arch/arm/plat-orion/time.c               | 13 +++++++++++++
> >  drivers/clocksource/time-armada-370-xp.c | 14 ++++++++++++++
> >  3 files changed, 28 insertions(+)
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index f3dfca632a8a..194569c23271 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -10,6 +10,7 @@ config ARM
> >  	select ARCH_SUPPORTS_ATOMIC_RMW
> >  	select ARCH_USE_BUILTIN_BSWAP
> >  	select ARCH_USE_CMPXCHG_LOCKREF
> > +	select ARCH_WANT_FRAME_POINTERS
> >  	select ARCH_WANT_IPC_PARSE_VERSION
> >  	select BUILDTIME_EXTABLE_SORT if MMU
> >  	select CLONE_BACKWARDS
> 
> Hi Russell
> 
> Does this hunk belong in the patch?

Bah.  Neither does the other change to arch/arm/mach-mvebu/time.c !
Slip up using git commit -a after _manually_ adding just the clocksource
file.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
