From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Sep 2015 15:56:00 +0100
Subject: Steps to submit a new arch/arm port
In-Reply-To: <144297172.JfjI0hNJ9J@wuerfel>
References: <56001B78.2090001@free.fr> <2206647.QPrIpE2UC0@wuerfel>
 <56016780.5080104@free.fr> <144297172.JfjI0hNJ9J@wuerfel>
Message-ID: <20150922145600.GZ21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2015 at 04:51:48PM +0200, Arnd Bergmann wrote:
> On Tuesday 22 September 2015 16:36:48 Mason wrote:
> > +config ARCH_TANGOX
> > +	bool "Sigma Designs Tango"
> > +	select CLKDEV_LOOKUP
> > +	select HAVE_CLK
> > +	select HAVE_SMP
> > +	select ARCH_REQUIRE_GPIOLIB
> > +	select ARCH_HAS_CPUFREQ
> > +	select CLKSRC_MMIO
> > +	select GENERIC_CLOCKEVENTS
> > +	select GENERIC_IRQ_CHIP
> > +	select ARCH_HAS_HOLES_MEMORYMODEL
> > +	select SPARSE_IRQ
> > +	help
> > +	  Support for Sigma Designs Tango platform.
> > +
> >  endchoice
> 
> Move this to the platform Kconfig file. Also, drop all the
> 'select' statements that are implied by ARCH_MULTIPLATFORM
> and ARCH_MULTI_V7

And any remaining select statements should be sorted alphanumerically,
and that goes for everywhere, especially when introducing a new select
statement.

> > diff --git a/arch/arm/mach-tangox/Kconfig b/arch/arm/mach-tangox/Kconfig
> > new file mode 100644
> > index 000000000000..aba4eef9227c
> > --- /dev/null
> > +++ b/arch/arm/mach-tangox/Kconfig
> > @@ -0,0 +1,48 @@
> > +if ARCH_TANGOX
> > +
> > +config UNCOMPRESS_INCLUDE
> > +	string
> > +	default "debug/uncompress.h"
> 
> Better do this like everyone else.
> 
> > +config ARM_L1_CACHE_SHIFT
> > +	int
> > +	default 5
> 
> This conflicts with the other definition of the same symbol.

Indeed - I really don't like that Kconfig doesn't error out over this
kind of thing.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
